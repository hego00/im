package main

import (
	"bufio"
	"fmt"
	"os"
	"sdg/backend"
	"strings"
)

func main() {

	if len(os.Args)-1 == 1 {
		action := os.Args[1]

		switch {
		case action == "demo":
			fmt.Println("Starting demo...")
			backend.Run()
			break
		}

	} else {
		Welcome()
	}
}

func Welcome() {
	reader := bufio.NewReader(os.Stdin)
	//	actions should be an enum
	fmt.Println("Welcome!\n\nCommands: start, stop, restart, status, exit\n")
	for {
		command, _ := reader.ReadString('\n')
		command = strings.TrimSpace(command)

		switch {
		case command == "start":
			fmt.Println("Starting...")
			backend.Run()
			break
		case command == "stop":
			fmt.Println("Stopping...")
			break
		case command == "restart":
			fmt.Println("Restarting...")
			break
		case command == "status":
			fmt.Println("Status...")
			break
		case command == "exit":
			fmt.Println("Exiting...")
			os.Exit(0)
			break
		}

		if command == "exit" {
			break
		}
	}
}
