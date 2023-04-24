package api

import (
	"encoding/json"
	"net/http"
	"strconv"
)

// define a struct to represent a data provider
type Provider struct {
	ID      int    "json:id"
	Name    string "json:name"
	Contact string "json:contact"
}

// define a slice to store the data providers
var providers []Provider

// function to start the api handler
func StartHandler() {
	http.HandleFunc("/api/dsd", providersHandler)
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

// function to retrieve all data providers
func getProviders(w http.ResponseWriter, r *http.Request) {
	w.Header().Set("Content-Type", "application/json")
	json.NewEncoder(w).Encode(providers)
}

// function to create a new data provider
func createProvider(w http.ResponseWriter, r *http.Request) {
	var provider Provider
	err := json.NewDecoder(r.Body).Decode(&provider)
	if err != nil {
		http.Error(w, err.Error(), http.StatusBadRequest)
		return
	}
	providers = append(providers, provider)
	w.WriteHeader(http.StatusCreated)
}

// function to update an existing data provider
func updateProvider(w http.ResponseWriter, r *http.Request) {
	var provider Provider
	err := json.NewDecoder(r.Body).Decode(&provider)
	if err != nil {
		http.Error(w, err.Error(), http.StatusBadRequest)
		return
	}
	for i, p := range providers {
		if p.ID == provider.ID {
			providers[i] = provider
			return
		}
	}
	http.Error(w, "Provider not found", http.StatusNotFound)
}

// function to delete an existing data provider
func deleteProvider(w http.ResponseWriter, r *http.Request) {

	id, err := strconv.Atoi(r.URL.Query().Get("id"))
	if err != nil {
		http.Error(w, err.Error(), http.StatusBadRequest)
		return
	}
	for i, p := range providers {
		if p.ID == id {
			providers = append(providers[:i], providers[i+1:]...)
			return
		}
	}
	http.Error(w, "Provider not found", http.StatusNotFound)
}
