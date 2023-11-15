package dbpkg

import (
	"time"

	"github.com/jmoiron/sqlx"
)

type VisitorLog struct {
	ID                 *int      `json:"id"`
	ForUser            int       `db:"for_user" json:"for_user"`
	VisitedAt          time.Time `db:"visited_at" json:"visited_at"`
	URLPath            string    `db:"url_path" json:"url_path"`
	IPAddress          string    `db:"ip_address" json:"ip_address"`
	IPISP              string    `db:"ip_isp" json:"ip_isp"`
	IPCountry          *string   `db:"ip_country" json:"ip_country"`
	IPCity             *string   `db:"ip_city" json:"ip_city"`
	IPZip              *string   `db:"ip_zip" json:"ip_zip"`
	IPLatitude         *string   `db:"ip_latitude" json:"ip_latitude"`
	IPLongitude        *string   `db:"ip_longitude" json:"ip_longitude"`
	Browser            string    `db:"browser" json:"browser"`
	OperatingSystem    string    `db:"operating_system" json:"operating_system"`
	IsMobile           bool      `db:"is_mobile" json:"is_mobile"`
	RefererURL         string    `db:"referer_url" json:"referer_url"`
	PreferredLanguages string    `db:"preferred_languages" json:"preferred_languages"`
	Cookies            string    `db:"cookies" json:"cookies"`
	Body               string    `db:"body" json:"body"`
}

func InsertNewVisitorLog(db *sqlx.DB, logEntry *VisitorLog) error {
	query := `
        INSERT INTO visitor_log (
            for_user, visited_at, url_path, ip_address,
            ip_isp, ip_country, ip_city, ip_zip, ip_latitude,
			ip_longitude, browser, operating_system, is_mobile,
            referer_url, preferred_languages, cookies, body
        )
        VALUES (
            :for_user, :visited_at, :url_path, :ip_address,
            :ip_isp, :ip_country, :ip_city, :ip_zip, :ip_latitude,
			:ip_longitude, :browser, :operating_system, :is_mobile,
            :referer_url, :preferred_languages, :cookies, :body
        )
    `

	_, err := db.NamedExec(query, logEntry)
	if err != nil {
		return err
	}

	return nil
}

type CountryCount struct {
	Country string `db:"ip_country" json:"country"`
	IPCount int    `db:"ip_count" json:"count"`
}

func GetUniqueIPsByCountry(db *sqlx.DB) ([]CountryCount, error) {
	var countryCounts []CountryCount
	err := db.Select(&countryCounts,
		`SELECT
			ip_country,
			COUNT(DISTINCT ip_address) AS ip_count
		FROM
			visitor_log
		WHERE
			ip_country IS NOT NULL
		GROUP BY
			ip_country
		ORDER BY
			ip_count DESC`,
	)
	if err != nil {
		return countryCounts, err
	}

	return countryCounts, nil
}
