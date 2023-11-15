package pages

import (
	"github.com/charmbracelet/log"
	"github.com/go-chi/chi/v5"
	"github.com/lu1a/portfolio-site/types"
)

func PageRouter(log log.Logger, config types.Config, r chi.Router) func(chi.Router) {
	return func(r chi.Router) {
		r.Route("/", HomepageHandler(log, config, r))
		// ...
	}
}
