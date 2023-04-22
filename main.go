package main

import (
	"sdg/backend"
	"sdg/backend/soap"
)

func main() {
	backend.Run()
	soap.
}

// func interactiveCli() {

// 	reader := bufio.NewReader(os.Stdin)
// 	fmt.Println("service: ")

// 	service, _ := reader.ReadString('\n')
// 	fmt.Printf("Hello, %s", service)

// 	if service == "backend" {
// 		fmt.Println("Starting backend")
// 		backend.Run()
// 	}

// }
