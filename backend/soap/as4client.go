package soap

import (
    "bytes"
    "crypto/tls"
    "crypto/x509"
    "encoding/base64"
    "encoding/xml"
    "fmt"
    "io/ioutil"
    "net/http"
)

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
    From      string `xml:"From>PartyId"`
    To        string `xml:"To>PartyId"`
    CPAId     string `xml:"CPAId"`
    ConversationId string `xml:"ConversationId"`
    MessageId string `xml:"MessageId"`
}

type EbmsMessage struct {
    Header    EbmsHeader `xml:"Header"`
    Payload   string    `xml:"Payload"`
}



func NewClient(config *Config) (*Client, error) {
    cert, err := tls.LoadX509KeyPair(config.CertFile, config.KeyFile)
    if err != nil {
        fmt.Printf("Error loading key pair: %v\n", err)
        return nil, err
    }
    
    // Add some logging to help debug the issue
    fmt.Printf("Loaded certificate from %s and key from %s\n", config.CertFile, config.KeyFile)
    
    caCert, err := ioutil.ReadFile(config.CACertFile)
    if err != nil {
        fmt.Println("Error reading CA cert file")
        return nil, err
    }

    certPool := x509.NewCertPool()
    if ok := certPool.AppendCertsFromPEM(caCert); !ok {
        return nil, fmt.Errorf("failed to append CA certificate")
    }

    tlsConfig := &tls.Config{
        Certificates: []tls.Certificate{cert},
        RootCAs:      certPool,
        MinVersion:   tls.VersionTLS12,
    }

    transport := &http.Transport{TLSClientConfig: tlsConfig}
    client := &http.Client{Transport: transport}

    return &Client{
        config:   config,
        client:   client,
        certPool: certPool,
    }, nil
}

func (c *Client) Send(payload string) ([]byte, error) {
    ebmsMessage := EbmsMessage{
        Header: EbmsHeader{
            From:           c.config.FromPartyID,
            To:             c.config.ToPartyID,
            CPAId:          c.config.CPAID,
            ConversationId: c.config.ConversationID,
            MessageId:      c.config.MessageID,
        },
        Payload: base64.StdEncoding.EncodeToString([]byte(payload)),
    }
    buf, err := xml.MarshalIndent(ebmsMessage, "", "    ")
    if err != nil {
        fmt.Println("Error marshalling XML")
        return nil, err
    }
    body := bytes.NewBuffer(buf)

    req, err := http.NewRequest("POST", c.config.EndpointURL, body)
    if err != nil {
        fmt.Println("Error creating HTTP request")
        return nil, err
    }
    req.Header.Set("Content-Type", "application/soap+xml;charset=UTF-8")
    req.Header.Set("SOAPAction", c.config.SoapAction)

    resp, err := c.client.Do(req)
    if err != nil {
        fmt.Println("Error sending HTTP request")
        return nil, err
    }
    defer resp.Body.Close()

    respBody, err := ioutil.ReadAll(resp.Body)
    if err != nil {
        fmt.Println("Error reading response body")
        return nil, err
    }
    return respBody, nil
}