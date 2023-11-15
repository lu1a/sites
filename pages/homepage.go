package pages

import (
	"net/http"
	"path"
	"text/template"

	"github.com/charmbracelet/log"
	"github.com/go-chi/chi/v5"
	"github.com/lu1a/portfolio-site/types"
)

func HomepageHandler(log log.Logger, config types.Config, r chi.Router) func(chi.Router) {
	return func(r chi.Router) {
		r.Get("/", func(w http.ResponseWriter, r *http.Request) {
			fp := path.Join("pages", "templates", "index.html")
			tmpl, err := template.ParseFiles(fp)
			if err != nil {
				http.Error(w, err.Error(), http.StatusInternalServerError)
				return
			}

			if err := tmpl.Execute(w, struct{}{}); err != nil {
				http.Error(w, err.Error(), http.StatusInternalServerError)
			}
		})
	}
	// ...

}
