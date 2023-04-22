package backend

import (
	"fmt"
	"sdg/backend/soap"
)

func Run() {

	soap.StartHandler()
	fmt.Println("Backend started")

}
