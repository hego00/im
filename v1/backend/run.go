package backend

import (
	"fmt"
	"sdg/backend/api"
)

func Run() {

	// ------ Start backend  apis

	// should apis be on different reports?
	// how to assign ports to optimize performance?
	fmt.Print("Starting backend apis...")
	api.StartEVB()
	api.StartDSD()
	// go api.StartPP()
	// http.ListenAndServe("localhost:8080", nil)

	// client1 := domibus.Connect()
	// client1.Send()

	// exchange.fetchRequestsfromDomibus()

	// Healthcheck apis and access point
	// fmt.Println("Listening on port 8080")

	// read input queryRequest from xml file
	// queryRequest := domibus.ReadQueryRequest("queryRequest.xmdomidomidomibus

	// process queryRequest and return queryResponse
	// queryResponse := domibus.ProcessQueryRequest(queryRequest)

	// fmt.Println(queryResponse)
	// exchange.CreateRequestInOutbox()
}

func Stop() {

	// Stop backend components and apis

	// Print status of backend shutdown

}
