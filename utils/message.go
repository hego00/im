package utils

import (
	"fmt"
	"github.com/beevik/etree"
)

// function to process the message
func ProcessMessage(doc *etree.Document) {
	// process the message
	root := doc.SelectElement("query:QueryResponse")

	fmt.Println(root.Tag)
	fmt.Println(root.Attr)
	fmt.Println(root.Text())

	for _, slot := range root.FindElements("//rim:Slot") {
		fmt.Println(slot.SelectAttrValue("name", ""))
		childElements := slot.ChildElements()

		for _, child := range childElements {
			fmt.Println(child.Tag)
			fmt.Println(child.Attr)
			grandchildren := child.ChildElements()

			for _, grandchildElement := range grandchildren {
				fmt.Println(grandchildElement.Tag)
				fmt.Println(grandchildElement.Text())
				grandgrandchildren := grandchildElement.ChildElements()

				for _, grandgrandchildElement := range grandgrandchildren {
					fmt.Println(grandgrandchildElement.Tag)
					fmt.Println(grandgrandchildElement.Text())
				}
			}
		}
	}
}