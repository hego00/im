package main

import (
	"bufio"
	"fmt"
	"os"
	"sdg/backend"
)

func main() {

	fmt.Println("Hello, you are at the main entry point for OOTS coordination")

	// startup config
	reader := bufio.NewReader(os.Stdin)
	fmt.Print("Enter your name: ")
	name, _ := reader.ReadString('\n')
	fmt.Printf("Hello, %s", name)

	fmt.Println("Starting backend")
	go backend.Run()

	// 	fmt.Println("Starting frontend")
	// 	go frontend.Run()
	// //
}
