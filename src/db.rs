use sqlx::postgres::PgPool;
use chrono::NaiveDateTime;

#[derive(Debug, sqlx::FromRow)]
pub struct VisitorLog {
    pub id: Option<i32>,
    pub for_user: i32,
    pub visited_at: NaiveDateTime,
    pub url_path: String,
    pub ip_address: String,
    pub ip_isp: String,
    pub ip_country: Option<String>,
    pub ip_city: Option<String>,
    pub ip_zip: Option<String>,
    pub ip_latitude: Option<String>,
    pub ip_longitude: Option<String>,
    pub browser: String,
    pub operating_system: String,
    pub is_mobile: bool,
    pub referer_url: String,
    pub preferred_languages: String,
    pub cookies: String,
    pub body: String,
}

// pub async fn insert_new_visitor_log(pool: &PgPool, log_entry: &VisitorLog) -> Result<(), Error> {
//     sqlx::query(
//         r#"
//         INSERT INTO visitor_log (
//             for_user, visited_at, url_path, ip_address,
//             ip_isp, ip_country, ip_city, ip_zip, ip_latitude,
// 			ip_longitude, browser, operating_system, is_mobile,
//             referer_url, preferred_languages, cookies, body
//         )
//         VALUES (
//             $1, $2, $3, $4, $5, $6, $7, $8, $9, $10, $11, $12, $13, $14, $15, $16, $17
//         )
//         "#,
//     )
//     .bind(log_entry.for_user)
//     .bind(log_entry.visited_at)
//     .bind(&log_entry.url_path)
//     .bind(&log_entry.ip_address)
//     .bind(&log_entry.ip_isp)
//     .bind(&log_entry.ip_country)
//     .bind(&log_entry.ip_city)
//     .bind(&log_entry.ip_zip)
//     .bind(&log_entry.ip_latitude)
//     .bind(&log_entry.ip_longitude)
//     .bind(&log_entry.browser)
//     .bind(&log_entry.operating_system)
//     .bind(log_entry.is_mobile)
//     .bind(&log_entry.referer_url)
//     .bind(&log_entry.preferred_languages)
//     .bind(&log_entry.cookies)
//     .bind(&log_entry.body)
//     .execute(pool)
//     .await?;

//     Ok(())
// }

#[derive(Debug, sqlx::FromRow)]
pub struct CountryCount {
    pub country: String,
    pub count: i64,
}

pub async fn get_unique_ips_by_country(pool: &PgPool) -> Result<Vec<CountryCount>, anyhow::Error> {
    let country_counts: Vec<CountryCount> = sqlx::query_as(
        r#"
        SELECT
            ip_country AS country,
            COUNT(DISTINCT ip_address) AS count
        FROM
            visitor_log
        WHERE
            ip_country IS NOT NULL
        GROUP BY
            ip_country
        ORDER BY
            count DESC
        "#,
    )
    .fetch_all(pool)
    .await?;

    Ok(country_counts)
}
