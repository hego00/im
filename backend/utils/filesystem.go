package utils

import (
	"github.com/beevik/etree"
)

// function to read xml from resources folder
func ReadXML(file string) *etree.Document {
	doc := etree.NewDocument()
	if err := doc.ReadFromFile(file); err != nil {
		panic(err)
	}
	return doc
}
