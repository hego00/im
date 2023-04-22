package exchange

import (
	"fmt"
	"io/ioutil"
	"log"

	"aqwari.net/xml/xmltree"
	"github.com/google/uuid"
)

var (
	queryResponseTemplate string = "C:/Users/ajphe/DEV/sdg/backend/models/xml/Exchange/Response/ebRIM_QueryResponse_template.xml"
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

	for _, el := range root.Search("", "FullName") {
		fmt.Printf("%s\n", el.Content)
	}

	return root.String()
}

// generate unique id for response
func generateUIID() string {
	return uuid.NewString()
}
