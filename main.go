package main

import (
	"sdg/utils"
)

func main() {

	printExampleMessage()

}


func printExampleMessage() {
	message := utils.ReadXML("resources/connectathon1/examples/oots_exception_preview.xml")
	utils.ProcessMessage(message)
}