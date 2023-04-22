package main

import (
	"bufio"
	"fmt"
	"os"
	"sdg/backend"
	"strings"
)

func main() {
	LiveDemo()
}

func LiveDemo() {
	reader := bufio.NewReader(os.Stdin)
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
