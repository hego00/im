# Schematron validation

## 1. Introduction 

Within [OOTS-EDM](https://ec.europa.eu/digital-building-blocks/wikis/pages/viewpage.action?pageId=489653731) some examples for the evidence exchange using the OOTS Exchange Data Model are provided. The samples can be used for sending and receiving evidences using the mechanisms defined in the design documents of the [Once-Only Technical System (OOTS)](https://ec.europa.eu/cefdigital/wiki/display/CEFDIGITAL/Once+Only+Principle) developed for the EU's [Single Digital Gateway regulation](https://ec.europa.eu/growth/single-market/single-digital-gateway_en). 
 The XML samples(Request-Response, DSD, EB and LCM) can be found in the [OOTS-EDM/XML folder of the tdd_chapters git repository](https://code.europa.eu/oots/tdd/tdd_chapters/-/tree/e49131e193760a7527ade3f207b1f3a037ac0c56/OOTS-EDM/xml).


## 2. Business Rules
A set of [Business Rules](https://code.europa.eu/oots/tdd/tdd_chapters/-/tree/master/OOTS-EDM/xlsx) is defined which must be applied in each transaction (Evidence Request-Reponse, EB, DSD, LCM). For each business rule, a corresponding schematron rule is defined that references the same rule ID. The business rules are sets of rules that guarantee the correct structure of the transactions and they clarify the content of instances by stating mandatory fields, fixed values (like code lists), the dependency between fields in the same object and dependency between different objects. The business rules are grouped into two main sections depending on their scope:


					
## 3. Schematron files
Schematron is used for validating the Business Rules. Schematron validation files are available here: [Schematron Files](https://code.europa.eu/oots/tdd/tdd_chapters/-/tree/master/OOTS-EDM/sch). There are two types of Business Rules:
   * Structure: Business rules that guarantee the correct structure of the message:
Check information constraints related to the use of different components such as namespaces, root elements, slots, data types including "multidimensional" checks crossing the barrier between the different XSD schemes (XSD-Binding and XSD-Restriction).
   * Content: Business rules that ensure the correct content format of information objects:
Check cardinalities, identifiers, formats, fixed values, mandatory set of values on specific fields (code lists) and dependencies between fields;

A specific XML sample, for example [Evidence Request Natural Person](https://code.europa.eu/oots/tdd/tdd_chapters/-/blob/master/OOTS-EDM/xml/Request-Response%20Samples/4.5.4%20-%20OOTS-EDM%20XML%20Examples%20of%20the%20Evidence%20Exchange/3.6.1%20Example%20for%20requesting%20a%20birth%20certificate/Natural%20Person/3.6.1.1%20EvReq%20Natural%20Person%20Step%201.xml):
* Should be validated for structure using the structure schematron file [EDM-REQ-S.sch](https://code.europa.eu/oots/tdd/tdd_chapters/-/blob/master/OOTS-EDM/sch/EB-REQ-S.sch) and 
* Should be validated for content using the content schematron file [EDM-REQ-C.sch](https://code.europa.eu/oots/tdd/tdd_chapters/-/blob/master/OOTS-EDM/sch/EDM-REQ-C.sch)

The following table describes the component and the schematron files used for validation.

| ID| Name|Description|Component|SCH Structure validation file|SCH Content Validation File    		
|---------------|----------------------------|-----------------------------|-------------------|-----------------|------------|
|EDM-REQ  | Evidence Request  | Evidence Request Syntax Mapping |EDM|EDM-REQ-S.sch|EDM-REQ-C.sch|
|EDM-RESP |  Evidence Response | Evidence Response Syntax Mapping  |EDM|EDM-ERR-S.sch|EDM-ERR-C.sch|
|EDM-ERR  | EDM Error Response  | Error Response Syntax Mapping  |EDM|EDM-ERR-S.sch|EDM-ERR-C.sch|
|DSD-RESP|DSD Query Response|Query Response of the DSD|DSD|DSD-RESP-S.sch|DSD-RESP-C.sch|
|DSD-ERR|DSD Error Response|Query Error Response of the DSD|DSD|DSD-ERR-S.sch|DSD-ERR-C.sch|
|DSD-SUB|LCM Submit Objects to DSD|Submit Registry Objects DataServiceEvidenceType and EvidenceProvider|DSD (LCM)|DSD-SUB-S.sch|DSD-SUB-C.sch|
|EB-REQ|EB get Requirements Query Response|Get List of Requirements Query|EB|EB-REQ-S.sch|EB-REQ-C.sch|
|EB-EVI|EB get Evidence Types Query Response|Get Evidence Types for Requirement Query|EB|EB-EVI-S.sch|EB-EVI-C.sch|
|EB-ERR|EB Error Response|Query Error Response of the EB|EB|EB-ERR.sch| |
|EB-SUB|LCM Submit Objects to EB|Submit Registry Objects EvidenceType, EvidenceTypeList, Requirement and ReferenceFramework|EB (LCM)|EB-SUB-S.sch|EB-SUB-C.sch|
|LCM-SUC|LCM Successfull Response|Response for successful LCM submission|LCM (EB/DSD)|LCM-SUC.sch|	|
|LCM-ERR|LCM Error Response|Response for unsuccessful LCM submission|LCM (EB/DSD)|LCM-ERR.sch|	|
|C|	Content|	Business rules that ensure the correct use of information objects|	|	|	|
|S|	Structure|	Business rules that guarantee the correct structure of the message|	|	|	|
|na|	Content and Structure|	A single set of rules is provided for LCM-SUC, LCM-ERR and EB-ERR| |  | |
