package frontend

import (
	"fmt"
	"net/http"
)

func Run() string {
	fmt.Println("frontend online")

	http.HandleFunc("/", func(w http.ResponseWriter, r *http.Request) {
		http.ServeFile(w, r, "form.html")
	})

	http.ListenAndServe("localhost:8080", nil)
	return "frontend started"
}
