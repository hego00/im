package main

import (
	"bufio"
	"fmt"
	"os"
	"sdg/backend"
	"sdg/wallet"
	"sdg/webapp"
)

func main() {
	demo()
	// live()
}

func demo() {

	go backend.Run()
	// webapp.Run()
	// wallet.Run()

	liveControl()
}

func live() {
	backend.Run()
	webapp.Run()
	liveControl()
}

func liveControl() {

	reader := bufio.NewReader(os.Stdin)
	fmt.Println("Welcome!")
	fmt.Println("Please enter the service you want to start: ")

	service, _ := reader.ReadString('\n')
	fmt.Printf("Starting %s", service)

	switch {
	case service == "backend":
		backend.Run()
	case service == "webapp":
		webapp.Run()
	case service == "wallet":
		wallet.Run()
	default:
		fmt.Println("Service not found")
	}

}
