package api

import (
	"strings"

	"github.com/gofiber/fiber"
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

// TODO: this should be populared from a database

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
var procedure02 Procedure = Procedure{ProcedureIdentifier: "2", ProcedureName: "Procedure 1", ProcedureDescription: "This is procedure 1", Requirements: []Requirement{requirement03, requirement04}}

var procedures []Procedure = []Procedure{procedure01, procedure02}
var requirements []Requirement = []Requirement{requirement01, requirement02, requirement03, requirement04}
var evidenceRepos []EvidenceRepo = []EvidenceRepo{evidenceRepoIE01, evidenceRepoIE02, evidenceRepoFR01, evidenceRepoFR02}
var evidences []EvidenceType = []EvidenceType{evidence01, evidence02, evidence03, evidence04, evidence05, evidence06, evidence07, evidence08}

// function to start the api handler
func StartEVB() {
	
	app := fiber.New()

	app.Get("/evb/procedures", getProcedures)
	app.Get("/evb/procedures/:id", getProcedureByID)
	app.Get("/evb/requirements/:ids", getRequirementsByIDS)
	app.Get("/evb/evidences/:ids", getEvidencesByIDS)

	app.Listen("localhost:8080")

}

func getProcedures(c *fiber.Ctx) {
	c.JSON(procedures)
}

func getProcedureByID(c *fiber.Ctx) {
	id := c.Params("id")
	for _, procedure := range procedures {
		if procedure.ProcedureIdentifier == id {
			c.JSON(procedure.ProcedureName)
			return
		}
	}
	c.Status(404).Send("Procedure not found")
}

func getRequirementsByIDS(c *fiber.Ctx) {
	ids := c.Params("ids")
	var idsArray []string = strings.Split(ids, ",")
	var requirements []Requirement
	for _, procedure := range procedures {
		for _, requirement := range procedure.Requirements {
			for _, id := range idsArray {
				if requirement.RequirementIdentifier == id {
					requirements = append(requirements, requirement)
				}
			}
		}
	}
	c.JSON(requirements)
}

func getEvidencesByIDS(c *fiber.Ctx) {
	ids := c.Params("ids")
	var idsArray []string = strings.Split(ids, ",")
	var evidences []EvidenceType
	for _, evidenceRepo := range evidenceRepos {
		for _, evidence := range evidenceRepo.EvidenceTypes {
			for _, id := range idsArray {
				if evidence.EvidenceIdentifier == id {
					evidences = append(evidences, evidence)
				}
			}
		}
	}
	c.JSON(evidences)
}
