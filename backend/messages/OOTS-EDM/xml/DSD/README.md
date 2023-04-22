# DSD Samples

## 1. Introduction 
The Data Service Directory is a Common Service defined in the OOTS HLA. It maintains a catalog of Evidence Providers with the Evidence Types they are able to provide upon request using their Data Services. It is used in the Evidence Exchange process by the Evidence Requesters to discover the Evidence Providers that can provide the evidences they require, together with the required metadata and attributes imposed by the Data Services, like the classifications and context determinations of the Evidence Providers.
The information data model is based on the SDGR Application Profile for the DSD. The Service API is implemented using the OASIS RegRep v4 Query Protocol with the REST API Binding.
The main functionality of the DSD is to publish Data Services of Evidence Providers that provide distributions of Evidence Types and make them discoverable through queries. The functionality requires four main classes of Information:
* The DataServiceEvidenceType, providing the semantic information and requirements for retrieving an evidence type from a Data Service.
* The Distribution of the DataServiceEvidenceType, describing the format, the semantic and syntactic conformance, under which the Evidence Type can be distributed.
* The DataService, describing the technical endpoint from which an Evidence Requester can request the Evidence distributions.
* The EvidenceProvider, describing the details of the Provider of the Evidence.
The Request-Response samples can be found in the [OOTS-EDM/XML folder of the tdd_chapters git repository](https://code.europa.eu/oots/tdd/tdd_chapters/-/tree/master/OOTS-EDM/xml).
In this section, some examples for the evidence exchange using the OOTS Exchange Data Model are provided. 

## 2. Information Model
The DSD information Data Model is based on the SDGR Application Profile for the DSD. It is based on the semantic classes of Evidence Type derived from the CCCEV v2.0, the DataService from DCAT and the Organization Class from the Core Public Organisation Vocabularies. It provides all the information aspects of the model, including the data types, use of Identifiers and code lists for every element used in this profile. The serialization of the model is done using XML according to the guidelines below. Below is an example of the XML representation of a Data Service serving an Evidence Type as it is contained in the DSD.
The DataServiceEvidenceType consists of specific groups of elements covering different contextual metadata required for a successful Evidence Exchange:
* Evidence Type Metadata, providing information on the qualities of the Evidence Type.
* Data Service Metadata, providing information on the identification, distinction, location and jurisdiction of the Evidence Providers and its Data Services.

The following sub-sections provide an overview of the use of elements and attributes found in this class with a detailed explanation.

##     2.1. Evidence Type Metadata
The Evidence type metadata describes specific aspects of the evidence type such as:

* The Identifier, using the Identifier element, provided by the Data Services to uniquely identify an Evidence Type with its required metadata. This identifier is used by the Evidence Requester in the Evidence Exchange Request, to identify the Evidence Type to be retrieved by the Data Service.
* The available distributions, using the DistributedAs element. The distributions provide the available formats for the Evidence Type, such as PDF, XML, JSON etc, using code values from the [OOTSMediaTypes codelist](https://code.europa.eu/oots/tdd/tdd_chapters/-/blob/master/OOTS-EDM/codelists/OOTS/OOTSMediaTypes-CodeList.gc) . For the file types that provide structured content like XML, JSON, the Data Service can provide a conformance statement, using the conformsTo (and for subsets of stuctured content the information entity Transformation) sub-element of the DistributedAs element, for denoting the semantic and technical conformance profile. The element's value is a persistent URL, pointing to an entry of the OOTS Semantic Repository that contains all the relevant information of such a profile.

##     2.2. Data Service Metadata 
The Data Service metadata provides the necessary information needed for selecting the proper Evidence Provider and its relevant Data Service. It consists of:
* The Data Service Identifier, using the AccessService/Identifier element that is used by the eDelivery infrastructure to extract and use the proper pre-configured PMode for the submission of the Evidence Request - Corner 3 (C3). C3 is an Access Point that receives messages on behalf of C4. This identifier is profiled as a CEF eDelivery ebcore Party Identifier. The scheme ID must point to a valid Electronic Address Scheme (EAS) from the codelist [EAS.gc](https://code.europa.eu/oots/tdd/tdd_chapters/-/blob/master/OOTS-EDM/codelists/External/EAS.gc). 
* The Evidence Exchange Message Data Model Profile and version, denoted in the AccessService/ConformsTo element. Currently, the only value allowed is the oots-edm:v1.0. 
* The Publisher element, providing the Name, Location and Jurisdiction of the Evidence Provider, used by the Evidence Requester for filtering and selection of the correct Evidence Provider.
* The Evidence Provider Determination Context, defining the location context of the Evidence provider. For example, if the determination context is "Place of Birth", it means that the jurisdiction of the Evidence provider must match the place of birth of the user.

##     2.3. Evidence Provider Discovery Metadata
### Evidence Provider Jurisdiction mapping to user attribute
The jurisdiction of the Evidence Provider is usually contextualized with a specific property of the user and the issued evidence type. A birth certificate registry's jurisdiction for example must match the user's place of birth at a specific level of jurisdiction. The DSD contains the EvidenceProviderJurisdictionDetermination attribute that defines the required mapping of the Evidence Provider's jurisdiction, in the DataServiceEvidenceType element. The attribute consists of the following sub-attributes:

* The Jurisdiction Context Identifier that is used as part of the query API for providing the response to the DSD by the User
* The Jurisdiction Context itself, which is a multilingual string describing the context as it should be displayed by the Evidence Requester's UI
* The Jurisdiction Level required, defining the required granularity of the jurisdiction according to the [JurisdictionLevel codelist](https://code.europa.eu/oots/tdd/tdd_chapters/-/blob/master/OOTS-EDM/codelists/OOTS/JurisdictionLevel-CodeList.gc) .

The following example describes an entry in the DSD:

    <sdg:EvidenceProviderJurisdictionDetermination> \
        <!-- The Unique Identifier of this EvidenceProviderJurisdictionDetermination --> \
        <sdg:JurisdictionContextId>5ce148b9-5578-4049-aecf-af7bb55714b5</sdg:JurisdictionContextId> \
        <sdg:JurisdictionContext lang="EN">Place Of Birth</sdg:JurisdictionContext> \
        <sdg:JurisdictionContext lang="DE">Geburtsort</sdg:JurisdictionContext> \
        <!-- Codelist defining the jurisdiction levels, published in the semantic repository - JurisdictionLevel-CodeList.gc --> \
        <sdg:JurisdictionLevel>LAU</sdg:JurisdictionLevel> \
    </sdg:EvidenceProviderJurisdictionDetermination> \

##     2.3.1. Provider Context Determination
Although the jurisdiction mapping can be the main attribute for discovering the Evidence Provider, there are situations where the Evidence Provider must be further classified, depending on domain-specific quality attributes. 
For example, a registry containing social security and/or insurance contracts covers only specific kinds of insurance (Private, Public, Mixed) or could cover only specific kinds of subjects, (e.g. SMEs, very large companies, construction companies, etc.). 
These domain-specific quality attributes must be declared in the Evidence Provider's DSD information and also in the DataServiceEvidenceType structure as a mandatory classification filter that needs to be provided by the Evidence Requester. 
The DSD represents these attributes using the CCCEV 2.0 Information Concept structure. The Evidence Provider declares the qualities supported together with the supported values, as shown in the example below:

    <sdg:AccessService> \
        <sdg:Identifier schemeID="urn:cef.eu:names:identifier:EAS:0060">8889909099</sdg:Identifier> \
        <sdg:ConformsTo>oots-edm:v1.0</sdg:ConformsTo> \
        <sdg:Publisher> \
             /* Omitted ... */ \
            <!-- Information Concepts that classify the Evidence Provider.  --> \
            <!--  In this example the capability of the publisher is to provide information if the applicant has resided in the country --> \
            <sdg:ClassificationConcept> \
                <!-- The Unique Identifier of this Classification Concept defined by the element <sdg:EvidenceProviderClassification> --> \
                <sdg:Identifier>b07146b6-1468-41a7-a10f-ee2a61429dbc</sdg:Identifier> \
                <sdg:Type>Codelist</sdg:Type> \
                <!-- Definition of the value expression. Must be published in the Semantic Repository. In this example the URL points to the codelist "countryresidence" with two values "ApplicantHasBeenResidentInGermany" and "ApplicantHasNeverBeenResidentInGermany"  --> \
                <sdg:ValueExpression>https://sr.oots.tech.europa.eu/ep-classification/de/countryresidence</sdg:ValueExpression> \
                <sdg:Description lang="EN">Rules of responsibility for the processing of personal status cases of German citizens without residence information \
                </sdg:Description> \
                <sdg:Description lang="DE">Zuständigkeitsregelungen für die Bearbeitung von personenstandsrechtlichen Vorgängen deutscher Staatsangehöriger ohne Wohnsitzinformation</sdg:Description> \
                <!--  The string values indicate that the Publisher is only able to provide information if the applicant has ever resided in Germany  --> \
                <sdg:SupportedValue> \
                    <sdg:StringValue>ApplicantHasBeenResidentInGermany</sdg:StringValue> \
                </sdg:SupportedValue> \
            </sdg:ClassificationConcept> \
        /* Omitted ... */ \
        </sdg:Publisher> \
    </sdg:AccessService> \

##     2.3.2. Evidence Provider Classification
Classification concepts must be  present in the DataServiceEvidenceType for supporting a filtering mechanism at the Evidence Requester side. 
The classification concepts are listed, using CCCEV 2.0 at the DataServiceEvidenceType as the following example:

    <!-- Determination of the EvidenceProviderClassification to the User's attributes. In this example the applicant must indicate if he has ever resided in the country.  --> \
    <sdg:EvidenceProviderClassification> \
        <!-- The Unique Identifier of this EvidenceProviderClassification reused by the element <sdg:ClassificationConcept> of Publishers --> \
        <sdg:Identifier>b07146b6-1468-41a7-a10f-ee2a61429dbc</sdg:Identifier> \
        <sdg:Type>Codelist</sdg:Type> \
        <!-- Definition of the value expression. Must be published in the Semantic Repository. The codelist contains the values ApplicantHasNeverBeenResidentInGermany and ApplicantHasBeenResidentInGermany --> \
        <!-- During the query process the user has to select one of the two values as additional input parameter for the query in order to identify the correct publisher / evidence provider --> \
        <!-- The selected value will be mapped against the SupportedValue of Publishers --> \
        <sdg:ValueExpression>https://sr.oots.tech.europa.eu/ep-classification/de/countryresidence</sdg:ValueExpression> \
        <sdg:Description lang="EN">Rules of responsibility for the processing of personal status cases of German citizens without residence information \
        </sdg:Description> \
        <sdg:Description lang="DE">Zuständigkeitsregelungen für die Bearbeitung von personenstandsrechtlichen Vorgängen deutscher Staatsangehöriger ohne Wohnsitzinformation</sdg:Description> \
    </sdg:EvidenceProviderClassification> \

## 3. Query Interface Specification
The query interface specification for the Data Service Directory is based on the OASIS ebXML RegRep V4 standard. This standard has multiple protocol bindings that can 
be used to execute queries. Since the DSD queries have only simple, single-value parameters, the REST binding is used to implement the DSD query interface. 
This implies that the query transaction is executed as an HTTP GET request with the URL representing the query to execute and the HTTP response carrying the query response 
as an XML document. This section further profiles the REST binding as specified in the OASIS RegRep standard for use by the DSD.

##     3.1 Query Response of the DSD simple flow
An example of a successful QueryResponse of the DSD providing a collection of Data Services of Service Providers for a specific Evidence Type is shown in file 
[4.3. Query Response of the DSD - Secondary Education.xml](https://code.europa.eu/oots/tdd/tdd_chapters/-/blob/master/OOTS-EDM/xml/DSD/Complete%20XML%20examples%20%28DSD%29/4.3.%20Query%20Response%20of%20the%20DSD%20-%20Secondary%20Education.xml)

##     3.2 Query Error Response of the DSD
The Query Error Response of the DSD is syntactically expressed inside an [ebRS QueryResponse](http://docs.oasis-open.org/regrep/regrep-core/v4.0/os/regrep-core-rs-v4.0-os.html#__RefHeading__32277_422331532) using the [ebRS RegistryExceptionType](http://docs.oasis-open.org/regrep/regrep-core/v4.0/os/regrep-core-rs-v4.0-os.html#__RefHeading__32237_422331532). 
An example of Query Error Responses of the DSD due to an empty result set of the Data Service is shown in the following XML snippet:

    <query:QueryResponse xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" \
        xmlns:rs="urn:oasis:names:tc:ebxml-regrep:xsd:rs:4.0" \
        xmlns:rim="urn:oasis:names:tc:ebxml-regrep:xsd:rim:4.0" \
        xmlns:query="urn:oasis:names:tc:ebxml-regrep:xsd:query:4.0" \
        xmlns:xlink="http://www.w3.org/1999/xlink" \
        status="urn:oasis:names:tc:ebxml-regrep:ResponseStatusType:Failure"> \
        <rs:Exception \
            xsi:type="rs:ObjectNotFoundExceptionType" \
            severity="urn:oasis:names:tc:ebxml-regrep:ErrorSeverityType:Error" \
            message="No Data services were found based on the given parameters" \
            code="DSD:ERR:0001"> \
        </rs:Exception> \
    </query:QueryResponse> \

The file [4.4.1 Query Error Response of the DSD - Secondary Education.xml](https://code.europa.eu/oots/tdd/tdd_chapters/-/blob/master/OOTS-EDM/xml/DSD/Complete%20XML%20examples%20%28DSD%29/4.4.1%20Query%20Error%20Response%20of%20the%20DSD%20-%20Secondary%20Education.xml)

DSD Error Response Codes:

| ID| Message|Type|Code|Detail|  		
|----|----------------------------|---------------------------------|-------------------|----------------------------|
|1  | Data Services Not Found  | rs:ObjectNotFoundExceptionType |DSD:ERR:0001 |No Data Services were found based on the given parameters |
|2  | Evidence Type Not Found | rs:ObjectNotFoundExceptionType |DSD:ERR:0002 |The Evidence requested cannot be found|
|3  | Bad Query Parameters | rs:InvalidRequestExceptionType |DSD:ERR:0003 |The query parameters do not follow the query specification|
|4  | Unknown Query| rs:InvalidRequestExceptionType |DSD:ERR:0004 |The requested Query does not exist|
|5  | Additional Parameters Required | rs:ObjectNotFoundExceptionType |DSD:ERR:0005 |The query requires the included extra attributes to be provided by the user|
|6  | Incorrect Parameter Value | rs:InvalidRequestExceptionType |DSD:ERR:0006 |Incorrect provided value for requested parameters|				

##     3.3. DSD Response Requesting Additional User Provided Attributes 

##     3.3.1. First Request
The Evidence Requester needs to fetch the Evidence Providers that can provide an evidence type with Evidence Type Classification https://sr.oots.tech.europa.eu/evidencetypeclassifications/DE/ca8afed6-2dc0-422a-a931-d21c3d8d370e (Certificate of Birth) in Germany, as it was extracted from the Evidence Broker. To do this, it executes the following HTTP REST Call to the DSD:
Example first request: «server base url»/rest/search?queryId=urn:fdc:oots:dsd:ebxml-regrep:queries:dataservices-by-evidencetype-and-jurisdiction&evidence-type-classification= https://sr.oots.tech.europa.eu/evidencetypeclassifications/DE/ca8afed6-2dc0-422a-a931-d21c3d8d370e&country-code=DE
The request to the DSD cannot be responded but a DataServiceEvidenceType exists that contains EvidenceProviderJurisdictionDetermination (jurisdiction-context-id) and/or an EvidenceProviderClassification (evidence-type-id) scheme. 
The DSD will provide a error response requesting additional User Provided Attributes [4.4.3. Query Error Response of the DSD requesting additional User Provided Attributes - Birth Certificate - DSD-ERR005.xml](https://code.europa.eu/oots/tdd/tdd_chapters/-/blob/master/OOTS-EDM/xml/DSD/Complete%20XML%20examples%20%28DSD%29/4.4.3.%20Query%20Error%20Response%20of%20the%20DSD%20requesting%20additional%20User%20Provided%20Attributes%20-%20Birth%20Certificate%20-%20DSD-ERR005.xml) whereas the exception response is returned with error code DSD:ERR:0005. The error code DSD:ERR:0005 points to a follow up query with the additional user provided attributes required to answer the query successfully.

##     3.3.2. Second Request
In our example, the first request returns an exception response with error code DSD:ERR:0005 requesting information on both the jurisdiction-context-id and the evidence-type-id schemes. The values for these parameters are user provided and must be based upon the [Codelists](https://code.europa.eu/oots/tdd/tdd_chapters/-/tree/master/OOTS-EDM/codelists/OOTS) published in the Semantic Repository. 
The Evidence Requester will then request the following information from the user:
* the Place of Birth location, using the LAU codes of country DE
* an indication, if the user has ever resided in the country based on a codelist published under the following URL in the semantic repository https://sr.oots.tech.europa.eu/ep-classification/de/countryresidence distinghishing between "ApplicantHasNeverBeenResidentInGermany" and "ApplicantHasBeenResidentInGermany"  

With the information given by the user (LAU code = 11000000; EvidenceProviderClassification = ApplicantHasBeenResidentInGermany), the Evidence requester then create a new HTTP as follows:
Example second request: «server base url» /rest/search?queryId=urn:fdc:oots:dsd:ebxml-regrep:queries:dataservices-by-evidencetype-and-jurisdiction&evidence-type-classification=https://sr.oots.tech.europa.eu/evidencetypeclassifications/DE/ca8afed6-2dc0-422a-a931-d21c3d8d370e&country-code=DE&evidence-type-id=2af27699-f131-4411-8fdb-9e8cd4e8bded&jurisdiction-context-id=5ce148b9-5578-4049-aecf-af7bb55714b5&jurisdiction-admin-l3=11000000&b07146b6-1468-41a7-a10f-ee2a61429dbc=ApplicantHasBeenResidentInGermany
The DSD will provide a successful response [4.3. Query Response of the DSD - Birth Certificate.xml](https://code.europa.eu/oots/tdd/tdd_chapters/-/blob/master/OOTS-EDM/xml/DSD/Complete%20XML%20examples%20%28DSD%28/4.3.%20Query%20Response%20of%20the%20DSD%20-%20Birth%20Certificate.xml)

## 4. DSD Interaction Example
##     4.1. Registration of Data Services and Evidence Providers by the MS
In this example flow, a MS has registered a Certificate of Birth evidence type through the DSD LCM Interface (see section 5). For the specific Member State DE, the evidence type is issued by Evidence Providers that are located in the same region as the Place of Birth and thus the Jurisdiction Determination context is "Place of Birth", with the response required to be a LAU based code.
This specific evidence type also depends on Evidence Provider Classification. Although several Evidence Providers can issue the specific evidence type, only some Evidence Providers can issue the evidence type if the applicant has never resided in Germany. Thus, a classification scheme of the Evidence Providers must be declared in the DataServiceEvidenceType using the Evidence Provider Classification mechanism.
The Evidence Providers of the specific MS have been registered with their capability on providing the Certificate of Birth and they have been associated to the specific DataServiceEvidenceType registered by the Member State DE. For the example, two Evidence Providers are able to issue this evidence type for DE, but they are assigned different types of classifications. Civil Registration Office Berlin I (Evidence Provider 1) supports birth certificates for applicants that have either resided or not resided in Germany and while Civil Registration Office Hamburg (Evidence Provider 2) only provides birth certificates if the applicant has resided in Germany.  Civil Registration Office Berlin I (Evidence Provider 1) is associated to the Jurisdiction 11000000 (LAU code) while Civil Registration Office Hamburg (Evidence Provider 2) operates under the Jurisdiction 02000000 (LAU code).
The following example shows how this jurisdiction context is defined and how the declaration of the classification scheme required for this evidence type is defined my a MS in the DSD DataServiceEvidenceType. Also it shows how the data services will be properly declared to contain also these classifications: 
[4.8.3. Data Services and Evidence Providers registered by the MS II](https://code.europa.eu/oots/tdd/tdd_chapters/-/blob/master/OOTS-EDM/xml/DSD/Snippets%20-%203.1.1%20Data%20Service%20Directory%20(DSD)/3.1.4%20Query%20Interface%20Specification%20of%20the%20DSD/4.8.3.%20Data%20Services%20and%20Evidence%20Providers%20registered%20by%20the%20MS%20II)



