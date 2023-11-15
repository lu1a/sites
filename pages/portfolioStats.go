package pages

import (
	"net/http"
	"path"
	"text/template"

	"github.com/charmbracelet/log"
	"github.com/go-chi/chi/v5"
	"github.com/jmoiron/sqlx"
	"github.com/lu1a/portfolio-site/dbpkg"
	"github.com/lu1a/portfolio-site/types"
)

type ResponseData struct {
	CountryCounts []dbpkg.CountryCount
}

func PortfolioStatsHandler(log log.Logger, db *sqlx.DB, config types.Config, r chi.Router) func(chi.Router) {
	return func(r chi.Router) {
		r.Get("/", func(w http.ResponseWriter, r *http.Request) {
			fp := path.Join("pages", "templates", "stats.html")
			tmpl, err := template.ParseFiles(fp)
			if err != nil {
				http.Error(w, err.Error(), http.StatusInternalServerError)
				return
			}

			var responseData ResponseData
			responseData.CountryCounts, err = dbpkg.GetUniqueIPsByCountry(db)
			if err != nil {
				http.Error(w, err.Error(), http.StatusInternalServerError)
				return
			}

			if err := tmpl.Execute(w, responseData); err != nil {
				http.Error(w, err.Error(), http.StatusInternalServerError)
			}
		})
	}
	// ...

}
