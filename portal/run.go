package webapp

import (
	"fmt"
	"net/http"
)

func handler(w http.ResponseWriter, r *http.Request) {
	// handle incoming requests
}

func Run() {
	fmt.Println("Starting web server on port 8080")

}
