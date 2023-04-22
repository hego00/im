package soap

import (
	"fmt"
)

func Test_NewClient() {

	//create config
	config := &Config{
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
	client, err := NewClient(config)
	if err != nil {
		fmt.Printf("Error creating client: %v\n", err)
	}
	fmt.Printf("Created client: %v\n", client)

}
