package main

import (
	"fmt"
	"sdg/utils"
)

func main() {

	fmt.Println("Welcome to the sdg project!")



	// printExampleMessage()

}

func printExampleMessage() {
	message := utils.ReadXML("resources/connectathon1/examples/oots_exception_preview.xml")
	utils.ProcessMessage(message)
}
