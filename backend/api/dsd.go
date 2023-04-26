package api

import (
	"encoding/json"
	"net/http"
)

// define a struct to represent a data provider
type Provider struct {
	ProviderIdentifier  string `json:"provider_identifier"`
	ProviderName        string `json:"provider_name"`
	ProviderVersion     string `json:"provider_version"`
	ProviderDescription string `json:"provider_description"`
}

// define a slice to store the data providers
var providers []Provider

// function to start the api handler
func StartHandler() {
	http.HandleFunc("/dsd", providersHandler)
}

// function to handle GET, POST, PUT, and DELETE requests for data providers
func providersHandler(w http.ResponseWriter, r *http.Request) {
	switch r.Method {
	case "GET":
		getProviders(w, r)
	// case "POST":
	// 	createProvider(w, r)
	// case "PUT":
	// 	updateProvider(w, r)
	// case "DELETE":
	// 	deleteProvider(w, r)
	default:
		http.Error(w, "Method not allowed", http.StatusMethodNotAllowed)
	}
}

// function to handle GET requests for data providers
func getProviders(w http.ResponseWriter, r *http.Request) {
	jsonBytes, err := json.Marshal(providers)
	if err != nil {
		http.Error(w, err.Error(), http.StatusInternalServerError)
		return
	}
	w.Header().Set("Content-Type", "application/json")
	w.Write(jsonBytes)

}
