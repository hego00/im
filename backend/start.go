package backend

import (
	"fmt"
	"sdg/backend/soap"
)

func Run() {

	soap, err := soap.NewClient(&soap.Config{
		EndpointURL:    "https://test.as4.oasis-open.org:8443/as4",
		SoapAction:     "http://docs.oasis-open.org/ebxml-msg/ebms/v3.0/ns/core/200704/submit",
		MessageID:      "uuid:12345678-1234-5678-1234-567890abcdef",
		ConversationID: "uuid:abcdef12-3456-7890-abcd-ef1234567890",
		FromPartyID:    "urn:example:sender",
		ToPartyID:      "urn:example:receiver",
		CPAID:          "urn:example:cpa",
		CertFile:       "client.crt",
		KeyFile:        "client.key",
		CACertFile:     "ca.crt",
	})

	if err != nil {
		fmt.Printf("Error creating client: %v\n", err)
	}
	
	fmt.Printf("Created client: %v\n", soap)

}
