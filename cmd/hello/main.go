package main

import (
	"fmt"
	"net/http"
	"os"

	"github.com/rs/zerolog"
)

func main() {
	logger := zerolog.New(os.Stdout)

	http.HandleFunc("/", Hello)

	if err := http.ListenAndServe(":8080", nil); err != nil {
		logger.Error().Err(err).Msg("stopping http listening")
	} else {
		logger.Info().Msg("shutting down http listener")
	}
}

func Hello(w http.ResponseWriter, r *http.Request) {
	fmt.Fprintf(w, "Hello, %s", r.URL.Path[1:])
}
