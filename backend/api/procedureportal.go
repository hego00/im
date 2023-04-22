package api

import (
	"encoding/json"
	"net/http"
	"strconv"
)

// define a struct to represent a procedure
type Procedure struct {
	ID      int    "json:id"
	Name    string "json:name"
	Contact string "json:contact"
}


// define a slice to store the procedures
var procedures []Procedure

// function to start the api handler
func StartProcedurePortal() {
	http.HandleFunc("/api/pp", proceduresHandler)
}

// function to handle GET, POST, PUT, and DELETE requests for procedures
func proceduresHandler(w http.ResponseWriter, r *http.Request) {
	switch r.Method {
	case "GET":
		getprocedures(w, r)
	case "POST":
		startprocedure(w, r)
	case "PUT":
		updateprocedure(w, r)
	case "DELETE":
		deleteprocedure(w, r)
	default:
		http.Error(w, "Method not allowed", http.StatusMethodNotAllowed)
	}
}

// function to retrieve all procedures
func getprocedures(w http.ResponseWriter, r *http.Request) {
	w.Header().Set("Content-Type", "application/json")
	json.NewEncoder(w).Encode(procedures)
}

// be enacting a a procedure, I am looking for a service
// so this is essentially a request for a service
// function to create a new procedure 
func startprocedure(w http.ResponseWriter, r *http.Request) {
	var procedure Procedure
	err := json.NewDecoder(r.Body).Decode(&procedure)
	if err != nil {
		http.Error(w, err.Error(), http.StatusBadRequest)
		return
	}
	procedures = append(procedures, procedure)
	w.WriteHeader(http.StatusCreated)
}

// function to update an existing procedure
func updateprocedure(w http.ResponseWriter, r *http.Request) {
	var procedure Procedure
	err := json.NewDecoder(r.Body).Decode(&procedure)
	if err != nil {
		http.Error(w, err.Error(), http.StatusBadRequest)
		return
	}
	for i, p := range procedures {
		if p.ID == procedure.ID {
			procedures[i] = procedure
			w.WriteHeader(http.StatusNoContent)
			return
		}
	}
	http.Error(w, "Procedure not found", http.StatusNotFound)
}

// effectively remove the data you are storing on me
// function to delete an existing procedure
func deleteprocedure(w http.ResponseWriter, r *http.Request) {
	id, err := strconv.Atoi(r.URL.Query().Get("id"))
	if err != nil {
		http.Error(w, err.Error(), http.StatusBadRequest)
		return
	}
	for i, p := range procedures {
		if p.ID == id {
			procedures = append(procedures[:i], procedures[i+1:]...)
			w.WriteHeader(http.StatusNoContent)
			return
		}
	}
	http.Error(w, "Procedure not found", http.StatusNotFound)
}

