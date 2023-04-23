package api

import (
	"encoding/json"
	"net/http"
	"strconv"
)

// define a struct to represent a data evidence
type evidence struct {
	rimID      int    "json:id"
	Name    string "json:name"
	Contact string "json:contact"
}

// define a slice to store the data evidences
var evidences []evidence

// function to start the api handler
func StartEvProvider() {
	http.HandleFunc("/api/ep", evidencesHandler)
}

// function to handle GET, POST, PUT, and DELETE requests for data evidences
func evidencesHandler(w http.ResponseWriter, r *http.Request) {
	switch r.Method {
	case "GET":
		getevidences(w, r)
	case "POST":
		createevidence(w, r)
	case "PUT":
		updateevidence(w, r)
	case "DELETE":
		deleteevidence(w, r)
	default:
		http.Error(w, "Method not allowed", http.StatusMethodNotAllowed)
	}
}

// function to retrieve all data evidences
func getevidences(w http.ResponseWriter, r *http.Request) {
	w.Header().Set("Content-Type", "application/json")
	json.NewEncoder(w).Encode(evidences)
}

// function to create a new data evidence
func createevidence(w http.ResponseWriter, r *http.Request) {
	var evidence evidence
	err := json.NewDecoder(r.Body).Decode(&evidence)
	if err != nil {
		http.Error(w, err.Error(), http.StatusBadRequest)
		return
	}
	evidences = append(evidences, evidence)
	w.WriteHeader(http.StatusCreated)
}

// function to update an existing data evidence
func updateevidence(w http.ResponseWriter, r *http.Request) {
	var evidence evidence
	err := json.NewDecoder(r.Body).Decode(&evidence)
	if err != nil {
		http.Error(w, err.Error(), http.StatusBadRequest)
		return
	}
	for i, p := range evidences {
		if p.ID == evidence.ID {
			evidences[i] = evidence
			return
		}
	}
	http.Error(w, "evidence not found", http.StatusNotFound)
}

// function to delete an existing data evidence
func deleteevidence(w http.ResponseWriter, r *http.Request) {

	id, err := strconv.Atoi(r.URL.Query().Get("id"))
	if err != nil {
		http.Error(w, err.Error(), http.StatusBadRequest)
		return
	}
	for i, p := range evidences {
		if p.ID == id {
			evidences = append(evidences[:i], evidences[i+1:]...)
			return
		}
	}
	http.Error(w, "evidence not found", http.StatusNotFound)
}
