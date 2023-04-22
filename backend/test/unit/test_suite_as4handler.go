package unit

import (
	"fmt"
	"io/ioutil"
	"net/http"
	"testing"
)

func Test_as4handler(t *testing.T) {
	// Create a new request using http
	req, err := http.NewRequest("GET", "https://localhost:8080/ebms", nil)
	if err != nil {
		t.Fatal(err)
	}

	// Send req using http Client
	client := &http.Client{}
	resp, err := client.Do(req)
	if err != nil {
		t.Fatal(err)
	}

	// Callers should close resp.Body

	// Read the response body
	defer resp.Body.Close()
	body, err := ioutil.ReadAll(resp.Body)
	if err != nil {
		t.Fatal(err)
	}
	fmt.Printf("%s", body)
}
