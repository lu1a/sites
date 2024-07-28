use askama::Template;
use axum::{
    http::StatusCode,
    response::{Html, IntoResponse, Response},
    routing::get,
    Router,
};
use tower_http::{services::ServeDir, trace::{TraceLayer, DefaultMakeSpan}};
use tracing_subscriber::{layer::SubscriberExt, util::SubscriberInitExt};

use std::{env, net::SocketAddr};

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
    let mut port_to_serve = "3000";
    let mut static_folder_name = "static";
    if args.len() > 1 {
        port_to_serve = &args[1];
    }
    if args.len() > 2 {
        static_folder_name = &args[2];
    }

    // build the app with some routes
    let app = Router::new()
        .nest_service("/static", ServeDir::new(static_folder_name))
        .route("/", get(index_handler))
        // logging so we can see what's going on
        .layer(
            TraceLayer::new_for_http()
                .make_span_with(DefaultMakeSpan::default().include_headers(true)),
        );

    // run it
    let listener = tokio::net::TcpListener::bind("0.0.0.0:".to_owned() + port_to_serve)
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

