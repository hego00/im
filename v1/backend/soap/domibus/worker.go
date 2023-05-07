package domibus

import (
	"crypto/x509"
	"net/http"
)

var version = "0.0.0"
var oots_spec = "0.0.0"

type Config struct {
	EndpointURL    string
	SoapAction     string
	MessageID      string
	ConversationID string
	FromPartyID    string
	ToPartyID      string
	CPAID          string
	CertFile       string
	KeyFile        string
	CACertFile     string
}

type Client struct {
	config   *Config
	client   *http.Client
	certPool *x509.CertPool
}

type EbmsHeader struct {
	From           string `xml:"From>PartyId"`
	To             string `xml:"To>PartyId"`
	CPAId          string `xml:"CPAId"`
	ConversationId string `xml:"ConversationId"`
	MessageId      string `xml:"MessageId"`
}

type EbmsMessage struct {
	Header  EbmsHeader `xml:"Header"`
	Payload string     `xml:"Payload"`
}

func Connect() Client {

	// create config
	config := &Config{
		EndpointURL:    "http://localhost:8080/domibus/services/msh",
		SoapAction:     "http://docs.oasis-open.org/ebxml-msg/ebms/v3.0/ns/core/200704/test",
		MessageID:      "1234567890",
		ConversationID: "1234567890",
		FromPartyID:    "urn:oasis:names:tc:ebcore:partyid-type:unregistered:C1",
		ToPartyID:      "urn:oasis:names:tc:ebcore:partyid-type:unregistered:C4",
		CPAID:          "urn:oasis:names:tc:ebcore:partyid-type:unregistered:C4",
		CertFile:       "certs/domibus.p12",
		KeyFile:        "certs/domibus.key",
		CACertFile:     "certs/domibus.cer",
	}

	//create http client
	client := &http.Client{}

	// create cert pool
	certPool := x509.NewCertPool()

	// create client
	c := &Client{
		config:   config,
		client:   client,
		certPool: certPool,
	}

	// return client
	return *c

}
func (c *Client) Send() {
	// send message to domibus
	// return response
}

func (c *Client) Receive() {
	// receive message from domibus
	// return message
}

func (c *Client) Disconnect() {
	// disconnect from domibus
	// return status
}

func (c *Client) Init() {
	// initialize client
	// return client
}

func fetchRequestsfromDomibus() {
	// fetch requests from domibus
	// process requests
	// return responses
}
