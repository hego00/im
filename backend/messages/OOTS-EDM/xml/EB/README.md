# Evidence Broker Samples

## 1. Introduction 
The Evidence Broker is one of the Common Services of the OOTS HLA. It is a service that publishes which types of evidence Member States can provide to prove a particular requirement of a procedure. It provides metadata on the requirements applicable in a procedure and which type of evidence can be used by the User to prove fulfilment. Using the mapping from criteria or information requirements to possible evidence types, the Evidence Requester can find the evidence types that can prove that the User fulfills the requirements of the procedure.
The EB Information Model is based on the ISA2 SEMIC Core Criterion and Core Evidence Vocabulary (CCCEV) v2.0. The CCCEV is designed to support the exchange of information between organisations defining requirements and organisations responding to these requirements by means of evidence types.
### 1.1. Information model
The CCCEV contains two basic and complementary core concepts:
* The Requirement, which is used as the basis for making a judgement or decision, e.g. a requirement set in a public tender or a condition that has to be fulfilled for a public service to be executed;
* The Evidence Type, which proves that something else exists or is true. In particular, an evidence is used to prove that a specific requirement is met by someone or by something.
## 2. Requirement Model
One of the central concepts of the Evidence Broker is the ‘Requirement’. It is a condition or prerequisite that someone requests and someone else has to meet.

The requirement is realised by three concrete types of requirements: The Information Requirement, the Criterion and the Constraint.
* The Information Requirement is to be seen as a request for data that proves one or more facts of the real world, or that leads to the source of such a proof.
* The Criterion is to be seen as a condition that will be evaluated.
* The Constraint is a limitation imposed on any type of requirement or on an element defined inside a requirement.

1.2. Criterion to Evidence Type Mapping Mechanism
The EB mapping mechanism is a requirement-oriented one. It assumes that each procedure has one or more specific requirements that need to be fulfilled by the User that executes the procedure. Conceptually, the mapping process follows the steps below:
* A Member State implementing a procedure, has identified a requirement that must be fulfilled by the user executing the procedure.
* It initially checks whether this requirement already exists and has been addressed within the scope of this or another procedure, by scanning the list of available requirements.
* If the requirement does not already exist, the Member State requests a requirement addition for the specific procedure. If it exists, then it maps this requirement as part of the implementation of the procedure in the Member State.
* Member States providing evidence need to map the specific new requirement with list of evidence types that prove the requirement added, by adding evidence types. These evidence types MUST be registered in the codelist of evidence type classifications, published by the semantic repository.

For the pivoting mechanism to work, each requirement MUST have a EU-wide scope so that is visible and mappable to evidence types issued by all the MSs.

## 2. Query Interface 
The query interface specification for the Evidence Broker is based on the OASIS ebXML RegRep V4 standard. This standard has multiple protocol bindings that can be used to execute queries. Since the EB queries have only simple, single-value parameters, the REST binding is used to implement the EB query interface. This implies that the query transaction is executed as an HTTP GET request with the URL representing the query to execute and the HTTP response carrying the query response as an XML document. 
###     2.1. Get List of Requirements Query
The URL pattern for parameterised query invocation is defined as follows in the OASIS RegRep REST binding:
    «server base url»/rest/search?queryId={the query id}(&{param-name}={param-value})*
    Example flow
The Evidence Requester needs to fetch requirements that are associated to a procedure and country. To do this, it executes the following HTTP REST Call to the EB with the included values R1 for procedure-id (R1 relates to "Requesting a birth certificate") and DE for country-code (for Germany). The parameter values have to be looked up in the codelists published in the semantic repository:
«server base url»/rest/search?queryId=urn:fdc:oots:eb:ebxml-regrep:queries:requirements-by-procedure-and-jurisdiction&procedure-id=R1&country-code=DE

The EB receives the request and checks whether requirements for procedure-id = R1 and country-code = DE exist. Two potential responses can be given thus the following flows must distinguished:
* Positive Flow​: a Requirement exists and the EB will provide a Query Response
The following sample shows a positive response: 
[4.2. Get List of Requirements Query - Birth Certificate.xml](https://code.europa.eu/oots/tdd/tdd_chapters/-/blob/master/OOTS-EDM/xml/EB/Complete%20XML%20examples%20%28EB%29/4.2.%20Get%20List%20of%20Requirements%20Query%20-%20Birth%20Certificate.xml)

* Negative Flow: the request to the EB cannot be responded and an exception response is returned. The EB will provide an Error Response resulting in a query:Exception
The following sample shows a negative response:
[4.4. Query Error Response of the Evidence Broker - Birth.xml](https://code.europa.eu/oots/tdd/tdd_chapters/-/blob/master/OOTS-EDM/xml/EB/Complete%20XML%20examples%20(EB)/4.4.%20Query%20Error%20Response%20of%20the%20Evidence%20Broker%20-%20Birth.xml)

###     2.2. Example of the Query Response of the EB for the "Get Evidence Types for Requirement Query"
The Query Response of the EB  for Evidence Types that prove a specific requirement returns a RegRep QueryResponse document which MUST either contain an Exception or RegistryObjectList element with zero or more RegistryObjects. Each RegistryObject in the result MUST include one Slot element with a SlotValue of type rim:AnyValueType and a single Requirement child element, following the SDGR Application Profile of the EB. The SDGR application profile of the EB describes how the SDG-Generic-Metadata Profile (SDG-syntax) is profiled in ebRIM in order to compose a valid QueryResponse. It therefore contains a mapping to the underlying SDG-syntax elements and necessary parameters to compose a QueryResponse.  The namespace of the SDG-syntax is http://data.europa.eu/p4s. 
* Positive Flow​:
The following example shows a response using the SDG Application Profile XML Representation.
[4.3. Get Evidence Types for Requirement Query - Social Security Contributions.xml](https://code.europa.eu/oots/tdd/tdd_chapters/-/blob/master/OOTS-EDM/xml/EB/Complete%20XML%20examples%20(EB)/4.3.%20Get%20Evidence%20Types%20for%20Requirement%20Query%20-%20Social%20Security%20Contributions.xml)
* Negative Flow:
The following sample shows a negative response:
[4.4. Query Error Response of the Evidence Broker - Social Security Contributions.xml](https://code.europa.eu/oots/tdd/tdd_chapters/-/blob/master/OOTS-EDM/xml/EB/Complete%20XML%20examples%20(EB)/4.4.%20Query%20Error%20Response%20of%20the%20Evidence%20Broker%20-%20Social%20Security%20Contributions.xml)
###     2.3. Example of the Query Error Response of the Evidence Broker
An example of Query Error Responses of the Evidence Broker due to an empty list of requirements is shown in the following XML sample:
[4.4. Query Error Response of the Evidence Broker - Birth.xml](https://code.europa.eu/oots/tdd/tdd_chapters/-/blob/master/OOTS-EDM/xml/EB/Complete%20XML%20examples%20%28EB%29/4.4.%20Query%20Error%20Response%20of%20the%20Evidence%20Broker%20-%20Birth.xml)

