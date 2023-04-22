package aprilprojectathon

import (
	"fmt"
	"sdg/backend/soap"

	"golang.org/x/text/message"
)

func Test_NewClient() {
	fmt.Println("Test_NewClient()")
	//create config
	config := &soap.Config{
		EndpointURL:    "https://localhost:8080",
		SoapAction:     "http://docs.oasis-open.org/ebxml-msg/ebms/v3.0/ns/core/200704/submit",
		MessageID:      "uuid:12345678-1234-5678-1234-567890abcdef",
		ConversationID: "uuid:abcdef12-3456-7890-abcd-ef1234567890",
		FromPartyID:    "urn:example:sender",
		ToPartyID:      "urn:example:receiver",
		CPAID:          "urn:example:cpa",
		CertFile:       "client.crt",
		KeyFile:        "client.key",
		CACertFile:     "ca.crt",
	}

	// NewClient()
	client, err := soap.NewClient(config)
	if err != nil {
		fmt.Printf("Error creating client: %v ", err)
	}

	//create query request message
	queryRequest := &message.QueryRequest{
		RefToMessageID: "uuid:12345678-1234-5678-1234-567890abcdef",
	}


	client.Send()
	fmt.Printf("Created client: %v ", client)

}
