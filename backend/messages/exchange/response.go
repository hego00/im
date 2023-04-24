package exchange

import (
	"bytes"
	"encoding/xml"
	"fmt"
	"io/ioutil"
	"log"
	"os"
	"reflect"
	"time"

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

func create_response1() {
	file, err := os.Open("backend/edm/templates/oots_response.xml")
	if err != nil {
		fmt.Println("Error opening file:", err)
		return
	}
	defer file.Close()

	decoder := xml.NewDecoder(file)

	for {
		// Read tokens from the XML document in a stream.
		token, err := decoder.Token()
		if err != nil {
			break
		}

		// Print the details of the token.
		switch element := token.(type) {

		case xml.StartElement:
			fmt.Printf("Start element: %s\n", element.Name.Local)
			for _, attr := range element.Attr {
				fmt.Printf("  Attribute: %s=%s\n", attr.Name.Local, attr.Value)
			}
		case xml.CharData:
			fmt.Printf("Character data: %s\n", string(element))
		case xml.Comment:
			fmt.Printf("Comment: %s\n", string(element))
		case xml.ProcInst:
			fmt.Printf("Processing instruction: %s %s\n", element.Target, string(element.Inst))
		case xml.EndElement:
			fmt.Printf("End element: %s\n", element.Name.Local)
		}
	}
}

type QueryBuilder struct {
	Start                      string
	SpecID                     string
	EvidenceResponseIdentifier string
	End                        string
	IssueDateTime              string
	EvidenceProvider           string
	RegistryObjectList         string
	EvidenceRequester          string
}

func create_response() {

	qb := QueryBuilder{

		Start: `<?xml version="1.0" encoding="UTF-8"?><query:QueryResponse xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
			xmlns:rs="urn:oasis:names:tc:ebxml-regrep:xsd:rs:4.0"
			xmlns:rim="urn:oasis:names:tc:ebxml-regrep:xsd:rim:4.0"
			xmlns:sdg="http://data.europa.eu/p4s"
			xmlns:query="urn:oasis:names:tc:ebxml-regrep:xsd:query:4.0"
			xmlns:xlink="http://www.w3.org/1999/xlink"
			status="urn:oasis:names:tc:ebxml-regrep:ResponseStatusType:Success"
			xmlns:xml="http://www.w3.org/XML/1998/namespace" 
			requestID="bc2842c1-6625-450d-a7c6-7d692230b753">`,

		SpecID: "oots-edm:v1.0",

		EvidenceResponseIdentifier: "5af62cce-debe-11ec-9d64-0242ac120002",

		IssueDateTime: `<rim:Slot name="IssueDateTime">
				<rim:SlotValue xsi:type="rim:DateTimeValueType">
					<rim:Value>2022-02-14T19:20:30+02:00</rim:Value>
				</rim:SlotValue>
			</rim:Slot>`,

		EvidenceProvider: `<rim:Slot name="EvidenceProvider">
				<rim:SlotValue xsi:type="rim:CollectionValueType">
					<rim:Element xsi:type="rim:AnyValueType">
						<sdg:Agent>
							<sdg:Identifier schemeID="0204">DE7657587001</sdg:Identifier>
							<sdg:Name>Authority for school and occupational training</sdg:Name>
							<sdg:Address>
								<sdg:FullAddress>Hamburger Str. 31</sdg:FullAddress>
								<sdg:LocatorDesignator>31</sdg:LocatorDesignator>
								<sdg:PostCode>22083</sdg:PostCode>
								<sdg:PostCityName>Hamburg</sdg:PostCityName>
								<sdg:AdminUnitLevel1>DE</sdg:AdminUnitLevel1>
								<sdg:AdminUnitLevel2>DE60</sdg:AdminUnitLevel2>
							</sdg:Address>
							<sdg:Classification>IntermediaryPlatform</sdg:Classification>
						</sdg:Agent>
					</rim:Element>
				</rim:SlotValue>
			</rim:Slot>`,

		EvidenceRequester: `<rim:Slot name="EvidenceRequester">
				<rim:SlotValue xsi:type="rim:AnyValueType">
					<sdg:Agent>
						<sdg:Identifier schemeID="0190">NL22233223</sdg:Identifier>
						<sdg:Name lang="en">University of Amsterdam</sdg:Name>
					</sdg:Agent>
				</rim:SlotValue>
			</rim:Slot>`,

		RegistryObjectList: `<rim:RegistryObjectList>

				<rim:RegistryObject xsi:type="rim:ExtrinsicObjectType" id="555555-740e-4b64-80f0-2462462462">
					<rim:Slot name="EvidenceMetadata">
						<rim:SlotValue xsi:type="rim:AnyValueType">
							<sdg:Evidence>
								<sdg:Identifier>7c2e04cf-7d20-4363-908d-827817746725</sdg:Identifier>
								<sdg:IsAbout>
									<sdg:NaturalPerson>
										<sdg:Identifier schemeID="eidas">DK/DE/123456</sdg:Identifier>
										<sdg:FamilyName>Smith</sdg:FamilyName>
										<sdg:GivenName>Jack</sdg:GivenName>
										<sdg:DateOfBirth>1970-03-01</sdg:DateOfBirth>
										<sdg:PlaceOfBirth>Dusseldorf</sdg:PlaceOfBirth>
									</sdg:NaturalPerson>
								</sdg:IsAbout>
								<sdg:IssuingAuthority>
									<sdg:Identifier schemeID="9930">DE7657587001</sdg:Identifier>
									<sdg:Name>Wilhelm Gymnasium</sdg:Name>
								</sdg:IssuingAuthority>
								<sdg:IsConformantTo>
									<sdg:EvidenceTypeClassification>SecondaryEducationCompletion</sdg:EvidenceTypeClassification>
									<sdg:Title lang="en">Secondary Education Completion Evidence</sdg:Title>
									<sdg:Title lang="de">Nachweis des Sekundarschulabschlusses</sdg:Title>
									<sdg:Description lang="de">Nachweis über den Abschluss der Sekundarstufe II</sdg:Description>
									<sdg:Description lang="en">Proof of completion of secondary education second stage</sdg:Description>
								</sdg:IsConformantTo>
								<sdg:IssuingDate>1988-05-10</sdg:IssuingDate>
								<sdg:Distribution>
									<sdg:Format>application/pdf</sdg:Format>
								</sdg:Distribution>
							</sdg:Evidence>         
						</rim:SlotValue>
					</rim:Slot>           
				<!-- The attached Document Provided as Evidence. Points to an AS4 attachment -->
				<rim:RepositoryItemRef xlink:href="cid:attachment100001@example.oots.eu" xlink:title="SecondaryEducationCompletion"/>
			</rim:RegistryObject>

			<rim:RegistryObject xsi:type="rim:ExtrinsicObjectType" id="60bc1cbb-2f6c-4eef-9479-b4ce3684572c">
				<rim:Slot name="EvidenceMetadata">
					<rim:SlotValue xsi:type="rim:AnyValueType">
						<sdg:Evidence>
							<sdg:Identifier>5ee5c0de-c066-4637-bea3-6e3511ada970</sdg:Identifier>
							<sdg:IsAbout>
								<sdg:NaturalPerson>
									<sdg:Identifier schemeID="eidas">DK/DE/123456</sdg:Identifier>
									<sdg:FamilyName>Smith</sdg:FamilyName>
									<sdg:GivenName>Jack</sdg:GivenName>
									<sdg:DateOfBirth>1970-03-01</sdg:DateOfBirth>
									<sdg:PlaceOfBirth>Dusseldorf</sdg:PlaceOfBirth>
								</sdg:NaturalPerson>
							</sdg:IsAbout>
							<sdg:IssuingAuthority>
								<sdg:Identifier schemeID="9930">DE7657587001</sdg:Identifier>
								<sdg:Name>Wilhelm Gymnasium</sdg:Name>
							</sdg:IssuingAuthority>
							<sdg:IsConformantTo>
								<sdg:EvidenceTypeClassification>SecondaryEducationCompletion</sdg:EvidenceTypeClassification>
								<sdg:Title lang="en">Secondary Education Completion Evidence Supplement</sdg:Title>
								<sdg:Title lang="de">Anhang zum Nachweis des Sekundarschulabschlusses</sdg:Title>
								<sdg:Description lang="en">The Supplement of the Secondary Education Completion Evidence Supplement to understand the qualification.</sdg:Description>
								<sdg:Description lang="de">Die Anlage zum Nachweis des Sekundarschulabschlusses, um die Qualifikation zu verstehen.</sdg:Description>
							</sdg:IsConformantTo>
							<sdg:IssuingDate>1988-05-10</sdg:IssuingDate>
							<sdg:Distribution>
								<sdg:Format>application/pdf</sdg:Format>
							</sdg:Distribution>
						</sdg:Evidence>
					</rim:SlotValue>
				</rim:Slot>           
				<!-- The attached Document Provided as Evidence. Points to an AS4 attachment -->
				<rim:RepositoryItemRef xlink:href="cid:attachment100002@example.oots.eu" xlink:title="SecondaryEducationCompletionSupplement"/>
			</rim:RegistryObject>
		</rim:RegistryObjectList> `,

		End: `</query:QueryResponse>`,
	}

	qb.Process()
	response := build(qb)
	SaveQueryResponseToFile(response)

}

func SaveQueryResponseToFile(response string) {
	t := time.Now()
	filename := fmt.Sprintf("./backend/logs/query_response_%s.xml", t.Format("20060102150405"))
	file, err := os.Create(filename)
	if err != nil {
		fmt.Println("Error creating file:", err)
		return
	}
	defer file.Close()

	_, err = file.WriteString(response)
	if err != nil {
		fmt.Println(err)
		return
	}
}

func (qb *QueryBuilder) Process() {
	qb.SpecID = SpecID(qb.SpecID)
	qb.EvidenceResponseIdentifier = EvidenceResponseIdentifier(qb.EvidenceResponseIdentifier)
}

func build(qb QueryBuilder) string {

	var buf bytes.Buffer

	val := reflect.ValueOf(qb)

	for i := 0; i < val.NumField(); i++ {
		field := val.Field(i)
		if field.Kind() == reflect.String {
			buf.WriteString(field.String())
		} else {
			panic("query builder field is not a string")
		}
	}

	return buf.String()
}

func SpecID(id string) string {

	template := `<rim:Slot name="SpecificationIdentifier">
					<rim:SlotValue xsi:type="rim:StringValueType"
									xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance">
						<rim:Value>%s</rim:Value>
					</rim:SlotValue>
				</rim:Slot>`

	return fmt.Sprintf(template, id)
}

func EvidenceResponseIdentifier(id string) string {
	template := `<rim:Slot name="EvidenceResponseIdentifier">
					<rim:SlotValue xsi:type="rim:StringValueType">
						<rim:Value>%s</rim:Value>
					</rim:SlotValue>
				</rim:Slot>`
	return fmt.Sprintf(template, id)
}

func IssueDateTime(dateTime string) string {
	template := `<rim:Slot name="IssueDateTime">
					<rim:SlotValue xsi:type="rim:StringValueType"
									xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance">
						<rim:Value>%s</rim:Value>
					</rim:SlotValue>
				</rim:Slot>`
	return fmt.Sprintf(template, dateTime)
}

func EvidenceProvider(provider string) string {
	template := `<rim:Slot name="EvidenceProvider">
					<rim:SlotValue xsi:type="rim:StringValueType"
									xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance">
						<rim:Value>%s</rim:Value>
					</rim:SlotValue>
				</rim:Slot>`
	return fmt.Sprintf(template, provider)
}

func RegistryObjectList(list string) string {
	template := `<rim:Slot name="RegistryObjectList">
					<rim:SlotValue xsi:type="rim:StringValueType"
									xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance">
						<rim:Value>%s</rim:Value>
					</rim:SlotValue>
				</rim:Slot>`
	return fmt.Sprintf(template, list)
}

func EvidenceRequester(requester string) string {
	template := `<rim:Slot name="EvidenceRequester">
					<rim:SlotValue xsi:type="rim:StringValueType"
									xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance">
						<rim:Value>%s</rim:Value>
					</rim:SlotValue>
				</rim:Slot>`
	return fmt.Sprintf(template, requester)
}
