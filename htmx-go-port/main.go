package main

import (
	"fmt"
	"net/http"

	"github.com/go-chi/chi"
)

func main() {
    r := chi.NewRouter()

	// Serve static files from the 'static' directory
	fs := http.FileServer(http.Dir("static"))
	r.Handle("/static/*", http.StripPrefix("/static/", fs))

	r.Get("/", func(w http.ResponseWriter, r *http.Request) {
		http.ServeFile(w, r, "static/index.html")
	})

	r.Get("/about", func(w http.ResponseWriter, r *http.Request) {
		http.ServeFile(w, r, "static/about.html")
	})

	r.Get("/data", func(w http.ResponseWriter, r *http.Request) {
		http.ServeFile(w, r, "static/data.html")
	})

	r.Get("/contact", func(w http.ResponseWriter, r *http.Request) {
		http.ServeFile(w, r, "static/contact.html")
	})

    // Start the server on port 3000
    err := http.ListenAndServe(":3000", r)
	if err != nil {
		fmt.Println("Error starting server")
	}
}