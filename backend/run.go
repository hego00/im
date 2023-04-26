package backend

import (
	"fmt"
	"net/http"
	"sdg/backend/api"
	"time"
)

func Run() {

	// Start backend components and apis

	go api.StartEVB()
	// go api.StartDSD()
	// go api.StartPP()
	// go domibus.Connect()

	// Print status of backend initialization
	fmt.Println("Backend started successfully")

	// Open port and listen for requests
	http.ListenAndServe(":8080", nil)
	time.Sleep(1000)

	// Healthcheck apis and access point
	fmt.Println("Listening on port 8080")

}

func Stop() {

	// Stop backend components and apis

	// Print status of backend shutdown

}
