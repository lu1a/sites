use askama::Template;
use axum::{
    extract::{State, FromRef},
    http::StatusCode,
    response::{Html, IntoResponse, Response},
    routing::get,
    Router,
};
use broadcaster::BroadcastChannel;
use futures::lock::Mutex;
use serde::{Serialize, Deserialize};
use tower_http::{services::ServeDir, trace::{TraceLayer, DefaultMakeSpan}};
use tracing_subscriber::{layer::SubscriberExt, util::SubscriberInitExt};

use std::{collections::HashMap, env, i32, net::SocketAddr, sync::Arc};

mod ws_handler;

#[derive(Clone)]
struct AppState {
    ws_state: WSState,
}

#[derive(Clone)]
struct WSState {
    sender_broadcaster: BroadcastChannel<String>,

    shared_counter: Arc<Mutex<i32>>,
    user_cursors: Arc<Mutex<HashMap<String, UserCursor>>>,
}

// support converting an `AppState` in an `ApiState`
impl FromRef<AppState> for WSState {
    fn from_ref(app_state: &AppState) -> WSState {
        app_state.ws_state.clone()
    }
}

#[tokio::main]
async fn main() {
    tracing_subscriber::registry()
        .with(
            tracing_subscriber::EnvFilter::try_from_default_env()
                .unwrap_or_else(|_| "tower_http=debug".into()),
        )
        .with(tracing_subscriber::fmt::layer())
        .init();
    
    // Get CLI args
    let args: Vec<String> = env::args().collect();
    let mut static_folder_name = "static";
    if args.len() > 1 {
        static_folder_name = &args[1];
    }

    // my state variables to be updated via websocket
    let sender_broadcaster = BroadcastChannel::new();
    let shared_counter = Arc::new(Mutex::new(0));
    let user_cursors = Arc::new(Mutex::new(HashMap::new()));

    let state = AppState {
        ws_state: WSState {
            sender_broadcaster: sender_broadcaster,
            shared_counter: shared_counter,
            user_cursors,
        }
    };

    // build the app with some routes
    let app = Router::new()
        .nest_service("/static", ServeDir::new(static_folder_name))
        .route("/", get(index_handler))
        .route("/ws", get(ws_handler::ws_handler))
        .with_state(state)
        // logging so we can see what's going on
        .layer(
            TraceLayer::new_for_http()
                .make_span_with(DefaultMakeSpan::default().include_headers(true)),
        );

    // run it
    let listener = tokio::net::TcpListener::bind("0.0.0.0:3000")
        .await
        .unwrap();
    tracing::debug!("listening on {}", listener.local_addr().unwrap());
    axum::serve(
        listener,
        app.into_make_service_with_connect_info::<SocketAddr>(),
    )
    .await
    .unwrap();
}

async fn index_handler(State(ws_state): State<WSState>) -> impl IntoResponse {
    let initial_counter = ws_handler::query_counter(ws_state.shared_counter).await;
    let template = IndexTemplate { initial_counter };
    HtmlTemplate(template)
}

#[derive(Template)]
#[template(path = "index.html")]
struct IndexTemplate {
    initial_counter: i32,
}

struct HtmlTemplate<T>(T);

impl<T> IntoResponse for HtmlTemplate<T>
where
    T: Template,
{
    fn into_response(self) -> Response {
        match self.0.render() {
            Ok(html) => Html(html).into_response(),
            Err(err) => (
                StatusCode::INTERNAL_SERVER_ERROR,
                format!("Failed to render template. Error: {err}"),
            )
                .into_response(),
        }
    }
}

// Error handling

// Make our own error that wraps `anyhow::Error`.
struct AppError(anyhow::Error);

// Tell axum how to convert `AppError` into a response.
impl IntoResponse for AppError {
    fn into_response(self) -> Response {
        (
            StatusCode::INTERNAL_SERVER_ERROR,
            format!("Something went wrong: {}", self.0),
        )
            .into_response()
    }
}

// This enables using `?` on functions that return `Result<_, anyhow::Error>` to turn them into
// `Result<_, AppError>`. That way we don't need to do that manually.
impl<E> From<E> for AppError
where
    E: Into<anyhow::Error>,
{
    fn from(err: E) -> Self {
        Self(err.into())
    }
}

#[derive(Clone, Debug, Serialize, Deserialize)]
struct UserCursor {
    x: f64,
    y: f64,
    emoji: String,
    client_generated_id: String,
}

impl UserCursor {
    // Constructor to create a new User instance
    fn new(x: f64, y: f64) -> Self {
        UserCursor {
            x,
            y,
            emoji: "question".to_string(),
            client_generated_id: String::new(),
        }
    }
}
