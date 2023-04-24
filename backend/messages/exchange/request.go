package exchange

import (
	"encoding/xml"
	"fmt"
	"io/ioutil"
	"log"
	"os"
	"time"

	"aqwari.net/xml/xmltree"
)

func ProcessEvidenceRequest(filename string) {

	fmt.Println("Processing Evidence Request")
	// xmlfile, err := os.Open("backend/edm/templates/oots_request_BC.xml")
	xmlfile, err := os.Open(filename)

	byteValue, _ := ioutil.ReadAll(xmlfile)
	root, err := xmltree.Parse([]byte(byteValue))

	if err != nil {
		panic(err)
	}

	var qr QueryRequest
	if err := xmltree.Unmarshal(root, &qr); err != nil {
		log.Print(err)
	}
	fmt.Println(qr.RequestID)
}

func create_request() {

	stringVal1 := "oots-edm:v1.0"
	value1 := Value{Basic: &stringVal1}
	slotvalue1 := SlotValue{Type: "xsd:string", Value: &value1}
	slot1 := Slot{Name: "SpecificationIdentifier", SlotValue: &slotvalue1}

	t := time.Now()
	layout := "2006-01-02T15:04:05-07:00"
	formattedTime := t.Format(layout)
	value2 := Value{Basic: &formattedTime}
	slotvalue2 := SlotValue{Type: "rim:DateTimeValueType", Value: &value2}
	slot2 := Slot{Name: "IssueDateTime", SlotValue: &slotvalue2}

	lang := "en"
	stringVal3 := "Requesting recognition of diploma"
	localString := LocalizedString{Lang: lang, Value: stringVal3}
	value3 := Value{LocalizedString: &localString}
	slotvalue3 := SlotValue{Type: "rim:InternationalStringValueType", Value: &value3}
	slot3 := Slot{Name: "Procedure", SlotValue: &slotvalue3}

	booleanTrue := "true"
	slotValue4 := SlotValue{Type: "rim:BooleanValueType", Value: &Value{Basic: &booleanTrue}}
	slot4 := Slot{Name: "PossibilityForPreview", SlotValue: &slotValue4}

	slotValue5 := SlotValue{Type: "rim:BooleanValueType", Value: &Value{Basic: &booleanTrue}}
	slot5 := Slot{Name: "ExplicitRequestGiven", SlotValue: &slotValue5}

	name1 := Name{Lang: lang, Value: "Proof of Secondary Education Completion"}
	requirement1 := Requirement{Identifier: "315cfd75-6605-49c4-b0fe-799833b41099", Name: name1}
	element1 := Element{Type: "sdg:Requirement", Requirement: &requirement1}

	name2 := Name{Lang: lang, Value: "Proof of Secondary Education Completion Supplemenent Evidence"}
	requirement2 := Requirement{Identifier: "543-cfd75-6605-49c4-b0fe-799833b41111", Name: name2}
	element2 := Element{Type: "sdg:Requirement", Requirement: &requirement2}

	slotValue6 := SlotValue{Type: "rim:CollectionValueType", CollectionType: "urn:oasis:names:tc:ebxml-regrep:CollectionType:Set", Elements: []Element{element1, element2}}
	slot6 := Slot{Name: "Requirements", SlotValue: &slotValue6}

	schemeID := "0190"
	identifier := Identifier{SchemeID: &schemeID, Value: "NL22233223"}
	agent := Agent{Identifier: identifier, Name: "John Doe"}
	element3 := Element{Type: "rim:AnyValueType", Agent: &agent}
	slotValue7 := SlotValue{Type: "rim:CollectionValueType", Elements: []Element{element3}}
	slot7 := Slot{Name: "EvidenceRequester", SlotValue: &slotValue7}

	slot8 := Slot{Name: "EvidenceProvider"}
	slot9 := Slot{Name: "EvidenceProviderClassificationValues"}

	query1 := Query{QueryDefinition: "DocumentQuery"}
	responseOption1 := ResponseOption{ReturnType: "LeafClassWithRepositoryItem"}

	qr := QueryRequest{
		XSI:        "http://www.w3.org/2001/XMLSchema-instance",
		RS:         "urn:oasis:names:tc:ebxml-regrep:xsd:rs:4.0",
		SDG:        "http://data.europa.eu/p4s",
		XMIME:      "http://www.w3.org/2005/05/xmlmime",
		RIM:        "urn:oasis:names:tc:ebxml-regrep:xsd:rim:4.0",
		QueryNS:    "urn:oasis:names:tc:ebxml-regrep:xsd:query:4.0",
		XLINK:      "http://www.w3.org/1999/xlink",
		XML:        "http://www.w3.org/XML/1998/namespace",
		RequestID:  "bc2842c1-6625-450d-a7c6-7d692230b753",
		Slots:      []*Slot{&slot1, &slot2, &slot3, &slot4, &slot5, &slot6, &slot7, &slot8, &slot9},
		Query:      &query1,
		ReturnType: &responseOption1,
	}

	t = time.Now()
	filename := fmt.Sprintf("./backend/logs/query_request_%s.xml", t.Format("20060102150405"))
	file, err := os.Create(filename)
	if err != nil {
		fmt.Println("Error creating file:", err)
		return
	}
	defer file.Close()

	encoder := xml.NewEncoder(file)
	encoder.Indent("", "  ")
	if err := encoder.Encode(qr); err != nil {
		fmt.Println("Error encoding XML:", err)
	}

}

// header should be one constant
type QueryRequest struct {
	XMLName    xml.Name        `xml:"QueryRequest"`
	XSI        string          `xml:"xmlns:xsi,attr"`
	RS         string          `xml:"xmlns:rs,attr"`
	SDG        string          `xml:"xmlns:sdg,attr"`
	XMIME      string          `xml:"xmlns:xmime,attr"`
	RIM        string          `xml:"xmlns:rim,attr"`
	QueryNS    string          `xml:"xmlns:query,attr"`
	XLINK      string          `xml:"xmlns:xlink,attr"`
	XML        string          `xml:"xmlns:xml,attr"`
	RequestID  string          `xml:"requestID,attr"`
	Slots      []*Slot         `xml:"rim:Slot,omitempty"`
	Query      *Query          `xml:"query:Query"`
	ReturnType *ResponseOption `xml:"query:ResponseOption"`
}

type Query struct {
	XMLName         xml.Name `xml:"query:Query"`
	QueryDefinition string   `xml:"queryDefinition,attr"`
}

type ResponseOption struct {
	XMLName    xml.Name `xml:"query:ResponseOption"`
	ReturnType string   `xml:"returnType,attr"`
}

type Slot struct {
	Name      string     `xml:"name,attr"`
	SlotValue *SlotValue `xml:"rim:SlotValue,omitempty"`
}

type SlotValue struct {
	XMLName        xml.Name  `xml:"rim:SlotValue"`
	Type           string    `xml:"xsi:type,attr"`
	CollectionType string    `xml:"collectionType,attr,omitempty"`
	Value          *Value    `xml:"rim:Value"`
	Elements       []Element `xml:"rim:Element"`
}

type Element struct {
	XMLName     xml.Name     `xml:"rim:Element"`
	Type        string       `xml:"xsi:type,attr"`
	Requirement *Requirement `xml:"sdg:Requirement"`
	Agent       *Agent       `xml:"rim:Agent"`
}

type Requirement struct {
	XMLName    xml.Name `xml:"sdg:Requirement"`
	Identifier string   `xml:"sdg:identifier"`
	Name       Name     `xml:"sdg:name"`
}

type Agent struct {
	XMLName    xml.Name   `xml:"rim:Agent"`
	Identifier Identifier `xml:"sdg:Identifier"`
	Name       string     `xml:"sdg:Name"`
	Address    Address    `xml:"sdg:Address"`
}

type Identifier struct {
	XMLName  xml.Name `xml:"sdg:Identifier"`
	SchemeID *string  `xml:"schemeID,attr"`
	Value    string   `xml:",chardata"`
}

type Address struct {
	XMLName           xml.Name `xml:"sdg:Address"`
	Street            string   `xml:"sdg:street"`
	FullAddress       string   `xml:"sdg:fullAddress"`
	LocatorDesignator string   `sdg:locatorDesignator`
	PostCode          string   `sdg:postCode`
	PostCityName      string   `sdg:postCityName`
	AdminUnitLevel1   string   `sdg:adminUnitLevel1`
	AdminUnitLevel2   string   `sdg:adminUnitLevel2`
}

type Name struct {
	XMLName xml.Name `xml:"sdg:name"`
	Lang    string   `xml:"xml:lang,attr"`
	Value   string   `xml:",chardata"`
}

type Value struct {
	XMLName         xml.Name         `xml:"rim:Value"`
	Basic           *string          `xml:",chardata"`
	LocalizedString *LocalizedString `xml:"rim:LocalizedString,omitempty"`
}

type LocalizedString struct {
	XMLName xml.Name `xml:"rim:LocalizedString"`
	Lang    string   `xml:"xml:lang,attr"`
	Value   string   `xml:"value,attr"`
}
