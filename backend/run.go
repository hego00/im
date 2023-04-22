package backend

import (
	"bytes"
	"encoding/xml"
	"fmt"
	"os"
	"reflect"
	"time"
	"sdg/backend/soap"
)

func Run() {
	//create_request()
	//create_response()
	soap.ProcessEvidenceRequest()
}

