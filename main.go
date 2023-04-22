package main

import (
	"bufio"
	"fmt"
	"os"
	"sdg/backend"
	"sdg/wallet"
	"sdg/webapp"
	"strings"
)

func main() {
	demo()
	// live()
}

func demo() {
	// start backend
	// display tests

	// start webapp
	// display tests

	// start wallet
	// display tests

	// admin console - messages, config files, etc

	// publish links to console

	// start liveControl
	liveControl()
	// cli commands
	// exit - links to system report to console
}

func liveControl() {
	reader := bufio.NewReader(os.Stdin)
	fmt.Println("Welcome!\nCommands: help, demo, deploy")

	ServerLoop(reader)
	// MonitorLoop(reader)
}

func ServerLoop(reader *bufio.Reader) {

	for {
		fmt.Println("Please enter the service you want to start: ")

		service, _ := reader.ReadString('\n')
		service = strings.TrimSpace(service)

		switch {
		case service == "backend":
			fmt.Println("Starting backend...")
			go backend.Run()
			break
		case service == "webapp":
			fmt.Println("Starting webapp...")
			go webapp.Run()
			break
		case service == "wallet":
			fmt.Println("Starting wallet...")
			go wallet.Run()
			break
		case service == "exit":
			fmt.Println("Exiting...")
			os.Exit(0)
			break
		}

		if service == "exit" {
			break
		}

	}
}
