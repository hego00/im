package api

import (
	"encoding/json"
	"net/http"
)

type Procedure struct {
	ProcedureIdentifier  string        `xml:"ProcedureIdentifier" json:"procedure_identifier"`
	ProcedureName        string        `xml:"ProcedureName" json:"procedure_name"`
	ProcedureDescription string        `xml:"ProcedureDescription" json:"procedure_description"`
	Requirements         []Requirement `xml:"Requirement" json:"requirements"`
}

type Requirement struct {
	RequirementIdentifier  string         `xml:"RequirementIdentifier" json:"requirement_identifier"`
	RequirementName        string         `xml:"RequirementName" json:"requirement_name"`
	RequirementDescription string         `xml:"RequirementDescription" json:"requirement_description"`
	EvidenceLibrary        []EvidenceRepo `json:"evidence_library"`
}

type EvidenceRepo struct {
	EvidenceRepoIdentifier  string         `xml:"EvidenceRepoIdentifier" json:"evidence_repo_identifier"`
	EvidenceRepoName        string         `xml:"EvidenceRepoName" json:"evidence_repo_name"`
	EvidenceRepoDescription string         `xml:"EvidenceRepoDescription" json:"evidence_repo_description"`
	EvidenceTypes           []EvidenceType `json:"evidence"`
}

type EvidenceType struct {
	EvidenceIdentifier    string `xml:"EvidenceIdentifier" json:"evidence_identifier"`
	EvidenceName          string `xml:"EvidenceName" json:"evidence_name"`
	EvidenceDescription   string `xml:"EvidenceDescription" json:"evidence_description"`
	EvidenceDistributedAs string `xml:"EvidenceDistributedAs" json:"evidence_distributed_as"`
}

// instatiate a countries EvidenceRepo
// TODO: this should be probably handled by A semantic repository
// all identifiers should be guid
var evidence01 EvidenceType = EvidenceType{EvidenceIdentifier: "1", EvidenceName: "Proof of Address", EvidenceDescription: "This is evidence 1", EvidenceDistributedAs: "File"}
var evidence02 EvidenceType = EvidenceType{EvidenceIdentifier: "2", EvidenceName: "Evidence 2", EvidenceDescription: "This is evidence 2", EvidenceDistributedAs: "File"}
var evidenceRepoIE01 EvidenceRepo = EvidenceRepo{EvidenceRepoIdentifier: "1", EvidenceRepoName: "Evidence Repo 1", EvidenceRepoDescription: "This is evidence repo 1", EvidenceTypes: []EvidenceType{evidence01, evidence02}}

// instatiate a new Evidence with values
var evidence03 EvidenceType = EvidenceType{EvidenceIdentifier: "1", EvidenceName: "Evidence 1", EvidenceDescription: "This is evidence 1", EvidenceDistributedAs: "File"}
var evidence04 EvidenceType = EvidenceType{EvidenceIdentifier: "2", EvidenceName: "Evidence 2", EvidenceDescription: "This is evidence 2", EvidenceDistributedAs: "File"}
var evidenceRepoFR01 EvidenceRepo = EvidenceRepo{EvidenceRepoIdentifier: "1", EvidenceRepoName: "Evidence Repo 1", EvidenceRepoDescription: "This is evidence repo 1", EvidenceTypes: []EvidenceType{evidence03, evidence04}}

// instatiate a new Requirement with values
var requirement01 Requirement = Requirement{RequirementIdentifier: "1", RequirementName: "Requirement 1", RequirementDescription: "This is requirement 1", EvidenceLibrary: []EvidenceRepo{evidenceRepoIE01, evidenceRepoFR01}}
var requirement02 Requirement = Requirement{RequirementIdentifier: "2", RequirementName: "Requirement 2", RequirementDescription: "This is requirement 2", EvidenceLibrary: []EvidenceRepo{evidenceRepoIE01, evidenceRepoFR01}}

// instatiate a new Procedure with values
var procedure01 Procedure = Procedure{ProcedureIdentifier: "1", ProcedureName: "Procedure 1", ProcedureDescription: "This is procedure 1", Requirements: []Requirement{requirement01, requirement02}}

// instatiate a countries EvidenceRepo
// todo this should be handled by A semantic repository
var evidence05 EvidenceType = EvidenceType{EvidenceIdentifier: "1", EvidenceName: "Evidence 1", EvidenceDescription: "This is evidence 1", EvidenceDistributedAs: "File"}
var evidence06 EvidenceType = EvidenceType{EvidenceIdentifier: "2", EvidenceName: "Evidence 2", EvidenceDescription: "This is evidence 2", EvidenceDistributedAs: "File"}
var evidenceRepoIE02 EvidenceRepo = EvidenceRepo{EvidenceRepoIdentifier: "1", EvidenceRepoName: "Evidence Repo 1", EvidenceRepoDescription: "This is evidence repo 1", EvidenceTypes: []EvidenceType{evidence05, evidence06}}

// instatiate a new Evidence with values
var evidence07 EvidenceType = EvidenceType{EvidenceIdentifier: "1", EvidenceName: "Evidence 1", EvidenceDescription: "This is evidence 1", EvidenceDistributedAs: "File"}
var evidence08 EvidenceType = EvidenceType{EvidenceIdentifier: "2", EvidenceName: "Evidence 2", EvidenceDescription: "This is evidence 2", EvidenceDistributedAs: "File"}
var evidenceRepoFR02 EvidenceRepo = EvidenceRepo{EvidenceRepoIdentifier: "1", EvidenceRepoName: "Evidence Repo 1", EvidenceRepoDescription: "This is evidence repo 1", EvidenceTypes: []EvidenceType{evidence07, evidence08}}

// instatiate a new Requirement with values
var requirement03 Requirement = Requirement{RequirementIdentifier: "1", RequirementName: "Requirement 1", RequirementDescription: "This is requirement 1", EvidenceLibrary: []EvidenceRepo{evidenceRepoIE02, evidenceRepoFR02}}
var requirement04 Requirement = Requirement{RequirementIdentifier: "2", RequirementName: "Requirement 2", RequirementDescription: "This is requirement 2", EvidenceLibrary: []EvidenceRepo{evidenceRepoIE02, evidenceRepoFR02}}

// instatiate a new Procedure with values
var procedure02 Procedure = Procedure{ProcedureIdentifier: "1", ProcedureName: "Procedure 1", ProcedureDescription: "This is procedure 1", Requirements: []Requirement{requirement03, requirement04}}

var procedures []Procedure = []Procedure{procedure01, procedure02}

// function to start the api handler
func StartEVB() {
	http.HandleFunc("/evb/procedures", proceduresHandler)
	// http.HandleFunc("/evb/requirements", requirementsHandler)
}

func proceduresHandler(w http.ResponseWriter, r *http.Request) {
	switch r.Method {
	case "GET":
		getProcedures(w, r)

	// TODO: below only available to control mode

	// case "POST":
	// 	createProcedure(w, r)
	// case "PUT":
	// 	updateProcedure(w, r)
	// case "DELETE":
	// 	deleteProcedure(w, r)

	default:
		http.Error(w, "Method not allowed", http.StatusMethodNotAllowed)
	}
}

func getProcedures(w http.ResponseWriter, r *http.Request) {
	// return all procedures in json format
	jsonBytes, err := json.Marshal(procedures)
	if err != nil {
		http.Error(w, err.Error(), http.StatusInternalServerError)
		return
	}
	w.Header().Set("Content-Type", "application/json")
	w.Write(jsonBytes)
}
