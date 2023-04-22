package exchange

import (
	"fmt"
	"io/ioutil"
	"log"

	"aqwari.net/xml/xmltree"
)

func ReadQueryExample() string {
	// read xml from file
	xmlFile, err := ioutil.ReadFile("example.xml")
	if err != nil {
		log.Fatal(err)
	}
	root, err := xmltree.Parse([]byte(xmlFile))
	if err != nil {
		log.Fatal(err)
	}
	for _, el := range root.Search("", "FullName") {
		fmt.Printf("%s\n", el.Content)
	}

	return root.String()
}
