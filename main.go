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

serviceloop:
	for {
		fmt.Println("Please enter the service you want to start: ")

		service, _ := reader.ReadString('\n')
		fmt.Printf("Starting '%s'", service)

		switch {
		case service == "backend\n":
			go backend.Run()
			break
		case service == "webapp":
			go webapp.Run()
			break
		case service == "wallet":
			go wallet.Run()
			break
		case service == "exit":
			fmt.Println("Exiting CLI")
			break serviceloop
		default:
			fmt.Println("Service not found")
		}

	}

}
