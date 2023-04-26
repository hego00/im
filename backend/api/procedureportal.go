package api

type User struct {
	Username string `json:"username"`
	Password string `json:"password"`
}

type Application struct {
	ApplicationIdentifier string `json:"application_identifier"`
	ApplicationName       string `json:"application_name"`
	ApplicationVersion    string `json:"application_version"`
	User                  User   `json:"user"`
}

var User01 User = User{Username: "user01", Password: "password01"}
var User02 User = User{Username: "user02", Password: "password02"}

var Application01 Application = Application{ApplicationIdentifier: "1", ApplicationName: "Application 1", ApplicationVersion: "1.0.0", User: User01}
var Application02 Application = Application{ApplicationIdentifier: "2", ApplicationName: "Application 2", ApplicationVersion: "1.0.0", User: User02}

