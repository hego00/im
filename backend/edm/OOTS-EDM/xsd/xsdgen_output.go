// Code generated by xsdgen. DO NOT EDIT.

package ws

import "encoding/xml"

// May be one of onLoad, onRequest, other, none
type ActuateType string

// May be one of
type Anon2 string

type ArcType struct {
	Title     []string `xml:"http://www.w3.org/1999/xlink title,omitempty"`
	Type      string   `xml:"type,attr"`
	Arcrole   string   `xml:"arcrole,attr,omitempty"`
	TitleAttr string   `xml:"title,attr,omitempty"`
	Show      string   `xml:"show,attr,omitempty"`
	Actuate   string   `xml:"actuate,attr,omitempty"`
	From      string   `xml:"from,attr,omitempty"`
	To        string   `xml:"to,attr,omitempty"`
}

// Must be at least 1 items long
type ArcroleType string

type EndpointReferenceType struct {
	Items               []string `xml:",any"`
	Address             string   `xml:"http://www.w3.org/2005/08/addressing Address"`
	ReferenceParameters string   `xml:"http://www.w3.org/2005/08/addressing ReferenceParameters,omitempty"`
	Metadata            string   `xml:"http://www.w3.org/2005/08/addressing Metadata,omitempty"`
}

// Intended for use as the type of user-declared elements to make them
// extended links.
// Note that the elements referenced in the content model are all abstract.
// The intention is that by simply declaring elements with these as their
// substitutionGroup, all the right things will happen.
type Extended struct {
	Title     string `xml:"http://www.w3.org/1999/xlink title,omitempty"`
	Resource  string `xml:"http://www.w3.org/1999/xlink resource,omitempty"`
	Locator   string `xml:"http://www.w3.org/1999/xlink locator,omitempty"`
	Arc       string `xml:"http://www.w3.org/1999/xlink arc,omitempty"`
	Type      string `xml:"type,attr"`
	Role      string `xml:"role,attr,omitempty"`
	TitleAttr string `xml:"title,attr,omitempty"`
}

type FaultCodesOpenEnumType string

// May be one of tns:InvalidAddressingHeader, tns:InvalidAddress, tns:InvalidEPR, tns:InvalidCardinality, tns:MissingAddressInEPR, tns:DuplicateMessageID, tns:ActionMismatch, tns:MessageAddressingHeaderRequired, tns:DestinationUnreachable, tns:ActionNotSupported, tns:EndpointUnavailable
type FaultCodesType xml.Name

type Lang string

type LocatorType struct {
	Title     []string `xml:"http://www.w3.org/1999/xlink title,omitempty"`
	Type      string   `xml:"type,attr"`
	Role      string   `xml:"role,attr,omitempty"`
	TitleAttr string   `xml:"title,attr,omitempty"`
	Label     string   `xml:"label,attr,omitempty"`
}

type MetadataType []string

func (a MetadataType) MarshalXML(e *xml.Encoder, start xml.StartElement) error {
	var output struct {
		ArrayType string   `xml:"http://schemas.xmlsoap.org/wsdl/ arrayType,attr"`
		Items     []string `xml:" item"`
	}
	output.Items = []string(a)
	start.Attr = append(start.Attr, xml.Attr{Name: xml.Name{"", "xmlns:ns1"}, Value: "http://www.w3.org/2001/XMLSchema"})
	output.ArrayType = "ns1:anyType[]"
	return e.EncodeElement(&output, start)
}
func (a *MetadataType) UnmarshalXML(d *xml.Decoder, start xml.StartElement) (err error) {
	var tok xml.Token
	for tok, err = d.Token(); err == nil; tok, err = d.Token() {
		if tok, ok := tok.(xml.StartElement); ok {
			var item string
			if err = d.DecodeElement(&item, &tok); err == nil {
				*a = append(*a, item)
			}
		}
		if _, ok := tok.(xml.EndElement); ok {
			break
		}
	}
	return err
}

type ProblemActionType struct {
	Action     string `xml:"http://www.w3.org/2005/08/addressing Action,omitempty"`
	SoapAction string `xml:"http://www.w3.org/2005/08/addressing SoapAction,omitempty"`
}

type ReferenceParametersType []string

func (a ReferenceParametersType) MarshalXML(e *xml.Encoder, start xml.StartElement) error {
	var output struct {
		ArrayType string   `xml:"http://schemas.xmlsoap.org/wsdl/ arrayType,attr"`
		Items     []string `xml:" item"`
	}
	output.Items = []string(a)
	start.Attr = append(start.Attr, xml.Attr{Name: xml.Name{"", "xmlns:ns1"}, Value: "http://www.w3.org/2001/XMLSchema"})
	output.ArrayType = "ns1:anyType[]"
	return e.EncodeElement(&output, start)
}
func (a *ReferenceParametersType) UnmarshalXML(d *xml.Decoder, start xml.StartElement) (err error) {
	var tok xml.Token
	for tok, err = d.Token(); err == nil; tok, err = d.Token() {
		if tok, ok := tok.(xml.StartElement); ok {
			var item string
			if err = d.DecodeElement(&item, &tok); err == nil {
				*a = append(*a, item)
			}
		}
		if _, ok := tok.(xml.EndElement); ok {
			break
		}
	}
	return err
}

type RelatesToType struct {
	Value            string                   `xml:",chardata"`
	RelationshipType RelationshipTypeOpenEnum `xml:"RelationshipType,attr,omitempty"`
}

func (t *RelatesToType) UnmarshalXML(d *xml.Decoder, start xml.StartElement) error {
	type T RelatesToType
	var overlay struct {
		*T
		RelationshipType *RelationshipTypeOpenEnum `xml:"RelationshipType,attr,omitempty"`
	}
	overlay.T = (*T)(t)
	overlay.RelationshipType = (*RelationshipTypeOpenEnum)(&overlay.T.RelationshipType)
	return d.DecodeElement(&overlay, &start)
}

// May be one of http://www.w3.org/2005/08/addressing/reply
type RelationshipType string

type RelationshipTypeOpenEnum string

type ResourceType struct {
	Items []string `xml:",any"`
	Type  string   `xml:"type,attr"`
	Role  string   `xml:"role,attr,omitempty"`
	Title string   `xml:"title,attr,omitempty"`
	Label string   `xml:"label,attr,omitempty"`
}

// Must be at least 1 items long
type RoleType string

// May be one of new, replace, embed, other, none
type ShowType string

// Intended for use as the type of user-declared elements to make them
// simple links.
type Simple struct {
	Items   []string `xml:",any"`
	Type    string   `xml:"type,attr,omitempty"`
	Role    string   `xml:"role,attr,omitempty"`
	Arcrole string   `xml:"arcrole,attr,omitempty"`
	Title   string   `xml:"title,attr,omitempty"`
	Show    string   `xml:"show,attr,omitempty"`
	Actuate string   `xml:"actuate,attr,omitempty"`
}

// May be one of default, preserve
type Space string

type TitleEltType struct {
	Items []string `xml:",any"`
	Type  string   `xml:"type,attr"`
	Lang  string   `xml:"lang,attr,omitempty"`
}

// May be one of simple, extended, title, resource, locator, arc
type TypeType string
