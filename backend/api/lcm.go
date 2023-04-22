package api

import (
	"encoding/json"
	"net/http"
	"strconv"
)

// define a struct to represent a data lifecycle event
type lifecycle struct {
	ID      int    "json:id"
	Name    string "json:name"
	Contact string "json:contact"
}

// define a slice to store the data lifecycle events
var lifecycles []lifecycle

// function to start the api handler
func StartLifecycle() {
	http.HandleFunc("/api/lcm", lifecycleHandler)
}

// function to handle GET, POST, PUT, and DELETE requests for data lifecycle events
func lifecycleHandler(w http.ResponseWriter, r *http.Request) {
	switch r.Method {
	case "GET":
		getlifecycles(w, r)
	case "POST":
		createlifecycle(w, r)
	case "PUT":
		updatelifecycle(w, r)
	case "DELETE":
		deletelifecycle(w, r)
	default:
		http.Error(w, "Method not allowed", http.StatusMethodNotAllowed)
	}
}

// function to retrieve all data lifecycle events
func getlifecycles(w http.ResponseWriter, r *http.Request) {
	w.Header().Set("Content-Type", "application/json")
	json.NewEncoder(w).Encode(lifecycles)
}

// function to create a new data lifecycle event
func createlifecycle(w http.ResponseWriter, r *http.Request) {
	var lifecycle lifecycle
	err := json.NewDecoder(r.Body).Decode(&lifecycle)
	if err != nil {
		http.Error(w, err.Error(), http.StatusBadRequest)
		return
	}
	lifecycles = append(lifecycles, lifecycle)
	w.WriteHeader(http.StatusCreated)
}

// function to update an existing data lifecycle event
func updatelifecycle(w http.ResponseWriter, r *http.Request) {
	var lifecycle lifecycle
	err := json.NewDecoder(r.Body).Decode(&lifecycle)
	if err != nil {
		http.Error(w, err.Error(), http.StatusBadRequest)
		return
	}
	for i, l := range lifecycles {
		if l.ID == lifecycle.ID {
			lifecycles[i] = lifecycle
			w.WriteHeader(http.StatusNoContent)
			return
		}
	}
	w.WriteHeader(http.StatusNotFound)
}

// function to delete an existing data lifecycle event
func deletelifecycle(w http.ResponseWriter, r *http.Request) {
	id, err := strconv.Atoi(r.URL.Query().Get("id"))
	if err != nil {
		http.Error(w, err.Error(), http.StatusBadRequest)
		return
	}
	for i, l := range lifecycles {
		if l.ID == id {
			lifecycles = append(lifecycles[:i], lifecycles[i+1:]...)
			w.WriteHeader(http.StatusNoContent)
			return
		}
	}
	w.WriteHeader(http.StatusNotFound)
}
