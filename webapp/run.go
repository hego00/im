package webapp

import (
	"crypto/tls"
	"net/http"
)

func handler(w http.ResponseWriter, r *http.Request) {
	// handle incoming requests
}

func Run() {
	mux := http.NewServeMux()
	mux.HandleFunc("/", handler)

	tlsConfig := &tls.Config{
		// specify the certificate and private key
		Certificates: []tls.Certificate{},
		// set other TLS configuration options as needed
		MinVersion: tls.VersionTLS12,
		MaxVersion: tls.VersionTLS13,
	}

	server := &http.Server{
		Addr:      ":443",
		Handler:   mux,
		TLSConfig: tlsConfig,
	}

	err := server.ListenAndServeTLS("cert.pem", "key.pem")
	if err != nil {
		panic(err)
	}
}
