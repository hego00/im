package backend

import (
	"fmt"
	"sdg/backend/messages/exchange"
)

func Run() {

	fmt.Println("Backend started")
	fmt.Println(exchange.CreateResponse())

	// go as4
}
