package security

import (
    "crypto/rand"
    "crypto/rsa"
    "crypto/x509"
    "crypto/x509/pkix"
    "crypto/tls"
    "encoding/pem"
    "log"
    "math/big"
    "time"
)


func CreateCertificate() (tls.Certificate){
	cert, err := generateSelfSignedCert("example.com")
	
	if err != nil {
		log.Fatalf("Failed to generate certificate: %v", err)
	}

	keyPair, err := tls.X509KeyPair(cert.CertPEM, cert.KeyPEM)
	if err != nil {
		log.Fatalf("Failed to create X.509 key pair: %v", err)
	}

	return keyPair 
}

type Cert struct {
	CertPEM []byte
	KeyPEM  []byte
}

func generateSelfSignedCert(commonName string) (*Cert, error) {
	// Generate a new RSA private key
	privateKey, err := rsa.GenerateKey(rand.Reader, 2048)
	if err != nil {
		return nil, err
	}

	// Create an X.509 certificate template
	template := x509.Certificate{
		SerialNumber:          big.NewInt(1),
		Subject:               pkix.Name{CommonName: commonName},
		NotBefore:             time.Now(),
		NotAfter:              time.Now().AddDate(1, 0, 0),
		BasicConstraintsValid: true,
	}

	// Create a self-signed X.509 certificate
	certBytes, err := x509.CreateCertificate(rand.Reader, &template, &template, &privateKey.PublicKey, privateKey)
	if err != nil {
		return nil, err
	}

	// Encode the private key and certificate to PEM format
	keyPEM := pem.EncodeToMemory(&pem.Block{Type: "RSA PRIVATE KEY", Bytes: x509.MarshalPKCS1PrivateKey(privateKey)})
	certPEM := pem.EncodeToMemory(&pem.Block{Type: "CERTIFICATE", Bytes: certBytes})

	return &Cert{CertPEM: certPEM, KeyPEM: keyPEM}, nil
}