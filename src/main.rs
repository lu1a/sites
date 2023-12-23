use askama::Template;
use axum::{
    extract::State,
    http::StatusCode,
    response::{Html, IntoResponse, Response},
    routing::get,
    Router,
};
use sqlx::postgres::{PgPool, PgPoolOptions};
use tower_http::services::ServeDir;
use tracing_subscriber::{layer::SubscriberExt, util::SubscriberInitExt};

use std::time::Duration;

mod db;

#[tokio::main]
async fn main() {
    tracing_subscriber::registry()
        .with(
            tracing_subscriber::EnvFilter::try_from_default_env()
                .unwrap_or_else(|_| "example_templates=debug".into()),
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

    // build the app with some routes
    let app = Router::new()
        .nest_service("/static", ServeDir::new("static"))
        .route("/", get(index_handler))
        .route("/stats", get(stats_handler))
        .with_state(pool);

    // run it
    let listener = tokio::net::TcpListener::bind("0.0.0.0:3000")
        .await
        .unwrap();
    tracing::debug!("listening on {}", listener.local_addr().unwrap());
    axum::serve(listener, app).await.unwrap();
}

async fn index_handler() -> impl IntoResponse {
    let template = IndexTemplate {};
    HtmlTemplate(template)
}

#[derive(Template)]
#[template(path = "index.html")]
struct IndexTemplate {}

async fn stats_handler(State(pool): State<PgPool>) -> impl IntoResponse {
    let mut unique_ips_by_country: Vec<db::CountryCount> = Vec::new();
    
    match db::get_unique_ips_by_country(&pool).await {
        Ok(result) => {
            unique_ips_by_country = result;
        }
        Err(err) => {
            eprintln!("Error occurred: {}", err);
            // todo: handle the error appropriately, like returning an error response
        }
    }

    let template = StatsTemplate { unique_ips_by_country };

    HtmlTemplate(template)
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
