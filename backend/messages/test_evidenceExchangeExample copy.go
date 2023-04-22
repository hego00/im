package soap

import (
	"encoding/xml"
	"fmt"
)

type Message struct {
	XMLName xml.Name `xml:"Message"`
	Text    string   `xml:",chardata"`
	ID      string   `xml:"ID"`
	From    string   `xml:"From"`
	To      string   `xml:"To"`
	Subject string   `xml:"Subject"`
	Body    string   `xml:"Body"`
}

func main() {
	xmlString := `
		<Message>
			<ID>123</ID>
			<From>Alice</From>
			<To>Bob</To>
			<Subject>Hello</Subject>
			<Body>Hi Bob, how are you?</Body>
		</Message>
	`

	var msg Message
	if err := xml.Unmarshal([]byte(xmlString), &msg); err != nil {
		panic(err)
	}

	fmt.Printf("ID: %s\n", msg.ID)
	fmt.Printf("From: %s\n", msg.From)
	fmt.Printf("To: %s\n", msg.To)
	fmt.Printf("Subject: %s\n", msg.Subject)
	fmt.Printf("Body: %s\n", msg.Body)
}