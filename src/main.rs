use askama::Template;
use axum::{
    extract::{State, FromRef},
    http::StatusCode,
    response::{Html, IntoResponse, Response},
    routing::get,
    Router,
};
use futures::lock::Mutex;
use sqlx::postgres::{PgPool, PgPoolOptions};
use tower_http::{services::ServeDir, trace::{TraceLayer, DefaultMakeSpan}};
use tracing_subscriber::{layer::SubscriberExt, util::SubscriberInitExt};

use std::{time::Duration, net::SocketAddr, i32, sync::Arc};

mod db;
mod ws_handler;

#[derive(Clone)]
struct AppState {
    db_state: DBState,
    ws_state: WSState,
}

#[derive(Clone)]
struct DBState {
    pool: PgPool,
}

// support converting an `AppState` in an `DBState`
impl FromRef<AppState> for DBState {
    fn from_ref(app_state: &AppState) -> DBState {
        app_state.db_state.clone()
    }
}

#[derive(Clone)]
struct WSState {
    shared_counter: Arc<Mutex<i32>>
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

    let db_connection_str = std::env::var("DB_CONNECTION_URL")
        .unwrap_or_else(|_| "postgres://postgres:password@localhost".to_string());

    // set up connection pool
    let pool = PgPoolOptions::new()
        .max_connections(5)
        .acquire_timeout(Duration::from_secs(3))
        .connect(&db_connection_str)
        .await
        .expect("can't connect to database");

    // my state variables to be updated via websocket
    let shared_counter = Arc::new(Mutex::new(0));

    let state = AppState {
        db_state: DBState {
            pool: pool,
        },
        ws_state: WSState {
            shared_counter: shared_counter,
        }
    };

    // build the app with some routes
    let app = Router::new()
        .nest_service("/static", ServeDir::new("static"))
        .route("/", get(index_handler))
        .route("/stats", get(stats_handler))
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

async fn index_handler() -> impl IntoResponse {
    let template = IndexTemplate {};
    HtmlTemplate(template)
}

#[derive(Template)]
#[template(path = "index.html")]
struct IndexTemplate {}

async fn stats_handler(State(db_state): State<DBState>) -> Result<impl IntoResponse, AppError> {
    let unique_ips_by_country: Vec<db::CountryCount> = db::get_unique_ips_by_country(&db_state.pool).await?;

    let template = StatsTemplate { unique_ips_by_country };

    Ok(HtmlTemplate(template))
}

#[derive(Template)]
#[template(path = "stats.html")]
struct StatsTemplate {
    unique_ips_by_country: Vec<db::CountryCount>,
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