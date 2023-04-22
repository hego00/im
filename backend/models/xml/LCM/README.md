# The Lifecycle Management Specification(LCM) Samples

## 1. Introduction 
A Common Service MAY provide a Lifecycle Management (LCM) Interface for a bulk update of the information stored in the Common Services of a Member State. This LCM interface is a highly constrained profile based on the RegRep 4.0 LCM Manager Interface Specification that has the following limitations:

* Only the SubmitObjects protocol is supported.
* Each Member State shall authorize at most one authorized competent authority to make submissions.    
* A submission is linked to a single Member State and made on behalf of that Member State.
* Submission linked to a single Member State do not affect data related to other Member States.
* A submission contains a complete, internally consistent set of data.  It is not possible to incrementally submit objects using a series of submissions.
* In case of a successful submission made for a Member State to a Common Service, any existing data previously submitted to the Common Service for that Member State is replaced. This obviates the need for the RemoveObjects protocol.
* In case of an unsuccessful submission made for a Member State to a Common Service, the existing data held by the Common Service is retained. The CCCEV contains two basic and complementary core concepts:

## The Regrep LCM Successful Response
Upon a successful SubmitObjectsRequest message submission, the service MUST return a RegistryResponse message that MUST contain:
* A requestId attribute with the value of the id of the submitObjectsRequest that this message responds to.
* A status attribute with the value "Success"
 An example of a Regrep LCM Successful Response is available here: [3.3 The Regrep LCM Successful Response.xml](https://code.europa.eu/oots/tdd/tdd_chapters/-/blob/master/OOTS-EDM/xml/LCM/Complete%20XML%20Examples/3.6%20-%20Common%20Services%20API%20Specification/3.3%20The%20Regrep%20LCM%20Successful%20Response.xml)

## The Regrep LCM Error Response
When an error occurs during the execution of the SubmitObjectsRequest, the Common Service returns an exception. The exception has the following properties that are profiled for each expected error of the submission request. 
* xsi:type: The type of the error, selectable from a predefined set of error classes of the LCM Interface of the Common Service.
* severity: The severity of the error, selectable from a predefined set of error classes of the LCM Interface of the Common Service.
* message: A string describing the error in Human Readable form.
* code: A code for the error, specified by the Common Service Technical Design documents.
An example of RegRep LCM Error response is available here: [3.4 The Regrep LCM Error Response.xml](https://code.europa.eu/oots/tdd/tdd_chapters/-/blob/master/OOTS-EDM/xml/LCM/Complete%20XML%20Examples/3.6%20-%20Common%20Services%20API%20Specification/3.4%20The%20Regrep%20LCM%20Error%20Response.xml)

## LCM Interface Specification of the Evidence Broker
The EB LCM Interface accepts different registry objects in the SubmitObjectsRequest Message which are defined in the sections below:
### Registry Objects
#### EvidenceType
This Registry Object provides the information of the Evidence Type. The classification node used MUST be EvidenceType under the EB Classification Scheme urn:fdc:oots:classification:eb. 
#### EvidenceTypeList
This Registry Object provides the information of the Evidence Type List. It works as an intermediate class linking multiple evidence types as an atomic proof to requirements and thus it MUST NOT contain any evidence types in its structure. The classification node used MUST be EvidenceTypeList under the EB Classification Scheme urn:fdc:oots:classification:eb.
#### Requirement
This Registry Object provides the information of a Requirement in any of its derivative forms (Criterion, Information Requirement). It MUST NOT contain any Evidence Type or Reference Frameworks (Procedures) as this are provided dynamically by the use of associations. The classification node used MUST be Requirement under the EB Classification Scheme urn:fdc:oots:classification:eb.
#### ReferenceFramework 
This Registry Object ReferenceFramework provides the information of a Procedure. It MUST NOT contain any relations to other Reference Frameworks (Procedures) as this are provided dynamically by the use of associations. The classification node used MUST be ReferenceFramework under the EB Classification Scheme urn:fdc:oots:classification:eb.
#### Associations 
The EB LCM Interface accepts three distict associations linking the Registry Objects (EvidenceType, EvidenceTypeList, Requirement and ReferenceFramework) within the SubmitObjectsRequest Message. There are three different associations:
* ContainsEvidence Association provides the link between an Evidence Type List and an Evidence Type.
* FulfillsRequirement Association provides the link between an Evidence Type List and a Requirement.
* DerivesFromReferenceFramework Association provides the link between a Requirement and a ReferenceFramework (Procedure).

Example snippets for the EB are available in [3.2.5 LCM Interface Specification of the EB](https://code.europa.eu/oots/tdd/tdd_chapters/-/tree/master/OOTS-EDM/xml/LCM/Snippets/3.2.5%20LCM%20Interface%20Specification%20of%20the%20EB)
### Data Model of the LCM Submit Objects Request to the EB 
For the LCM submission, the profile uses the SubmitObjectsRequest message, as defined by the RegRep 4.0 LCM Manager Interface Specification SubmitObjects Protocol. The message MUST contain a unique id and one Registry Object List containing the Registry Objects under submission.
An example of the LCM Submit Objects Request to the EB is shown in the following XML sample: [5.4 LCM Submit Objects to the Evidence Broker - Birth Certificate.xml](https://code.europa.eu/oots/tdd/tdd_chapters/-/blob/master/OOTS-EDM/xml/LCM/Complete%20XML%20Examples/3.2.5%20LCM%20Interface%20Specification%20of%20the%20EB/5.4%20LCM%20Submit%20Objects%20to%20the%20Evidence%20Broker%20-%20Birth%20Certificate.xml)

## LCM Interface Specification of the Data Service Directory
The DSD Service provides an Regrep 4.0 based LCM API, following the Regrep 4.0 LCM SubmitObjects Profile of the OOTS Common Services.
The DSD LCM Interface accepts two different registry objects in the SubmitObjectsRequest Message which are defined in the sections below:
#### DataServiceEvidenceType
This Registry Object provides the information on the Data Service Evidence Type. It MUST NOT contain the Access Service and the Evidence Provider details, as these are provided through the use of associations with EvidenceProvider Registry Objects (Access Service). The classification node used MUST be DataServiceEvidenceType under the DSD Classification Scheme urn:fdc:oots:classification:dsd.
#### Evidence Provider (Access Service)
This Registry Object provides the information of the Evidence Provider (Access Service). The classification node used MUST be EvidenceProvider under the DSD Classification Scheme urn:fdc:oots:classification:dsd.
Example snippets for DSD are available in [3.1.5 LCM Interface Specification of the DSD](https://code.europa.eu/oots/tdd/tdd_chapters/-/tree/master/OOTS-EDM/xml/LCM/Snippets/3.1.5%20LCM%20Interface%20Specification%20of%20the%20DSD)
### A complete Example of a LCM Submit Objects Request to the DSD
The following example shows a complete example of a possible bulk upload for a member state, submitting an evidence provider, a DataserviceEvidenceType and an association that links them together: [5.5 LCM Submit Objects to the DSD - Birth Certificate.xml](https://code.europa.eu/oots/tdd/tdd_chapters/-/blob/master/OOTS-EDM/xml/LCM/Complete%20XML%20Examples/3.1.5%20LCM%20Interface%20Specification%20of%20the%20DSD/5.5%20LCM%20Submit%20Objects%20to%20the%20DSD%20-%20Birth%20Certificate.xml)


