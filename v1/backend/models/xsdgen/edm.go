// Code generated by xsdgen. DO NOT EDIT.

package edm

import (
	"bytes"
	"encoding/xml"
	"time"
)

type AddressType struct {
	FullAddress       string `xml:"http://data.europa.eu/p4s FullAddress,omitempty"`
	LocatorDesignator string `xml:"http://data.europa.eu/p4s LocatorDesignator,omitempty"`
	PostCode          string `xml:"http://data.europa.eu/p4s PostCode,omitempty"`
	PostCityName      string `xml:"http://data.europa.eu/p4s PostCityName,omitempty"`
	Thoroughfare      string `xml:"http://data.europa.eu/p4s Thoroughfare,omitempty"`
	AdminUnitLevel1   string `xml:"http://data.europa.eu/p4s AdminUnitLevel1"`
	AdminUnitLevel2   string `xml:"http://data.europa.eu/p4s AdminUnitLevel2,omitempty"`
}

type AgentType struct {
	Identifier     string           `xml:"http://data.europa.eu/p4s Identifier"`
	Name           []string         `xml:"http://data.europa.eu/p4s Name"`
	Address        AddressType      `xml:"http://data.europa.eu/p4s Address,omitempty"`
	Jurisdiction   JurisdictionType `xml:"http://data.europa.eu/p4s Jurisdiction,omitempty"`
	Classification string           `xml:"http://data.europa.eu/p4s Classification,omitempty"`
}

type AttributeKeyValuePairType struct {
	AttributeName  string `xml:"http://data.europa.eu/p4s AttributeName"`
	AttributeURI   string `xml:"http://data.europa.eu/p4s AttributeURI"`
	AttributeValue string `xml:"http://data.europa.eu/p4s AttributeValue"`
}

// type DataServiceEvidenceTypeType struct {
// 	Identifier                                string                         `xml:"http://data.europa.eu/p4s Identifier"`
// 	EvidenceTypeClassification                string                         `xml:"http://data.europa.eu/p4s EvidenceTypeClassification"`
// 	Title                                     []string                       `xml:"http://data.europa.eu/p4s Title"`
// 	Description                               []string                       `xml:"http://data.europa.eu/p4s Description,omitempty"`
// 	DistributedAs                             []EvidenceTypeDistributionType `xml:"http://data.europa.eu/p4s DistributedAs"`
// 	AccessService                             []DataServiceType              `xml:"http://data.europa.eu/p4s AccessService,omitempty"`
// 	AuthenticationLevelOfAssurance            string                         `xml:"http://data.europa.eu/p4s AuthenticationLevelOfAssurance,omitempty"`
// 	EvidenceProviderJurisdictionDetermination string                         `xml:"http://data.europa.eu/p4s EvidenceProviderJurisdictionDetermination,omitempty"`
// 	EvidenceProviderClassification            []string                       `xml:"http://data.europa.eu/p4s EvidenceProviderClassification,omitempty"`
// }

// type DataServiceType struct {
// 	Identifier string               `xml:"http://data.europa.eu/p4s Identifier"`
// 	ConformsTo string               `xml:"http://data.europa.eu/p4s ConformsTo"`
// 	Publisher  EvidenceProviderType `xml:"http://data.europa.eu/p4s Publisher"`
// }

type DistributionType struct {
	Format         string   `xml:"http://data.europa.eu/p4s Format"`
	Language       []string `xml:"http://data.europa.eu/p4s Language,omitempty"`
	ConformsTo     string   `xml:"http://data.europa.eu/p4s ConformsTo,omitempty"`
	Transformation string   `xml:"http://data.europa.eu/p4s Transformation,omitempty"`
}

// type EvidenceProviderType struct {
// 	Identifier            string                   `xml:"http://data.europa.eu/p4s Identifier"`
// 	Name                  []string                 `xml:"http://data.europa.eu/p4s Name"`
// 	Address               AddressType              `xml:"http://data.europa.eu/p4s Address"`
// 	Jurisdiction          JurisdictionType         `xml:"http://data.europa.eu/p4s Jurisdiction"`
// 	ClassificationConcept []InformationConceptType `xml:"http://data.europa.eu/p4s ClassificationConcept,omitempty"`
// }

type EvidenceType struct {
	Identifier       string           `xml:"http://data.europa.eu/p4s Identifier"`
	IsAbout          IsAbout          `xml:"http://data.europa.eu/p4s IsAbout"`
	IssuingAuthority AgentType        `xml:"http://data.europa.eu/p4s IssuingAuthority"`
	IsConformantTo   EvidenceTypeType `xml:"http://data.europa.eu/p4s IsConformantTo"`
	IssuingDate      time.Time        `xml:"http://data.europa.eu/p4s IssuingDate"`
	Distribution     DistributionType `xml:"http://data.europa.eu/p4s Distribution"`
	ValidityPeriod   PeriodType       `xml:"http://data.europa.eu/p4s ValidityPeriod,omitempty"`
}

func (t *EvidenceType) MarshalXML(e *xml.Encoder, start xml.StartElement) error {
	type T EvidenceType
	var layout struct {
		*T
		IssuingDate *xsdDate `xml:"http://data.europa.eu/p4s IssuingDate"`
	}
	layout.T = (*T)(t)
	layout.IssuingDate = (*xsdDate)(&layout.T.IssuingDate)
	return e.EncodeElement(layout, start)
}
func (t *EvidenceType) UnmarshalXML(d *xml.Decoder, start xml.StartElement) error {
	type T EvidenceType
	var overlay struct {
		*T
		IssuingDate *xsdDate `xml:"http://data.europa.eu/p4s IssuingDate"`
	}
	overlay.T = (*T)(t)
	overlay.IssuingDate = (*xsdDate)(&overlay.T.IssuingDate)
	return d.DecodeElement(&overlay, &start)
}

type EvidenceTypeDistributionType struct {
	Format         string `xml:"http://data.europa.eu/p4s Format"`
	ConformsTo     string `xml:"http://data.europa.eu/p4s ConformsTo,omitempty"`
	Transformation string `xml:"http://data.europa.eu/p4s Transformation,omitempty"`
}

type EvidenceTypeListType struct {
	Identifier   string             `xml:"http://data.europa.eu/p4s Identifier"`
	Name         []string           `xml:"http://data.europa.eu/p4s Name,omitempty"`
	EvidenceType []EvidenceTypeType `xml:"http://data.europa.eu/p4s EvidenceType,omitempty"`
}

type EvidenceTypeType struct {
	EvidenceTypeClassification string             `xml:"http://data.europa.eu/p4s EvidenceTypeClassification"`
	Title                      []string           `xml:"http://data.europa.eu/p4s Title"`
	Description                []string           `xml:"http://data.europa.eu/p4s Description,omitempty"`
	Jurisdiction               []string           `xml:"http://data.europa.eu/p4s Jurisdiction,omitempty"`
	Distribution               []DistributionType `xml:"http://data.europa.eu/p4s Distribution,omitempty"`
}

// May be one of Male, Female, Unspecified
type GenderType string

type IdentifierType struct {
	Value    string `xml:",chardata"`
	SchemeID string `xml:"schemeID,attr,omitempty"`
}

// type InformationConceptType struct {
// 	Identifier      IdentifierType     `xml:"http://data.europa.eu/p4s Identifier"`
// 	Type            string             `xml:"http://data.europa.eu/p4s Type,omitempty"`
// 	ValueExpression string             `xml:"http://data.europa.eu/p4s ValueExpression,omitempty"`
// 	Description     []string           `xml:"http://data.europa.eu/p4s Description,omitempty"`
// 	SupportedValue  SupportedValueType `xml:"http://data.europa.eu/p4s SupportedValue,omitempty"`
// }

type IsAbout struct {
	NaturalPerson PersonType      `xml:"http://data.europa.eu/p4s NaturalPerson,omitempty"`
	LegalPerson   LegalPersonType `xml:"http://data.europa.eu/p4s LegalPerson,omitempty"`
}

type JurisdictionDeterminationType struct {
	JurisdictionContextId string                   `xml:"http://data.europa.eu/p4s JurisdictionContextId"`
	JurisdictionContext   []MultilingualStringType `xml:"http://data.europa.eu/p4s JurisdictionContext"`
	JurisdictionLevel     string                   `xml:"http://data.europa.eu/p4s JurisdictionLevel"`
}

type JurisdictionType struct {
	AdminUnitLevel1 string `xml:"http://data.europa.eu/p4s AdminUnitLevel1"`
	AdminUnitLevel2 string `xml:"http://data.europa.eu/p4s AdminUnitLevel2,omitempty"`
	AdminUnitLevel3 string `xml:"http://data.europa.eu/p4s AdminUnitLevel3,omitempty"`
}

type LegalPersonType struct {
	LevelOfAssurance        string                      `xml:"http://data.europa.eu/p4s LevelOfAssurance,omitempty"`
	Identifier              []string                    `xml:"http://data.europa.eu/p4s Identifier,omitempty"`
	LegalPersonIdentifier   IdentifierType              `xml:"http://data.europa.eu/p4s LegalPersonIdentifier,omitempty"`
	LegalName               string                      `xml:"http://data.europa.eu/p4s LegalName"`
	RegisteredAddress       AddressType                 `xml:"http://data.europa.eu/p4s RegisteredAddress,omitempty"`
	SectorSpecificAttribute []AttributeKeyValuePairType `xml:"http://data.europa.eu/p4s SectorSpecificAttribute,omitempty"`
}

type MultilingualStringType struct {
	Value string `xml:",chardata"`
	Lang  string `xml:"lang,attr,omitempty"`
}

type PeriodType struct {
	StartDate time.Time `xml:"http://data.europa.eu/p4s StartDate"`
	EndDate   time.Time `xml:"http://data.europa.eu/p4s EndDate"`
}

func (t *PeriodType) MarshalXML(e *xml.Encoder, start xml.StartElement) error {
	type T PeriodType
	var layout struct {
		*T
		StartDate *xsdDate `xml:"http://data.europa.eu/p4s StartDate"`
		EndDate   *xsdDate `xml:"http://data.europa.eu/p4s EndDate"`
	}
	layout.T = (*T)(t)
	layout.StartDate = (*xsdDate)(&layout.T.StartDate)
	layout.EndDate = (*xsdDate)(&layout.T.EndDate)
	return e.EncodeElement(layout, start)
}
func (t *PeriodType) UnmarshalXML(d *xml.Decoder, start xml.StartElement) error {
	type T PeriodType
	var overlay struct {
		*T
		StartDate *xsdDate `xml:"http://data.europa.eu/p4s StartDate"`
		EndDate   *xsdDate `xml:"http://data.europa.eu/p4s EndDate"`
	}
	overlay.T = (*T)(t)
	overlay.StartDate = (*xsdDate)(&overlay.T.StartDate)
	overlay.EndDate = (*xsdDate)(&overlay.T.EndDate)
	return d.DecodeElement(&overlay, &start)
}

type PersonType struct {
	LevelOfAssurance        string                      `xml:"http://data.europa.eu/p4s LevelOfAssurance,omitempty"`
	Identifier              string                      `xml:"http://data.europa.eu/p4s Identifier,omitempty"`
	FamilyName              string                      `xml:"http://data.europa.eu/p4s FamilyName"`
	GivenName               string                      `xml:"http://data.europa.eu/p4s GivenName"`
	DateOfBirth             time.Time                   `xml:"http://data.europa.eu/p4s DateOfBirth"`
	BirthName               string                      `xml:"http://data.europa.eu/p4s BirthName,omitempty"`
	PlaceOfBirth            string                      `xml:"http://data.europa.eu/p4s PlaceOfBirth,omitempty"`
	CurrentAddress          AddressType                 `xml:"http://data.europa.eu/p4s CurrentAddress,omitempty"`
	Gender                  GenderType                  `xml:"http://data.europa.eu/p4s Gender,omitempty"`
	SectorSpecificAttribute []AttributeKeyValuePairType `xml:"http://data.europa.eu/p4s SectorSpecificAttribute,omitempty"`
}

func (t *PersonType) MarshalXML(e *xml.Encoder, start xml.StartElement) error {
	type T PersonType
	var layout struct {
		*T
		DateOfBirth *xsdDate `xml:"http://data.europa.eu/p4s DateOfBirth"`
	}
	layout.T = (*T)(t)
	layout.DateOfBirth = (*xsdDate)(&layout.T.DateOfBirth)
	return e.EncodeElement(layout, start)
}
func (t *PersonType) UnmarshalXML(d *xml.Decoder, start xml.StartElement) error {
	type T PersonType
	var overlay struct {
		*T
		DateOfBirth *xsdDate `xml:"http://data.europa.eu/p4s DateOfBirth"`
	}
	overlay.T = (*T)(t)
	overlay.DateOfBirth = (*xsdDate)(&overlay.T.DateOfBirth)
	return d.DecodeElement(&overlay, &start)
}

type ReferenceFrameworkType struct {
	Identifier   string                   `xml:"http://data.europa.eu/p4s Identifier"`
	Title        []string                 `xml:"http://data.europa.eu/p4s Title,omitempty"`
	Description  []string                 `xml:"http://data.europa.eu/p4s Description,omitempty"`
	RelatedTo    []ReferenceFrameworkType `xml:"http://data.europa.eu/p4s RelatedTo,omitempty"`
	Jurisdiction string                   `xml:"http://data.europa.eu/p4s Jurisdiction,omitempty"`
}

type RequirementType struct {
	Identifier         string                   `xml:"http://data.europa.eu/p4s Identifier"`
	Name               []string                 `xml:"http://data.europa.eu/p4s Name"`
	ReferenceFramework []ReferenceFrameworkType `xml:"http://data.europa.eu/p4s ReferenceFramework,omitempty"`
	EvidenceTypeList   []EvidenceTypeListType   `xml:"http://data.europa.eu/p4s EvidenceTypeList,omitempty"`
}

// type SupportedValueType struct {
// 	StringValue  []string    `xml:"http://data.europa.eu/p4s StringValue,omitempty"`
// 	DateValue    []time.Time `xml:"http://data.europa.eu/p4s DateValue,omitempty"`
// 	BooleanValue []bool      `xml:"http://data.europa.eu/p4s BooleanValue,omitempty"`
// }

// func (t *SupportedValueType) MarshalXML(e *xml.Encoder, start xml.StartElement) error {
// 	type T SupportedValueType
// 	var layout struct {
// 		*T
// 		DateValue *xsdDate `xml:"http://data.europa.eu/p4s DateValue,omitempty"`
// 	}
// 	layout.T = (*T)(t)
// 	layout.DateValue = (*xsdDate)(&layout.T.DateValue)
// 	return e.EncodeElement(layout, start)
// }
// func (t *SupportedValueType) UnmarshalXML(d *xml.Decoder, start xml.StartElement) error {
// 	type T SupportedValueType
// 	var overlay struct {
// 		*T
// 		DateValue *xsdDate `xml:"http://data.europa.eu/p4s DateValue,omitempty"`
// 	}
// 	overlay.T = (*T)(t)
// 	overlay.DateValue = (*xsdDate)(&overlay.T.DateValue)
// 	return d.DecodeElement(&overlay, &start)
// }

type xsdDate time.Time

func (t *xsdDate) UnmarshalText(text []byte) error {
	return _unmarshalTime(text, (*time.Time)(t), "2006-01-02")
}
func (t xsdDate) MarshalText() ([]byte, error) {
	return _marshalTime((time.Time)(t), "2006-01-02")
}
func (t xsdDate) MarshalXML(e *xml.Encoder, start xml.StartElement) error {
	if (time.Time)(t).IsZero() {
		return nil
	}
	m, err := t.MarshalText()
	if err != nil {
		return err
	}
	return e.EncodeElement(m, start)
}
func (t xsdDate) MarshalXMLAttr(name xml.Name) (xml.Attr, error) {
	if (time.Time)(t).IsZero() {
		return xml.Attr{}, nil
	}
	m, err := t.MarshalText()
	return xml.Attr{Name: name, Value: string(m)}, err
}
func _unmarshalTime(text []byte, t *time.Time, format string) (err error) {
	s := string(bytes.TrimSpace(text))
	*t, err = time.Parse(format, s)
	if _, ok := err.(*time.ParseError); ok {
		*t, err = time.Parse(format+"Z07:00", s)
	}
	return err
}
func _marshalTime(t time.Time, format string) ([]byte, error) {
	return []byte(t.Format(format + "Z07:00")), nil
}