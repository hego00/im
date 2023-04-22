package api

import (
	"fmt"
	"net/http"
	"sdg/backend/utils"
	"sdg/backend/utils/database"
)

// function to start the api handler
func StartHandler() {
	http.HandleFunc("/api", apiHandler)
}

// function to handle api requests
func apiHandler(w http.ResponseWriter, r *http.Request) {
	