package pages

import (
	"net/http"
	"net/mail"
	"path"
	"text/template"

	"github.com/charmbracelet/log"
	"github.com/go-chi/chi/v5"
	"github.com/jmoiron/sqlx"
	"github.com/lu1a/portfolio-site/types"
)

type TemplateData struct {
	DidSubmit     bool
	SubmitSuccess bool
}

func RecycleCloudLetterHandler(log log.Logger, db *sqlx.DB, config types.Config, r chi.Router) func(chi.Router) {
	return func(r chi.Router) {
		r.Get("/", func(w http.ResponseWriter, r *http.Request) {
			templateData := TemplateData{}
			templateData.DidSubmit = false
			templateData.SubmitSuccess = false

			fp := path.Join("pages", "templates", "recycleCloudLetter.html")
			tmpl, err := template.ParseFiles(fp)
			if err != nil {
				http.Error(w, err.Error(), http.StatusInternalServerError)
				return
			}

			if err := tmpl.Execute(w, templateData); err != nil {
				http.Error(w, err.Error(), http.StatusInternalServerError)
			}
		})
		r.Post("/", func(w http.ResponseWriter, r *http.Request) {
			email := r.FormValue("email")

			responseData := TemplateData{}
			responseData.DidSubmit = true
			responseData.SubmitSuccess = false

			if isValidEmail(email) {
				// TODO: add to db table of interested people
				responseData.SubmitSuccess = true
			}

			fp := path.Join("pages", "templates", "recycleCloudLetter.html")
			tmpl, err := template.ParseFiles(fp)
			if err != nil {
				http.Error(w, err.Error(), http.StatusInternalServerError)
				return
			}

			if err := tmpl.Execute(w, responseData); err != nil {
				http.Error(w, err.Error(), http.StatusInternalServerError)
			}
		})
	}
}

func isValidEmail(email string) bool {
	_, err := mail.ParseAddress(email)
	return err == nil
}
