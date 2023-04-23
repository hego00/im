package exchange

import (
	"fmt"
	"io/ioutil"
	"log"

	"aqwari.net/xml/xmltree"
	"github.com/google/uuid"
)

var (
	nameSpace             string = "urn:be:fgov:ehealth:exchange:core:v1"
	specID                string = "oots:query:1.0"
	queryResponseTemplate string = "C:/Users/ajphe/DEV/sdg/backend/messages/exchange/snippets/QueryResponse.xml"
)


func CreateResponse() string {

	xmlFile, err := ioutil.ReadFile(queryResponseTemplate)
	if err != nil {
		log.Fatal(err)
	}

	root, err := xmltree.Parse([]byte(xmlFile))
	if err != nil {
		log.Fatal(err)
	}

	for _, el := range root.Search("", "QueryResponse") {
		fmt.Printf("%s\n", el.Content)
		// el.SetAttr("xmlns", nameSpace)
	}

	return root.String()
}

// generate unique id for response
func generateUIID() string {
	return uuid.NewString()
}

// generate timestamp for response
func generateTimestamp() string {
	return "2019-11-01T12:00:00Z"
}

//
