package soap

import (
	"fmt"
	"io"
	"net/http"

	"github.com/beevik/etree"
	"github.com/gorilla/mux"
)

func StartHandler() {
	router := mux.NewRouter()

	router.HandleFunc("/soap", as4Handler).Methods("POST")

	fmt.Println("started as4 handler - listenging on http://localhost:8080")

	http.ListenAndServe("localhost:8080", router)

	fmt.Println("started as4 handler - listening on localhost:8080")
}

func as4Handler(w http.ResponseWriter, r *http.Request) {
	// Parse the incoming message
	doc, err := parseSOAPMessage(r.Body)
	if err != nil {
		fmt.Fprintf(w, "Error parsing SOAP message: %s", err)
		return
	}

	// Extract the AS4-specific headers
	messaging, userMessage := extractAS4Headers(doc)
	fmt.Printf("Messaging: %v ", messaging)

	// Decrypt the message if it was encrypted
	decryptMessage(userMessage)

	// Validate the message signature if it was signed
	validateSignature(userMessage)

	// Handle the message and generate a response
	response := handleAS4Message(doc)

	// Send the response
	sendSOAPResponse(w, response)
}

func parseSOAPMessage(body io.ReadCloser) (*etree.Document, error) {
	doc := etree.NewDocument()
	if _, err := doc.ReadFrom(body); err != nil {
		return nil, err
	}
	return doc, nil
}

func extractAS4Headers(doc *etree.Document) (*etree.Element, *etree.Element) {
	messaging := doc.FindElement("//eb3:Messaging")
	userMessage := messaging.FindElement(".//eb3:UserMessage")
	return messaging, userMessage
}

func decryptMessage(userMessage *etree.Element) {
	payload := userMessage.FindElement(".//eb3:Payload")
	if payload != nil {
		encryptedData := payload.FindElement(".//xenc:EncryptedData")
		if encryptedData != nil {
			// Use BouncyCastle or another cryptography library to decrypt the message
			// and replace the encrypted payload with the decrypted version
		}
	}
}

func validateSignature(userMessage *etree.Element) {
	signature := userMessage.FindElement(".//ds:Signature")
	if signature != nil {
		// Use a library like Golang's crypto/x509 package to validate the signature
	}
}

func handleAS4Message(doc *etree.Document) string {
	// Do some processing on the message and generate a response

	// read edm/examples/oots_response.xml 
	// and return it as a string


	response := `
		<soapenv:Envelope xmlns:soapenv="http://schemas.xmlsoap.org/soap/envelope/" xmlns:web="http://www.webserviceX.NET">
			<soapenv:Header/>
			<soapenv:Body>
				<web:ConversionRateResponse>
					<web:ConversionRateResult>1.2345</web:ConversionRateResult>
				</web:ConversionRateResponse>
			</soapenv:Body>
		</soapenv:Envelope>
	`
	return response
}

func sendSOAPResponse(w http.ResponseWriter, response string) {
	w.Header().Set("Content-Type", "application/soap+xml")
	w.Write([]byte(response))
}
