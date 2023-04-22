package main

import (
	"bufio"
	"fmt"
	"os"
	"sdg/backend"
	"sdg/frontend"
)

func main() {
	demo()
	live()
}

func live() {
	backend.Run()
	frontend.Run()
	liveControl()
}


func demo() {
	
	backend.Run()
	frontend.Run()
	wallet.Run()

	liveControl()
}


func liveControl() {

	reader := bufio.NewReader(os.Stdin)
	fmt.Println("Hello!")

	service, _ := reader.ReadString('\n')
	fmt.Printf("Hello, %s", service)

	if service == "backend" {
		fmt.Println("Starting backend")
		backend.Run()
	}

}
