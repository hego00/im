<?xml version="1.0" encoding="utf-8"?>
<sch:schema xmlns:sch="http://purl.oclc.org/dsdl/schematron" queryBinding="xslt2">   
   <sch:ns uri="http://data.europa.eu/p4s" prefix="sdg"/>
   <sch:ns uri="urn:oasis:names:tc:ebxml-regrep:xsd:rs:4.0" prefix="rs"/>
   <sch:ns uri="urn:oasis:names:tc:ebxml-regrep:xsd:rim:4.0" prefix="rim"/>
   <sch:ns uri="urn:oasis:names:tc:ebxml-regrep:xsd:query:4.0" prefix="query"/>
   <sch:ns uri="http://www.w3.org/2001/XMLSchema-instance" prefix="xsi"/>
   <sch:ns uri="http://www.w3.org/1999/xlink" prefix="xlink"/>
   <sch:ns prefix="x" uri="https://www.w3.org/TR/REC-html40"/>
   
   
   <sch:pattern>
      <sch:rule context="query:QueryRequest/rim:Slot[@name='SpecificationIdentifier']/rim:SlotValue">
         <sch:assert test="rim:Value='oots-edm:v1.0'" id="R-EDM-REQ-C001"
            >The 'rim:Value' of the 'SpecificationIdentifier' MUST be the fixed value "oots-edm:v1.0".</sch:assert>         
      </sch:rule>
   </sch:pattern>
    
   <sch:pattern>
      <sch:rule context="query:QueryRequest/rim:Slot[@name='IssueDateTime']/rim:SlotValue/rim:Value">
         <sch:assert test="matches(normalize-space(text()),'[0-9]{4}-[0-9]{2}-[0-9]{2}T[0-9]{2}:[0-9]{2}:[0-9]{2}','i')" id="R-EDM-REQ-C002">
            The 'rim:Value' of 'IssueDateTime' MUST be according to xsd:dateTime.</sch:assert>
      </sch:rule>
   </sch:pattern>
   
 
   <sch:pattern>
      <sch:rule context="query:QueryRequest/rim:Slot[@name='PreviewLocation']/rim:SlotValue">
         <sch:assert test="matches(rim:Value, '^https://')" id="R-EDM-REQ-C005"
            > The 'rim:Value' of a 'PreviewLocation' MUST be a URI starting with 'https://'.</sch:assert>         
      </sch:rule>
   </sch:pattern>

   <sch:pattern>
      <sch:rule context="query:QueryRequest/rim:Slot[@name='Requirement']/rim:SlotValue/rim:Element/sdg:Requirement/sdg:Identifier">
         <sch:assert test="matches(normalize-space(text()),'^https://sr.oots.tech.europa.eu/requirements/urn:uuid:[a-f0-9]{8}-[a-f0-9]{4}-[a-f0-9]{4}-[a-f0-9]{4}-[a-f0-9]{12}$')" id="R-EDM-REQ-C008"
            >The value of 'Identifier' of a 'Requirement' MUST be a unique UUID (RFC 4122) listed in the EvidenceBroker and use the prefix ''https://sr.oots.tech.europa.eu/requirements/[UUID]'' pointing to the Semantic Repository.</sch:assert>         
      </sch:rule>
   </sch:pattern>
   
   <sch:pattern>
      <sch:rule context="query:QueryRequest/rim:Slot[@name='EvidenceRequester']/rim:SlotValue/rim:Element/sdg:Agent/sdg:Identifier">
         <sch:assert test="@schemeID" id="R-EDM-REQ-C010"
            >The 'schemeID' attribute of 'Identifier' MUST be present.</sch:assert>         
      </sch:rule>
   </sch:pattern>
   
   <sch:pattern>
      <sch:rule context="query:QueryRequest/rim:Slot[@name='EvidenceRequester']/rim:SlotValue/rim:Element/sdg:Agent">
         <sch:assert test="not(normalize-space(sdg:Classification)='')" id="R-EDM-REQ-C013"
            >The value for 'Agent/Classification' MUST be provided. </sch:assert>         
      </sch:rule>
   </sch:pattern>
   
   <sch:pattern>
      <sch:rule context="query:QueryRequest/rim:Slot[@name='EvidenceProvider']/rim:SlotValue/sdg:Agent/sdg:Identifier">
         <sch:assert test="@schemeID" id="R-EDM-REQ-C017"
            >The 'schemeID' attribute of 'Identifier' MUST be present.</sch:assert>         
      </sch:rule>
   </sch:pattern>

   <sch:pattern>         
      <sch:rule context="query:QueryRequest/rim:Slot[@name='EvidenceProviderClassification']/rim:SlotValue/rim:Element/sdg:EvidenceProviderClassification/sdg:Identifier">
         <sch:assert test="matches(normalize-space((.)),'[a-f0-9]{8}-[a-f0-9]{4}-[a-f0-9]{4}-[a-f0-9]{4}-[a-f0-9]{12}$','i')" id="R-EDM-REQ-C019"
            >The value of 'Identifier' of MUST be unique UUID (RFC 4122).</sch:assert>         
      </sch:rule>
   </sch:pattern>
   
   <sch:pattern>
      <sch:rule context="query:QueryRequest/rim:Slot[@name='EvidenceProviderClassification']/rim:SlotValue/rim:Element/sdg:EvidenceProviderClassification">
         <sch:assert test="not(normalize-space(sdg:Type)='')" id="R-EDM-REQ-C020"
            >The value for 'Type' MUST be provided.</sch:assert>         
      </sch:rule>
   </sch:pattern>
   
   <sch:pattern>
      <sch:rule context="query:QueryRequest/rim:Slot[@name='EvidenceProviderClassification']/rim:SlotValue/rim:Element/sdg:EvidenceProviderClassification/sdg:Description">
         <sch:assert test="not(normalize-space(@lang)='')" id="R-EDM-REQ-C022"
            >The value of 'lang' attribute MUST be be provided. Default value: 'EN'.</sch:assert>         
      </sch:rule>
   </sch:pattern>
   
   <sch:pattern>
      <sch:rule context="query:QueryRequest/rim:Slot[@name='EvidenceProviderClassification']/rim:SlotValue/rim:Element/sdg:EvidenceProviderClassification">
         <sch:assert test="not(normalize-space(sdg:SupportedValue)='')" id="R-EDM-REQ-C023"
            >A value for 'SupportedValue' MUST be provided. </sch:assert>         
      </sch:rule>
   </sch:pattern>

   <sch:pattern>
      <sch:rule context="query:QueryRequest/query:ResponseOption">
         <sch:assert test="@returnType='LeafClassWithRepositoryItem'" id="R-EDM-REQ-C024"
            >The 'returnType' attribute of 'ResponseOption' MUST be the fixed value "LeafClassWithRepositoryItem".</sch:assert>         
      </sch:rule>
   </sch:pattern>
   
   <sch:pattern>
      <sch:rule context="query:QueryRequest/query:Query">
         <sch:assert test="@queryDefinition='DocumentQuery'" id="R-EDM-REQ-C025"
            >The 'queryDefinition' attribute of 'Query' MUST be the fixed value "DocumentQuery".</sch:assert>         
      </sch:rule>
   </sch:pattern>
   
   <sch:pattern>
      <sch:rule context="query:QueryRequest/query:Query/rim:Slot[@name='EvidenceRequest']/rim:SlotValue/sdg:DataServiceEvidenceType/sdg:Identifier">
         <sch:assert test="matches(normalize-space((.)),'[a-f0-9]{8}-[a-f0-9]{4}-[a-f0-9]{4}-[a-f0-9]{4}-[a-f0-9]{12}$','i')" id="R-EDM-REQ-C026"
            > The value of 'Identifier' of an 'DataServiceEvidenceType' MUST be unique UUID (RFC 4122) retrieved from the Data Service Directory.</sch:assert>         
      </sch:rule>
   </sch:pattern>

   <sch:pattern>
      <sch:rule context="query:QueryRequest/query:Query/rim:Slot[@name='EvidenceRequest']/rim:SlotValue/sdg:DataServiceEvidenceType/sdg:EvidenceTypeClassification">
         <sch:assert test="matches(normalize-space((.)),'https://sr.oots.tech.europa.eu/evidencetypeclassifications/[a-z]{2}/[a-f0-9]{8}-[a-f0-9]{4}-[a-f0-9]{4}-[a-f0-9]{4}-[a-f0-9]{12}$','i')" id="R-EDM-REQ-C027"
            > The value of 'EvidenceTypeClassification' of a 'DataServiceEvidenceType' MUST be a UUID retrieved from the Evidence Broker and include a code of the code list 'CountryIdentificationCode' (ISO 3166-1' alpha-2 codes) using the prefix and scheme ''https://sr.oots.tech.europa.eu/evidencetypeclassifications/[CountryIdentificationCode]/[UUID]'' pointing to the Semantic Repository. </sch:assert>         
      </sch:rule>
   </sch:pattern>
   
   <sch:pattern>
      <sch:rule context="query:QueryRequest/query:Query/rim:Slot[@name='EvidenceRequest']/rim:SlotValue/sdg:DataServiceEvidenceType/sdg:Title">
         <sch:assert test="not(normalize-space(@lang)='')" id="R-EDM-REQ-C029"
            > The value of 'lang' attribute MUST be be provided. Default value: 'EN'.</sch:assert>         
      </sch:rule>
   </sch:pattern>
   
   <sch:pattern>
      <sch:rule context="query:QueryRequest/query:Query/rim:Slot[@name='EvidenceRequest']/rim:SlotValue/sdg:DataServiceEvidenceType/sdg:Description">
         <sch:assert test="not(normalize-space(@lang)='')" id="R-EDM-REQ-C031"
            > The value of 'lang' attribute MUST be be provided. Default value: 'EN'.</sch:assert>         
      </sch:rule>
   </sch:pattern>
   
   <sch:pattern>
      <sch:rule context="query:QueryRequest/query:Query/rim:Slot[@name='EvidenceRequest']/rim:SlotValue/sdg:DataServiceEvidenceType">
         <sch:assert test="count(sdg:DistributedAs)=1 or count(sdg:DistributedAs)=0" id="R-EDM-REQ-C032"
            >The Element 'DistributedAs' must occur not more than once (maxOccurs="1)' in the EvidenceRequest. </sch:assert>         
      </sch:rule>
   </sch:pattern>
   
   <sch:pattern>
      <sch:rule context="query:QueryRequest/query:Query/rim:Slot[@name='EvidenceRequest']/rim:SlotValue/sdg:DataServiceEvidenceType/sdg:DistributedAs/sdg:ConformsTo">
         <sch:assert test="matches(normalize-space(text()),'^https://sr.oots.tech.europa.eu/distributions/')" id="R-EDM-REQ-C034"
            >The value of 'ConformsTo' of the requested distribution MUST be a persistent URL with a link to a "DataModelScheme" of the Evidence Type retrieved by 
            the DSD and described in the Semantic Repository which uses the prefix "https://sr.oots.tech.europa.eu/distributions/[DataModelScheme]". </sch:assert>         
      </sch:rule>
   </sch:pattern>
   
   <sch:pattern>
      <sch:rule context="query:QueryRequest/query:Query/rim:Slot[@name='EvidenceRequest']/rim:SlotValue/sdg:DataServiceEvidenceType/sdg:DistributedAs/sdg:Transformation">
         <sch:assert test="matches(normalize-space(text()),'^https://sr.oots.tech.europa.eu/distributions/')" id="R-EDM-REQ-C035"
            >The value of 'Transformation' of the requested distribution MUST be a persistent URL with link to a "DataModelScheme" and "Subset" of the 
            EvidenceType retrieved from the Data Service Directory, described in the Semantic Repository which uses the prefix 
            "https://sr.oots.tech.europa.eu/distributions/[DataModelScheme]/[Subset]".</sch:assert>         
      </sch:rule>
   </sch:pattern>
   
   <sch:pattern>         
      <sch:rule context="query:QueryRequest/query:Query/rim:Slot[@name='NaturalPerson']/rim:SlotValue/sdg:Person">
         <sch:assert test="not(normalize-space(sdg:LevelOfAssurance)='')" id="R-EDM-REQ-C036"
            >The Element 'LevelOfAssurance' must be provided  (minOccurs="1)' in the EvidenceRequest when rim:Slot[@name='NaturalPerson'] is used. </sch:assert>         
      </sch:rule>
   </sch:pattern>
   
   <sch:pattern>
      <sch:rule context="query:QueryRequest/query:Query/rim:Slot[@name='NaturalPerson']/rim:SlotValue/sdg:Person">
         <sch:assert test="not(normalize-space(sdg:Identifier)='')" id="R-EDM-REQ-C038" role="warning"
            >The value of a Person 'Identifier' SHOULD be provided.</sch:assert>         
      </sch:rule>
   </sch:pattern>
   
   <sch:pattern>
      <sch:rule context="query:QueryRequest/query:Query/rim:Slot[@name='NaturalPerson']/rim:SlotValue/sdg:Person/sdg:Identifier">
         <sch:assert test="matches(normalize-space(text()),'[a-z]{2}/[a-z]{2}/[a-z0-9]{9}','i')" id="R-EDM-REQ-C039"
            >The value of a Person 'Identifier' MUST have the format XX/YY/ZZZZZZZ where XX is the Nationality Code of the identifier and YY is the Nationality Code 
            of the destination country and ZZZZZZZ is an undefined combination of characters which uniquely identifies the identity asserted in the country of origin. 
            Example: ES/AT/02635542Y </sch:assert>         
      </sch:rule>
   </sch:pattern>
   
   <sch:pattern>
      <sch:rule context="query:QueryRequest/query:Query/rim:Slot[@name='NaturalPerson']/rim:SlotValue/sdg:Person/sdg:Identifier">
         <sch:assert test="@schemeID" id="R-EDM-REQ-C041"
            >The 'schemeID' attribute of 'Identifier' MUST be present.</sch:assert>         
      </sch:rule>
   </sch:pattern>
   
   <sch:pattern>
      <sch:rule context="query:QueryRequest/query:Query/rim:Slot[@name='NaturalPerson']/rim:SlotValue/sdg:Person/sdg:Identifier">
         <sch:assert test="@schemeID='eidas'" id="R-EDM-REQ-C042"
            >The 'schemeID' attribute of the 'Identifier' MUST have the fixed value 'eidas'.</sch:assert>         
      </sch:rule>
   </sch:pattern>

   <sch:pattern>
      <sch:rule context="query:QueryRequest/query:Query/rim:Slot[@name='NaturalPerson']/rim:SlotValue/sdg:Person/sdg:DateOfBirth">
         <sch:assert test="matches(normalize-space(text()),'[0-9]{4}-[0-9]{2}-[0-9]{2}','i')" id="R-EDM-REQ-C043">
            The value of 'DateOfBirth' MUST use the following format YYYY + “-“ + MM + “-“ + DD (as defined for xsd:date) </sch:assert>
      </sch:rule>
   </sch:pattern>
   
   <sch:pattern>         
      <sch:rule context="query:QueryRequest/query:Query/rim:Slot[@name='LegalPerson']/rim:SlotValue/sdg:LegalPerson">
         <sch:assert test="not(normalize-space(sdg:LevelOfAssurance)='')" id="R-EDM-REQ-C047"
            >The Element 'LevelOfAssurance' must be provided  (minOccurs="1)' in the EvidenceRequest when rim:Slot[@name='LegalPerson'] is used. </sch:assert>         
      </sch:rule>
   </sch:pattern>
                
   <sch:pattern>        
      <sch:rule context="query:QueryRequest/query:Query/rim:Slot[@name='LegalPerson']/rim:SlotValue/sdg:LegalPerson">
         <sch:assert test="not(normalize-space(sdg:LegalPersonIdentifier)='')" id="R-EDM-REQ-C049"
            >The value of a Legal Person 'LegalPersonIdentifier' SHOULD be provided. </sch:assert>         
      </sch:rule>
   </sch:pattern>
  
                  
   <sch:pattern>
      <sch:rule context="query:QueryRequest/query:Query/rim:Slot[@name='LegalPerson']/rim:SlotValue/sdg:LegalPerson/sdg:LegalPersonIdentifier">
         <sch:assert test="matches(normalize-space(text()),'[a-z]{2}/[a-z]{2}/[a-z0-9]{9}','i')" id="R-EDM-REQ-C050"
            >The value of a 'LegalPersonIdentifier' MUST have the format XX/YY/ZZZZZZZZZ where XX is the Nationality Code of the identifier and YY is the Nationality Code 
            of the destination country and ZZZZZZZZZ is an undefined combination of characters which uniquely identifies the identity asserted in the country of origin. 
            Example: ES/AT/02635542Y  </sch:assert>         
      </sch:rule>
   </sch:pattern>
   
   <sch:pattern>
      <sch:rule context="query:QueryRequest/query:Query/rim:Slot[@name='LegalPerson']/rim:SlotValue/sdg:LegalPerson/sdg:LegalPersonIdentifier">
         <sch:assert test="@schemeID" id="R-EDM-REQ-C052"
            >The 'schemeID' attribute of 'LegalPersonIdentifier' MUST be present.</sch:assert>         
      </sch:rule>
   </sch:pattern>
   
   <sch:pattern>
      <sch:rule context="query:QueryRequest/query:Query/rim:Slot[@name='LegalPerson']/rim:SlotValue/sdg:LegalPerson/sdg:LegalPersonIdentifier">
         <sch:assert test="@schemeID='eidas'" id="R-EDM-REQ-C053"
            >The 'schemeID' attribute of the 'LegalPersonIdentifier' MUST have the fixed value 'eidas'.</sch:assert>         
      </sch:rule>
   </sch:pattern>
   
   <sch:pattern>
      <sch:rule context="query:QueryRequest/query:Query/rim:Slot[@name='LegalPerson']/rim:SlotValue/sdg:LegalPerson/sdg:Identifier">
         <sch:assert test="@schemeID" id="R-EDM-REQ-C054"
            >The 'schemeID' attribute of 'Identifier' MUST be present.</sch:assert>         
      </sch:rule>
   </sch:pattern>
   
   <sch:pattern>
      <sch:rule context="query:QueryRequest/query:Query/rim:Slot[@name='AuthorizedRepresentative']/rim:SlotValue/sdg:Person">
         <sch:assert test="not(normalize-space(sdg:LevelOfAssurance)='')" id="R-EDM-REQ-C058"
            >The Element 'LevelOfAssurance' must be provided (minOccurs="1)' in the EvidenceRequest when rim:Slot[@name='AuthorizedRepresentative'] is used.</sch:assert>         
      </sch:rule>
   </sch:pattern>
   
   <sch:pattern>        
      <sch:rule context="query:QueryRequest/query:Query/rim:Slot[@name='AuthorizedRepresentative']/rim:SlotValue/sdg:Person">
         <sch:assert test="sdg:Identifier" id="R-EDM-REQ-C060"
            >The value of a Person 'Identifier' SHOULD be provided. </sch:assert>         
      </sch:rule>
   </sch:pattern>
   
   <sch:pattern>
      <sch:rule context="query:QueryRequest/query:Query/rim:Slot[@name='AuthorizedRepresentative']/rim:SlotValue/sdg:Person/sdg:Identifier">
         <sch:assert test="matches(normalize-space(text()),'[a-z]{2}/[a-z]{2}/[a-z0-9]{9}','i')" id="R-EDM-REQ-C061"
            >   The value of a Person 'Identifier' MUST have the format XX/YY/ZZZZZZZ where XX is the Nationality Code of the identifier and YY is the 
            Nationality Code of the destination country and ZZZZZZZ is an undefined combination of characters which uniquely identifies the 
            identity asserted in the country of origin. Example: ES/AT/02635542Y  </sch:assert>         
      </sch:rule>
   </sch:pattern>
   
   <sch:pattern>
      <sch:rule context="query:QueryRequest/query:Query/rim:Slot[@name='AuthorizedRepresentative']/rim:SlotValue/sdg:Person/sdg:Identifier">
         <sch:assert test="@schemeID" id="R-EDM-REQ-C062"
            >The 'schemeID' attribute of 'Identifier' MUST be present.</sch:assert>         
      </sch:rule>
   </sch:pattern>
   
   <sch:pattern>
      <sch:rule context="query:QueryRequest/query:Query/rim:Slot[@name='AuthorizedRepresentative']/rim:SlotValue/sdg:Person/sdg:Identifier">
         <sch:assert test="@schemeID='eidas'" id="R-EDM-REQ-C063"
            >The 'schemeID' attribute of the 'Identifier' MUST have the fixed value 'eidas'.</sch:assert>         
      </sch:rule>
   </sch:pattern>
   
   <sch:pattern>
      <sch:rule context="query:QueryRequest/query:Query/rim:Slot[@name='AuthorizedRepresentative']/rim:SlotValue/sdg:Person/sdg:DateOfBirth">
         <sch:assert test="matches(normalize-space(text()),'[0-9]{4}-[0-9]{2}-[0-9]{2}','i')" id="R-EDM-REQ-C064">
            The value of 'DateOfBirth' MUST use the following format YYYY + “-“ + MM + “-“ + DD (as defined for xsd:date)  </sch:assert>
      </sch:rule>
   </sch:pattern>
   
   <sch:pattern>         
      <sch:rule context="query:QueryRequest/rim:Slot[@name='EvidenceRequester']/rim:SlotValue/rim:Element/sdg:Agent/sdg:Classification">
         <!--{}[](AgentClassification-CodeList)-->
         <sch:assert test="( false() or ( contains('ERIPEPERRP',concat('',.,'')) ) ) " id="R-EDM-REQ-C014">Value supplied '<value-of xmlns="http://purl.oclc.org/dsdl/schematron" select="."/>' is unacceptable for constraints identified by 'AgentClassification-CodeList' in the context 'query:QueryRequest/rim:Slot[@name='EvidenceRequester']/rim:SlotValue/rim:Element/sdg:Agent/sdg:Classification'</sch:assert>
      </sch:rule>              
      <sch:rule context="query:QueryRequest/query:Query/rim:Slot[@name='NaturalPerson']/rim:SlotValue/sdg:Person/sdg:LevelOfAssurance">
         <!--{}[](LevelsOfAssurance-CodeList)-->
         <sch:assert test="( false() or ( contains('LowSubstantialHigh',concat('',.,'')) ) ) " id="R-EDM-REQ-C037">Value supplied '<value-of xmlns="http://purl.oclc.org/dsdl/schematron" select="."/>' is unacceptable for constraints identified by 'LevelsOfAssurance-CodeList' in the context 'query:QueryRequest/query:Query/rim:Slot[@name='NaturalPerson']/rim:SlotValue/sdg:Person/sdg:LevelOfAssurance'</sch:assert>
      </sch:rule>
      <sch:rule context="query:QueryRequest/query:Query/rim:Slot[@name='LegalPerson']/rim:SlotValue/sdg:LegalPerson/sdg:LevelOfAssurance">
         <!--{}[](LevelsOfAssurance-CodeList)-->
         <sch:assert test="( false() or ( contains('LowSubstantialHigh',concat('',.,'')) ) ) " id="R-EDM-REQ-C048">Value supplied '<value-of xmlns="http://purl.oclc.org/dsdl/schematron" select="."/>' is unacceptable for constraints identified by 'LevelsOfAssurance-CodeList' in the context 'query:QueryRequest/query:Query/rim:Slot[@name='LegalPerson']/rim:SlotValue/sdg:LegalPerson/sdg:LevelOfAssurance'</sch:assert>
      </sch:rule>
      <sch:rule context="query:QueryRequest/query:Query/rim:Slot[@name='AuthorizedRepresentative']/rim:SlotValue/sdg:Person/sdg:LevelOfAssurance">
         <!--{}[](LevelsOfAssurance-CodeList)-->
         <sch:assert test="( false() or ( contains('LowSubstantialHigh',concat('',.,'')) ) ) " id="R-EDM-REQ-C059">Value supplied '<value-of xmlns="http://purl.oclc.org/dsdl/schematron" select="."/>' is unacceptable for constraints identified by 'LevelsOfAssurance-CodeList' in the context 'query:QueryRequest/query:Query/rim:Slot[@name='AuthorizedRepresentative']/rim:SlotValue/sdg:Person/sdg:LevelOfAssurance'</sch:assert>
      </sch:rule>
      <sch:rule context="query:QueryRequest/rim:Slot[@name='Procedure']/rim:SlotValue/rim:Value/rim:LocalizedString/@value">
         <!--{}[](Procedures-CodeList)-->
         <sch:assert test="( false() or ( contains('R1S1T1T2T3U1U2U3U4V1V2V3V4W1W2X1X2X3X4X5X6',concat('',.,'')) ) ) " id="R-EDM-REQ-C003">Value supplied '<value-of xmlns="http://purl.oclc.org/dsdl/schematron" select="."/>' is unacceptable for constraints identified by 'Procedures-CodeList' in the context 'query:QueryRequest/rim:Slot[@name='Procedure']/rim:SlotValue/rim:Value/rim:LocalizedString/@value'</sch:assert>
      </sch:rule>
      <sch:rule context="query:QueryRequest/query:Query/rim:Slot[@name='EvidenceRequest']/rim:SlotValue/sdg:DataServiceEvidenceType/sdg:DistributedAs/sdg:Format">
         <!--{}[](OOTSMediaTypes-CodeList)-->
         <sch:assert test="( false() or ( contains('image/jpegimage/jpegapplication/jsonimage/pngapplication/pdfapplication/xml&#x9;image/svg+xml',concat('',.,'')) ) ) " id="R-EDM-REQ-C033">Value supplied '<value-of xmlns="http://purl.oclc.org/dsdl/schematron" select="."/>' is unacceptable for constraints identified by 'OOTSMediaTypes-CodeList' in the context 'query:QueryRequest/query:Query/rim:Slot[@name='EvidenceRequest']/rim:SlotValue/sdg:DataServiceEvidenceType/sdg:DistributedAs/sdg:Format'</sch:assert>
      </sch:rule>
      <sch:rule context="query:QueryRequest/rim:Slot[@name='EvidenceProvider']/rim:SlotValue/sdg:Agent/sdg:Identifier">
         <!--{}[](EAS-CodeList)-->
         <sch:let name="suffix" value="substring-after(@schemeID, 'urn:cef.eu:names:identifier:EAS:')"/>
         <sch:assert test="( false() or ( contains('0002000700090037006000880096009701060130013501420147015101700183018401880190019101920193019401950196019801990200020102020203020402050208020902100211021202130215021699019906990799109913991499159918991999209922992399249925992699279928992999309931993299339934993599369937993899399940994199429943994499459946994799489949995099519952995399559957ANAQASAUEM',concat('',$suffix,'')) ) or starts-with(@schemeID, 'urn:oasis:names:tc:ebcore:partyid-type:unregistered')) " id="R-EDM-REQ-C018">The value of the 'schemeID' attribute of the 'Identifier' MUST  be part of the code list 'EAS' (Electronic Address Scheme ) and use the prefix 'urn:cef.eu:names:identifier:EAS:[Code]' or  start with the following value 'urn:oasis:names:tc:ebcore:partyid-type:unregistered'</sch:assert>
      </sch:rule>
      <sch:rule context="query:QueryRequest/rim:Slot[@name='EvidenceRequester']/rim:SlotValue/rim:Element/sdg:Agent/sdg:Identifier">
         <!--{}[](EAS-CodeList)-->
         <sch:let name="suffix" value="substring-after(@schemeID, 'urn:cef.eu:names:identifier:EAS:')"/>
         <sch:assert test="( false() or ( contains('0002000700090037006000880096009701060130013501420147015101700183018401880190019101920193019401950196019801990200020102020203020402050208020902100211021202130215021699019906990799109913991499159918991999209922992399249925992699279928992999309931993299339934993599369937993899399940994199429943994499459946994799489949995099519952995399559957ANAQASAUEM',concat('',$suffix,'')) ) or starts-with(@schemeID, 'urn:oasis:names:tc:ebcore:partyid-type:unregistered') ) " id="R-EDM-REQ-C012">The value of the 'schemeID' attribute of the 'Identifier' MUST  be part of the code list 'EAS' (Electronic Address Scheme ) and use the prefix 'urn:cef.eu:names:identifier:EAS:[Code]' or  start with the following value 'urn:oasis:names:tc:ebcore:partyid-type:unregistered'</sch:assert>
      </sch:rule>
      <sch:rule context="query:QueryRequest/rim:Slot[@name='Requirement']/rim:SlotValue/rim:Element/sdg:Requirement/sdg:Name/@lang">
         <!--{}[](LanguageCode-2.3)-->
         <sch:assert test="( false() or ( contains('AAAARABABKACEACHADAADYAEAFAFAAFHAFRAINAKAKAAKKALB (B) SQI (T)ALB (B) SQI (T)ALEALGALTAMAMHANANGANPAPAARARAARCARGARM (B) HYE (T)ARM (B) HYE (T)ARNARPARTARWASASMASTATHAUSAVAVAAVEAWAAYAYMAZAZEBABADBAIBAKBALBAMBANBAQ (B) EUS (T)BAQ (B) EUS (T)BASBATBEBEJBELBEMBENBERBGBHBHOBIBIHBIKBINBISBLABMBNBNTBOBOBOSBRBRABREBSBTKBUABUGBULBUR (B) MYA (T)BUR (B) MYA (T)BYNCACADCAICARCATCAUCECEBCELCHCHACHBCHECHGCHI (B) ZHO (T)CHI (B) ZHO (T)CHKCHMCHNCHOCHPCHRCHUCHVCHYCMCCNRCOCOPCORCOSCPECPFCPPCRCRECRHCRPCSCSCSBCUCUSCVCYCYCZE (B) CES (T)CZE (B) CES (T)DADAKDANDARDAYDEDEDELDENDGRDINDIVDOIDRADSBDUADUMDUT (B) NLD (T)DUT (B) NLD (T)DVDYUDZDZOEEEFIEGYEKAELELELXENENGENMEOEPOESESTETEUEUEWEEWOFAFAFANFAOFATFFFIFIJFILFINFIUFJFOFONFRFRFRE (B) FRA (T)FRE (B) FRA (T)FRMFROFRRFRSFRYFULFURFYGAGAAGAYGBAGDGEMGEO (B) KAT (T)GEO (B) KAT (T)GER (B) DEU (T)GER (B) DEU (T)GEZGILGLGLAGLEGLGGLVGMHGNGOHGONGORGOTGRBGRCGRE (B) ELL (T)GRE (B) ELL (T)GRNGSWGUGUJGVGWIHAHAIHATHAUHAWHEHEBHERHIHILHIMHINHITHMNHMOHOHRHRVHSBHTHUHUNHUPHYHYHZIAIBAIBOICE (B) ISL (T)ICE (B) ISL (T)IDIDOIEIGIIIIIIJOIKIKUILEILOINAINCINDINEINHIOIPKIRAIROISISITITAIUJAJAVJBOJPNJPRJRBJVKAKAKAAKABKACKALKAMKANKARKASKAUKAWKAZKBDKGKHAKHIKHMKHOKIKIKKINKIRKJKKKLKMKMBKNKOKOKKOMKONKORKOSKPEKRKRCKRLKROKRUKSKUKUAKUMKURKUTKVKWKYLALADLAHLAMLAOLATLAVLBLEZLGLILIMLINLITLNLOLOLLOZLTLTZLULUALUBLUGLUILUNLUOLUSLVMAC (B) MKD (T)MAC (B) MKD (T)MADMAGMAHMAIMAKMALMANMAO (B) MRI (T)MAO (B) MRI (T)MAPMARMASMAY (B) MSA (T)MAY (B) MSA (T)MDFMDRMENMGMGAMHMIMIMICMINMISMKMKMKHMLMLGMLTMNMNCMNIMNOMOHMONMOSMRMSMSMTMULMUNMUSMWLMWRMYMYMYNMYVNANAHNAINAPNAUNAVNBNBLNDNDENDONDSNENEPNEWNGNIANICNIUNLNLNNNNONONOBNOGNONNORNQONRNSONUBNVNWCNYNYANYMNYNNYONZIOCOCIOJOJIOMORORIORMOSOSAOSSOTAOTOPAPAAPAGPALPAMPANPAPPAUPEOPER (B) FAS (T)PER (B) FAS (T)PHIPHNPIPLPLIPOLPONPORPRAPROPSPTPUSQAA-QTZQUQUERAJRAPRARRMRNROROROAROHROMRURUM (B) RON (T)RUM (B) RON (T)RUNRUPRUSRWSASADSAGSAHSAISALSAMSANSASSATSCSCNSCOSDSESELSEMSGSGASGNSHNSISIDSINSIOSITSKSKSLSLASLO (B) SLK (T)SLO (B) SLK (T)SLVSMSMASMESMISMJSMNSMOSMSSNSNASNDSNKSOSOGSOMSONSOTSPASQSQSRSRDSRNSRPSRRSSSSASSWSTSUSUKSUNSUSSUXSVSWSWASWESYCSYRTATAHTAITAMTATTETELTEMTERTETTGTGKTGLTHTHATITIB (B) BOD (T)TIB (B) BOD (T)TIGTIRTIVTKTKLTLTLHTLITMHTNTOTOGTONTPITRTSTSITSNTSOTTTUKTUMTUPTURTUTTVLTWTWITYTYVUDMUGUGAUIGUKUKRUMBUNDURURDUZUZBVAIVEVENVIVIEVOVOLVOTWAWAKWALWARWASWEL (B) CYM (T)WEL (B) CYM (T)WENWLNWOWOLXALXHXHOYAOYAPYIYIDYOYORYPKZAZAPZBLZENZGHZHZHZHAZNDZUZULZUNZXXZZA',concat('',.,'')) ) ) " id="R-EDM-REQ-C009">Value supplied '<value-of xmlns="http://purl.oclc.org/dsdl/schematron" select="."/>' is unacceptable for constraints identified by 'LanguageCode-2.3' in the context 'query:QueryRequest/rim:Slot[@name='Requirement']/rim:SlotValue/rim:Element/sdg:Requirement/sdg:Name/@lang'</sch:assert>
      </sch:rule>
      <sch:rule context="query:QueryRequest/rim:Slot[@name='EvidenceProviderClassification']/rim:SlotValue/rim:Element/sdg:EvidenceProviderClassification/sdg:Description/@lang">
         <!--{}[](LanguageCode-2.3)-->
         <sch:assert test="( false() or ( contains('AAAARABABKACEACHADAADYAEAFAFAAFHAFRAINAKAKAAKKALB (B) SQI (T)ALB (B) SQI (T)ALEALGALTAMAMHANANGANPAPAARARAARCARGARM (B) HYE (T)ARM (B) HYE (T)ARNARPARTARWASASMASTATHAUSAVAVAAVEAWAAYAYMAZAZEBABADBAIBAKBALBAMBANBAQ (B) EUS (T)BAQ (B) EUS (T)BASBATBEBEJBELBEMBENBERBGBHBHOBIBIHBIKBINBISBLABMBNBNTBOBOBOSBRBRABREBSBTKBUABUGBULBUR (B) MYA (T)BUR (B) MYA (T)BYNCACADCAICARCATCAUCECEBCELCHCHACHBCHECHGCHI (B) ZHO (T)CHI (B) ZHO (T)CHKCHMCHNCHOCHPCHRCHUCHVCHYCMCCNRCOCOPCORCOSCPECPFCPPCRCRECRHCRPCSCSCSBCUCUSCVCYCYCZE (B) CES (T)CZE (B) CES (T)DADAKDANDARDAYDEDEDELDENDGRDINDIVDOIDRADSBDUADUMDUT (B) NLD (T)DUT (B) NLD (T)DVDYUDZDZOEEEFIEGYEKAELELELXENENGENMEOEPOESESTETEUEUEWEEWOFAFAFANFAOFATFFFIFIJFILFINFIUFJFOFONFRFRFRE (B) FRA (T)FRE (B) FRA (T)FRMFROFRRFRSFRYFULFURFYGAGAAGAYGBAGDGEMGEO (B) KAT (T)GEO (B) KAT (T)GER (B) DEU (T)GER (B) DEU (T)GEZGILGLGLAGLEGLGGLVGMHGNGOHGONGORGOTGRBGRCGRE (B) ELL (T)GRE (B) ELL (T)GRNGSWGUGUJGVGWIHAHAIHATHAUHAWHEHEBHERHIHILHIMHINHITHMNHMOHOHRHRVHSBHTHUHUNHUPHYHYHZIAIBAIBOICE (B) ISL (T)ICE (B) ISL (T)IDIDOIEIGIIIIIIJOIKIKUILEILOINAINCINDINEINHIOIPKIRAIROISISITITAIUJAJAVJBOJPNJPRJRBJVKAKAKAAKABKACKALKAMKANKARKASKAUKAWKAZKBDKGKHAKHIKHMKHOKIKIKKINKIRKJKKKLKMKMBKNKOKOKKOMKONKORKOSKPEKRKRCKRLKROKRUKSKUKUAKUMKURKUTKVKWKYLALADLAHLAMLAOLATLAVLBLEZLGLILIMLINLITLNLOLOLLOZLTLTZLULUALUBLUGLUILUNLUOLUSLVMAC (B) MKD (T)MAC (B) MKD (T)MADMAGMAHMAIMAKMALMANMAO (B) MRI (T)MAO (B) MRI (T)MAPMARMASMAY (B) MSA (T)MAY (B) MSA (T)MDFMDRMENMGMGAMHMIMIMICMINMISMKMKMKHMLMLGMLTMNMNCMNIMNOMOHMONMOSMRMSMSMTMULMUNMUSMWLMWRMYMYMYNMYVNANAHNAINAPNAUNAVNBNBLNDNDENDONDSNENEPNEWNGNIANICNIUNLNLNNNNONONOBNOGNONNORNQONRNSONUBNVNWCNYNYANYMNYNNYONZIOCOCIOJOJIOMORORIORMOSOSAOSSOTAOTOPAPAAPAGPALPAMPANPAPPAUPEOPER (B) FAS (T)PER (B) FAS (T)PHIPHNPIPLPLIPOLPONPORPRAPROPSPTPUSQAA-QTZQUQUERAJRAPRARRMRNROROROAROHROMRURUM (B) RON (T)RUM (B) RON (T)RUNRUPRUSRWSASADSAGSAHSAISALSAMSANSASSATSCSCNSCOSDSESELSEMSGSGASGNSHNSISIDSINSIOSITSKSKSLSLASLO (B) SLK (T)SLO (B) SLK (T)SLVSMSMASMESMISMJSMNSMOSMSSNSNASNDSNKSOSOGSOMSONSOTSPASQSQSRSRDSRNSRPSRRSSSSASSWSTSUSUKSUNSUSSUXSVSWSWASWESYCSYRTATAHTAITAMTATTETELTEMTERTETTGTGKTGLTHTHATITIB (B) BOD (T)TIB (B) BOD (T)TIGTIRTIVTKTKLTLTLHTLITMHTNTOTOGTONTPITRTSTSITSNTSOTTTUKTUMTUPTURTUTTVLTWTWITYTYVUDMUGUGAUIGUKUKRUMBUNDURURDUZUZBVAIVEVENVIVIEVOVOLVOTWAWAKWALWARWASWEL (B) CYM (T)WEL (B) CYM (T)WENWLNWOWOLXALXHXHOYAOYAPYIYIDYOYORYPKZAZAPZBLZENZGHZHZHZHAZNDZUZULZUNZXXZZA',concat('',.,'')) ) ) " id="R-EDM-REQ-C021">Value supplied '<value-of xmlns="http://purl.oclc.org/dsdl/schematron" select="."/>' is unacceptable for constraints identified by 'LanguageCode-2.3' in the context 'query:QueryRequest/rim:Slot[@name='EvidenceProviderClassification']/rim:SlotValue/rim:Element/sdg:EvidenceProviderClassification/sdg:Description/@lang'</sch:assert>
      </sch:rule>
      <sch:rule context="query:QueryRequest/query:Query/rim:Slot[@name='EvidenceRequest']/rim:SlotValue/sdg:DataServiceEvidenceType/sdg:Title/@lang">
         <!--{}[](LanguageCode-2.3)-->
         <sch:assert test="( false() or ( contains('AAAARABABKACEACHADAADYAEAFAFAAFHAFRAINAKAKAAKKALB (B) SQI (T)ALB (B) SQI (T)ALEALGALTAMAMHANANGANPAPAARARAARCARGARM (B) HYE (T)ARM (B) HYE (T)ARNARPARTARWASASMASTATHAUSAVAVAAVEAWAAYAYMAZAZEBABADBAIBAKBALBAMBANBAQ (B) EUS (T)BAQ (B) EUS (T)BASBATBEBEJBELBEMBENBERBGBHBHOBIBIHBIKBINBISBLABMBNBNTBOBOBOSBRBRABREBSBTKBUABUGBULBUR (B) MYA (T)BUR (B) MYA (T)BYNCACADCAICARCATCAUCECEBCELCHCHACHBCHECHGCHI (B) ZHO (T)CHI (B) ZHO (T)CHKCHMCHNCHOCHPCHRCHUCHVCHYCMCCNRCOCOPCORCOSCPECPFCPPCRCRECRHCRPCSCSCSBCUCUSCVCYCYCZE (B) CES (T)CZE (B) CES (T)DADAKDANDARDAYDEDEDELDENDGRDINDIVDOIDRADSBDUADUMDUT (B) NLD (T)DUT (B) NLD (T)DVDYUDZDZOEEEFIEGYEKAELELELXENENGENMEOEPOESESTETEUEUEWEEWOFAFAFANFAOFATFFFIFIJFILFINFIUFJFOFONFRFRFRE (B) FRA (T)FRE (B) FRA (T)FRMFROFRRFRSFRYFULFURFYGAGAAGAYGBAGDGEMGEO (B) KAT (T)GEO (B) KAT (T)GER (B) DEU (T)GER (B) DEU (T)GEZGILGLGLAGLEGLGGLVGMHGNGOHGONGORGOTGRBGRCGRE (B) ELL (T)GRE (B) ELL (T)GRNGSWGUGUJGVGWIHAHAIHATHAUHAWHEHEBHERHIHILHIMHINHITHMNHMOHOHRHRVHSBHTHUHUNHUPHYHYHZIAIBAIBOICE (B) ISL (T)ICE (B) ISL (T)IDIDOIEIGIIIIIIJOIKIKUILEILOINAINCINDINEINHIOIPKIRAIROISISITITAIUJAJAVJBOJPNJPRJRBJVKAKAKAAKABKACKALKAMKANKARKASKAUKAWKAZKBDKGKHAKHIKHMKHOKIKIKKINKIRKJKKKLKMKMBKNKOKOKKOMKONKORKOSKPEKRKRCKRLKROKRUKSKUKUAKUMKURKUTKVKWKYLALADLAHLAMLAOLATLAVLBLEZLGLILIMLINLITLNLOLOLLOZLTLTZLULUALUBLUGLUILUNLUOLUSLVMAC (B) MKD (T)MAC (B) MKD (T)MADMAGMAHMAIMAKMALMANMAO (B) MRI (T)MAO (B) MRI (T)MAPMARMASMAY (B) MSA (T)MAY (B) MSA (T)MDFMDRMENMGMGAMHMIMIMICMINMISMKMKMKHMLMLGMLTMNMNCMNIMNOMOHMONMOSMRMSMSMTMULMUNMUSMWLMWRMYMYMYNMYVNANAHNAINAPNAUNAVNBNBLNDNDENDONDSNENEPNEWNGNIANICNIUNLNLNNNNONONOBNOGNONNORNQONRNSONUBNVNWCNYNYANYMNYNNYONZIOCOCIOJOJIOMORORIORMOSOSAOSSOTAOTOPAPAAPAGPALPAMPANPAPPAUPEOPER (B) FAS (T)PER (B) FAS (T)PHIPHNPIPLPLIPOLPONPORPRAPROPSPTPUSQAA-QTZQUQUERAJRAPRARRMRNROROROAROHROMRURUM (B) RON (T)RUM (B) RON (T)RUNRUPRUSRWSASADSAGSAHSAISALSAMSANSASSATSCSCNSCOSDSESELSEMSGSGASGNSHNSISIDSINSIOSITSKSKSLSLASLO (B) SLK (T)SLO (B) SLK (T)SLVSMSMASMESMISMJSMNSMOSMSSNSNASNDSNKSOSOGSOMSONSOTSPASQSQSRSRDSRNSRPSRRSSSSASSWSTSUSUKSUNSUSSUXSVSWSWASWESYCSYRTATAHTAITAMTATTETELTEMTERTETTGTGKTGLTHTHATITIB (B) BOD (T)TIB (B) BOD (T)TIGTIRTIVTKTKLTLTLHTLITMHTNTOTOGTONTPITRTSTSITSNTSOTTTUKTUMTUPTURTUTTVLTWTWITYTYVUDMUGUGAUIGUKUKRUMBUNDURURDUZUZBVAIVEVENVIVIEVOVOLVOTWAWAKWALWARWASWEL (B) CYM (T)WEL (B) CYM (T)WENWLNWOWOLXALXHXHOYAOYAPYIYIDYOYORYPKZAZAPZBLZENZGHZHZHZHAZNDZUZULZUNZXXZZA',concat('',.,'')) ) ) " id="R-EDM-REQ-C028">Value supplied '<value-of xmlns="http://purl.oclc.org/dsdl/schematron" select="."/>' is unacceptable for constraints identified by 'LanguageCode-2.3' in the context 'query:QueryRequest/query:Query/rim:Slot[@name='EvidenceRequest']/rim:SlotValue/sdg:DataServiceEvidenceType/sdg:Title/@lang'</sch:assert>
      </sch:rule>
      <sch:rule context="query:QueryRequest/rim:Slot[@name='Procedure']/rim:SlotValue/rim:Value/rim:LocalizedString/@xml:lang">
         <!--{}[](LanguageCode-2.3)-->
         <sch:assert test="( false() or ( contains('AAAARABABKACEACHADAADYAEAFAFAAFHAFRAINAKAKAAKKALB (B) SQI (T)ALB (B) SQI (T)ALEALGALTAMAMHANANGANPAPAARARAARCARGARM (B) HYE (T)ARM (B) HYE (T)ARNARPARTARWASASMASTATHAUSAVAVAAVEAWAAYAYMAZAZEBABADBAIBAKBALBAMBANBAQ (B) EUS (T)BAQ (B) EUS (T)BASBATBEBEJBELBEMBENBERBGBHBHOBIBIHBIKBINBISBLABMBNBNTBOBOBOSBRBRABREBSBTKBUABUGBULBUR (B) MYA (T)BUR (B) MYA (T)BYNCACADCAICARCATCAUCECEBCELCHCHACHBCHECHGCHI (B) ZHO (T)CHI (B) ZHO (T)CHKCHMCHNCHOCHPCHRCHUCHVCHYCMCCNRCOCOPCORCOSCPECPFCPPCRCRECRHCRPCSCSCSBCUCUSCVCYCYCZE (B) CES (T)CZE (B) CES (T)DADAKDANDARDAYDEDEDELDENDGRDINDIVDOIDRADSBDUADUMDUT (B) NLD (T)DUT (B) NLD (T)DVDYUDZDZOEEEFIEGYEKAELELELXENENGENMEOEPOESESTETEUEUEWEEWOFAFAFANFAOFATFFFIFIJFILFINFIUFJFOFONFRFRFRE (B) FRA (T)FRE (B) FRA (T)FRMFROFRRFRSFRYFULFURFYGAGAAGAYGBAGDGEMGEO (B) KAT (T)GEO (B) KAT (T)GER (B) DEU (T)GER (B) DEU (T)GEZGILGLGLAGLEGLGGLVGMHGNGOHGONGORGOTGRBGRCGRE (B) ELL (T)GRE (B) ELL (T)GRNGSWGUGUJGVGWIHAHAIHATHAUHAWHEHEBHERHIHILHIMHINHITHMNHMOHOHRHRVHSBHTHUHUNHUPHYHYHZIAIBAIBOICE (B) ISL (T)ICE (B) ISL (T)IDIDOIEIGIIIIIIJOIKIKUILEILOINAINCINDINEINHIOIPKIRAIROISISITITAIUJAJAVJBOJPNJPRJRBJVKAKAKAAKABKACKALKAMKANKARKASKAUKAWKAZKBDKGKHAKHIKHMKHOKIKIKKINKIRKJKKKLKMKMBKNKOKOKKOMKONKORKOSKPEKRKRCKRLKROKRUKSKUKUAKUMKURKUTKVKWKYLALADLAHLAMLAOLATLAVLBLEZLGLILIMLINLITLNLOLOLLOZLTLTZLULUALUBLUGLUILUNLUOLUSLVMAC (B) MKD (T)MAC (B) MKD (T)MADMAGMAHMAIMAKMALMANMAO (B) MRI (T)MAO (B) MRI (T)MAPMARMASMAY (B) MSA (T)MAY (B) MSA (T)MDFMDRMENMGMGAMHMIMIMICMINMISMKMKMKHMLMLGMLTMNMNCMNIMNOMOHMONMOSMRMSMSMTMULMUNMUSMWLMWRMYMYMYNMYVNANAHNAINAPNAUNAVNBNBLNDNDENDONDSNENEPNEWNGNIANICNIUNLNLNNNNONONOBNOGNONNORNQONRNSONUBNVNWCNYNYANYMNYNNYONZIOCOCIOJOJIOMORORIORMOSOSAOSSOTAOTOPAPAAPAGPALPAMPANPAPPAUPEOPER (B) FAS (T)PER (B) FAS (T)PHIPHNPIPLPLIPOLPONPORPRAPROPSPTPUSQAA-QTZQUQUERAJRAPRARRMRNROROROAROHROMRURUM (B) RON (T)RUM (B) RON (T)RUNRUPRUSRWSASADSAGSAHSAISALSAMSANSASSATSCSCNSCOSDSESELSEMSGSGASGNSHNSISIDSINSIOSITSKSKSLSLASLO (B) SLK (T)SLO (B) SLK (T)SLVSMSMASMESMISMJSMNSMOSMSSNSNASNDSNKSOSOGSOMSONSOTSPASQSQSRSRDSRNSRPSRRSSSSASSWSTSUSUKSUNSUSSUXSVSWSWASWESYCSYRTATAHTAITAMTATTETELTEMTERTETTGTGKTGLTHTHATITIB (B) BOD (T)TIB (B) BOD (T)TIGTIRTIVTKTKLTLTLHTLITMHTNTOTOGTONTPITRTSTSITSNTSOTTTUKTUMTUPTURTUTTVLTWTWITYTYVUDMUGUGAUIGUKUKRUMBUNDURURDUZUZBVAIVEVENVIVIEVOVOLVOTWAWAKWALWARWASWEL (B) CYM (T)WEL (B) CYM (T)WENWLNWOWOLXALXHXHOYAOYAPYIYIDYOYORYPKZAZAPZBLZENZGHZHZHZHAZNDZUZULZUNZXXZZA',concat('',.,'')) ) ) " id="R-EDM-REQ-C004">Value supplied '<value-of xmlns="http://purl.oclc.org/dsdl/schematron" select="."/>' is unacceptable for constraints identified by 'LanguageCode-2.3' in the context 'query:QueryRequest/rim:Slot[@name='Procedure']/rim:SlotValue/rim:Value/rim:LocalizedString/@xml:lang'</sch:assert>
      </sch:rule>
      <sch:rule context="query:QueryRequest/query:Query/rim:Slot[@name='EvidenceRequest']/rim:SlotValue/sdg:DataServiceEvidenceType/sdg:Description/@lang">
         <!--{}[](LanguageCode-2.3)-->
         <sch:assert test="( false() or ( contains('AAAARABABKACEACHADAADYAEAFAFAAFHAFRAINAKAKAAKKALB (B) SQI (T)ALB (B) SQI (T)ALEALGALTAMAMHANANGANPAPAARARAARCARGARM (B) HYE (T)ARM (B) HYE (T)ARNARPARTARWASASMASTATHAUSAVAVAAVEAWAAYAYMAZAZEBABADBAIBAKBALBAMBANBAQ (B) EUS (T)BAQ (B) EUS (T)BASBATBEBEJBELBEMBENBERBGBHBHOBIBIHBIKBINBISBLABMBNBNTBOBOBOSBRBRABREBSBTKBUABUGBULBUR (B) MYA (T)BUR (B) MYA (T)BYNCACADCAICARCATCAUCECEBCELCHCHACHBCHECHGCHI (B) ZHO (T)CHI (B) ZHO (T)CHKCHMCHNCHOCHPCHRCHUCHVCHYCMCCNRCOCOPCORCOSCPECPFCPPCRCRECRHCRPCSCSCSBCUCUSCVCYCYCZE (B) CES (T)CZE (B) CES (T)DADAKDANDARDAYDEDEDELDENDGRDINDIVDOIDRADSBDUADUMDUT (B) NLD (T)DUT (B) NLD (T)DVDYUDZDZOEEEFIEGYEKAELELELXENENGENMEOEPOESESTETEUEUEWEEWOFAFAFANFAOFATFFFIFIJFILFINFIUFJFOFONFRFRFRE (B) FRA (T)FRE (B) FRA (T)FRMFROFRRFRSFRYFULFURFYGAGAAGAYGBAGDGEMGEO (B) KAT (T)GEO (B) KAT (T)GER (B) DEU (T)GER (B) DEU (T)GEZGILGLGLAGLEGLGGLVGMHGNGOHGONGORGOTGRBGRCGRE (B) ELL (T)GRE (B) ELL (T)GRNGSWGUGUJGVGWIHAHAIHATHAUHAWHEHEBHERHIHILHIMHINHITHMNHMOHOHRHRVHSBHTHUHUNHUPHYHYHZIAIBAIBOICE (B) ISL (T)ICE (B) ISL (T)IDIDOIEIGIIIIIIJOIKIKUILEILOINAINCINDINEINHIOIPKIRAIROISISITITAIUJAJAVJBOJPNJPRJRBJVKAKAKAAKABKACKALKAMKANKARKASKAUKAWKAZKBDKGKHAKHIKHMKHOKIKIKKINKIRKJKKKLKMKMBKNKOKOKKOMKONKORKOSKPEKRKRCKRLKROKRUKSKUKUAKUMKURKUTKVKWKYLALADLAHLAMLAOLATLAVLBLEZLGLILIMLINLITLNLOLOLLOZLTLTZLULUALUBLUGLUILUNLUOLUSLVMAC (B) MKD (T)MAC (B) MKD (T)MADMAGMAHMAIMAKMALMANMAO (B) MRI (T)MAO (B) MRI (T)MAPMARMASMAY (B) MSA (T)MAY (B) MSA (T)MDFMDRMENMGMGAMHMIMIMICMINMISMKMKMKHMLMLGMLTMNMNCMNIMNOMOHMONMOSMRMSMSMTMULMUNMUSMWLMWRMYMYMYNMYVNANAHNAINAPNAUNAVNBNBLNDNDENDONDSNENEPNEWNGNIANICNIUNLNLNNNNONONOBNOGNONNORNQONRNSONUBNVNWCNYNYANYMNYNNYONZIOCOCIOJOJIOMORORIORMOSOSAOSSOTAOTOPAPAAPAGPALPAMPANPAPPAUPEOPER (B) FAS (T)PER (B) FAS (T)PHIPHNPIPLPLIPOLPONPORPRAPROPSPTPUSQAA-QTZQUQUERAJRAPRARRMRNROROROAROHROMRURUM (B) RON (T)RUM (B) RON (T)RUNRUPRUSRWSASADSAGSAHSAISALSAMSANSASSATSCSCNSCOSDSESELSEMSGSGASGNSHNSISIDSINSIOSITSKSKSLSLASLO (B) SLK (T)SLO (B) SLK (T)SLVSMSMASMESMISMJSMNSMOSMSSNSNASNDSNKSOSOGSOMSONSOTSPASQSQSRSRDSRNSRPSRRSSSSASSWSTSUSUKSUNSUSSUXSVSWSWASWESYCSYRTATAHTAITAMTATTETELTEMTERTETTGTGKTGLTHTHATITIB (B) BOD (T)TIB (B) BOD (T)TIGTIRTIVTKTKLTLTLHTLITMHTNTOTOGTONTPITRTSTSITSNTSOTTTUKTUMTUPTURTUTTVLTWTWITYTYVUDMUGUGAUIGUKUKRUMBUNDURURDUZUZBVAIVEVENVIVIEVOVOLVOTWAWAKWALWARWASWEL (B) CYM (T)WEL (B) CYM (T)WENWLNWOWOLXALXHXHOYAOYAPYIYIDYOYORYPKZAZAPZBLZENZGHZHZHZHAZNDZUZULZUNZXXZZA',concat('',.,'')) ) ) " id="R-EDM-REQ-C030">Value supplied '<value-of xmlns="http://purl.oclc.org/dsdl/schematron" select="."/>' is unacceptable for constraints identified by 'LanguageCode-2.3' in the context 'query:QueryRequest/query:Query/rim:Slot[@name='EvidenceRequest']/rim:SlotValue/sdg:DataServiceEvidenceType/sdg:Description/@lang'</sch:assert>
      </sch:rule>
      <sch:rule context="query:QueryRequest/rim:Slot[@name='EvidenceRequester']/rim:SlotValue/rim:Element/sdg:Agent/sdg:Address/sdg:AdminUnitLevel1">
         <!--{}[](CountryIdentificationCode-2.3)-->
         <sch:assert test="( false() or ( contains('AFALDZASADAOAIAQAGARAMAWAUATAZBSBHBDBBBYBEBZBJBMBTBOBQBABWBVBRIOBNBGBFBICVKHCMCAKYCFTDCLCNCXCCCOKMCDCGCKCRHRCUCWCYCZCIDKDJDMDOECEGSVGQEREESZETFKFOFJFIFRGFPFTFGAGMGEDEGHGIELGLGDGPGUGTGGGNGWGYHTHMVAHNHKHUISINIDIRIQIEIMILITJMJPJEJOKZKEKIKPKRKWKGLALVLBLSLRLYLILTLUMOMGMWMYMVMLMTMHMQMRMUYTMXFMMDMCMNMEMSMAMZMMNANRNPNLNCNZNINENGNUNFMKMPNOOMPKPWPSPAPGPYPEPHPNPLPTPRQARORURWREBLSHKNLCMFPMVCWSSMSTSASNRSSCSLSGSXSKSISBSOZAGSSSESLKSDSRSJSECHSYTWTJTZTHTLTGTKTOTTTNTRTMTCTVUGUAAEGBUMUSUYUZVUVEVNVGVIWFEHYEZMZWAXAFGALBDZAASMANDAGOAIAATAATGARGARMABWAUSAUTAZEBHSBHRBGDBRBBLRBELBLZBENBMUBTNBOLBESBIHBWABVTBRAIOTBRNBGRBFABDICPVKHMCMRCANCYMCAFTCDCHLCHNCXRCCKCOLCOMCODCOGCOKCRIHRVCUBCUWCYPCZECIVDNKDJIDMADOMECUEGYSLVGNQERIESTSWZETHFLKFROFJIFINFRAGUFPYFATFGABGMBGEODEUGHAGIBGRCGRLGRDGLPGUMGTMGGYGINGNBGUYHTIHMDVATHNDHKGHUNISLINDIDNIRNIRQIRLIMNISRITAJAMJPNJEYJORKAZKENKIRPRKKORKWTKGZLAOLVALBNLSOLBRLBYLIELTULUXMACMDGMWIMYSMDVMLIMLTMHLMTQMRTMUSMYTMEXFSMMDAMCOMNGMNEMSRMARMOZMMRNAMNRUNPLNLDNCLNZLNICNERNGANIUNFKMKDMNPNOROMNPAKPLWPSEPANPNGPRYPERPHLPCNPOLPRTPRIQATROURUSRWAREUBLMSHNKNALCAMAFSPMVCTWSMSMRSTPSAUSENSRBSYCSLESGPSXMSVKSVNSLBSOMZAFSGSSSDESPLKASDNSURSJMSWECHESYRTWNTJKTZATHATLSTGOTKLTONTTOTUNTURTKMTCATUVUGAUKRAREGBRUMIUSAURYUZBVUTVENVNMVGBVIRWLFESHYEMZMBZWEALA',concat('',.,'')) ) ) " id="R-EDM-REQ-C015">Value supplied '<value-of xmlns="http://purl.oclc.org/dsdl/schematron" select="."/>' is unacceptable for constraints identified by 'CountryIdentificationCode-2.3' in the context 'query:QueryRequest/rim:Slot[@name='EvidenceRequester']/rim:SlotValue/rim:Element/sdg:Agent/sdg:Address/sdg:AdminUnitLevel1'</sch:assert>
      </sch:rule>
      <sch:rule context="query:QueryRequest/query:Query/rim:Slot[@name='NaturalPerson']/rim:SlotValue/sdg:Person/sdg:CurrentAddress/sdg:AdminUnitLevel1">
         <!--{}[](CountryIdentificationCode-2.3)-->
         <sch:assert test="( false() or ( contains('AFALDZASADAOAIAQAGARAMAWAUATAZBSBHBDBBBYBEBZBJBMBTBOBQBABWBVBRIOBNBGBFBICVKHCMCAKYCFTDCLCNCXCCCOKMCDCGCKCRHRCUCWCYCZCIDKDJDMDOECEGSVGQEREESZETFKFOFJFIFRGFPFTFGAGMGEDEGHGIELGLGDGPGUGTGGGNGWGYHTHMVAHNHKHUISINIDIRIQIEIMILITJMJPJEJOKZKEKIKPKRKWKGLALVLBLSLRLYLILTLUMOMGMWMYMVMLMTMHMQMRMUYTMXFMMDMCMNMEMSMAMZMMNANRNPNLNCNZNINENGNUNFMKMPNOOMPKPWPSPAPGPYPEPHPNPLPTPRQARORURWREBLSHKNLCMFPMVCWSSMSTSASNRSSCSLSGSXSKSISBSOZAGSSSESLKSDSRSJSECHSYTWTJTZTHTLTGTKTOTTTNTRTMTCTVUGUAAEGBUMUSUYUZVUVEVNVGVIWFEHYEZMZWAXAFGALBDZAASMANDAGOAIAATAATGARGARMABWAUSAUTAZEBHSBHRBGDBRBBLRBELBLZBENBMUBTNBOLBESBIHBWABVTBRAIOTBRNBGRBFABDICPVKHMCMRCANCYMCAFTCDCHLCHNCXRCCKCOLCOMCODCOGCOKCRIHRVCUBCUWCYPCZECIVDNKDJIDMADOMECUEGYSLVGNQERIESTSWZETHFLKFROFJIFINFRAGUFPYFATFGABGMBGEODEUGHAGIBGRCGRLGRDGLPGUMGTMGGYGINGNBGUYHTIHMDVATHNDHKGHUNISLINDIDNIRNIRQIRLIMNISRITAJAMJPNJEYJORKAZKENKIRPRKKORKWTKGZLAOLVALBNLSOLBRLBYLIELTULUXMACMDGMWIMYSMDVMLIMLTMHLMTQMRTMUSMYTMEXFSMMDAMCOMNGMNEMSRMARMOZMMRNAMNRUNPLNLDNCLNZLNICNERNGANIUNFKMKDMNPNOROMNPAKPLWPSEPANPNGPRYPERPHLPCNPOLPRTPRIQATROURUSRWAREUBLMSHNKNALCAMAFSPMVCTWSMSMRSTPSAUSENSRBSYCSLESGPSXMSVKSVNSLBSOMZAFSGSSSDESPLKASDNSURSJMSWECHESYRTWNTJKTZATHATLSTGOTKLTONTTOTUNTURTKMTCATUVUGAUKRAREGBRUMIUSAURYUZBVUTVENVNMVGBVIRWLFESHYEMZMBZWEALA',concat('',.,'')) ) ) " id="R-EDM-REQ-C045">Value supplied '<value-of xmlns="http://purl.oclc.org/dsdl/schematron" select="."/>' is unacceptable for constraints identified by 'CountryIdentificationCode-2.3' in the context 'query:QueryRequest/query:Query/rim:Slot[@name='NaturalPerson']/rim:SlotValue/sdg:Person/sdg:CurrentAddress/sdg:AdminUnitLevel1'</sch:assert>
      </sch:rule>
      <sch:rule context="query:QueryRequest/query:Query/rim:Slot[@name='LegalPerson']/rim:SlotValue/sdg:LegalPerson/sdg:RegisteredAddress/sdg:AdminUnitLevel1">
         <!--{}[](CountryIdentificationCode-2.3)-->
         <sch:assert test="( false() or ( contains('AFALDZASADAOAIAQAGARAMAWAUATAZBSBHBDBBBYBEBZBJBMBTBOBQBABWBVBRIOBNBGBFBICVKHCMCAKYCFTDCLCNCXCCCOKMCDCGCKCRHRCUCWCYCZCIDKDJDMDOECEGSVGQEREESZETFKFOFJFIFRGFPFTFGAGMGEDEGHGIELGLGDGPGUGTGGGNGWGYHTHMVAHNHKHUISINIDIRIQIEIMILITJMJPJEJOKZKEKIKPKRKWKGLALVLBLSLRLYLILTLUMOMGMWMYMVMLMTMHMQMRMUYTMXFMMDMCMNMEMSMAMZMMNANRNPNLNCNZNINENGNUNFMKMPNOOMPKPWPSPAPGPYPEPHPNPLPTPRQARORURWREBLSHKNLCMFPMVCWSSMSTSASNRSSCSLSGSXSKSISBSOZAGSSSESLKSDSRSJSECHSYTWTJTZTHTLTGTKTOTTTNTRTMTCTVUGUAAEGBUMUSUYUZVUVEVNVGVIWFEHYEZMZWAXAFGALBDZAASMANDAGOAIAATAATGARGARMABWAUSAUTAZEBHSBHRBGDBRBBLRBELBLZBENBMUBTNBOLBESBIHBWABVTBRAIOTBRNBGRBFABDICPVKHMCMRCANCYMCAFTCDCHLCHNCXRCCKCOLCOMCODCOGCOKCRIHRVCUBCUWCYPCZECIVDNKDJIDMADOMECUEGYSLVGNQERIESTSWZETHFLKFROFJIFINFRAGUFPYFATFGABGMBGEODEUGHAGIBGRCGRLGRDGLPGUMGTMGGYGINGNBGUYHTIHMDVATHNDHKGHUNISLINDIDNIRNIRQIRLIMNISRITAJAMJPNJEYJORKAZKENKIRPRKKORKWTKGZLAOLVALBNLSOLBRLBYLIELTULUXMACMDGMWIMYSMDVMLIMLTMHLMTQMRTMUSMYTMEXFSMMDAMCOMNGMNEMSRMARMOZMMRNAMNRUNPLNLDNCLNZLNICNERNGANIUNFKMKDMNPNOROMNPAKPLWPSEPANPNGPRYPERPHLPCNPOLPRTPRIQATROURUSRWAREUBLMSHNKNALCAMAFSPMVCTWSMSMRSTPSAUSENSRBSYCSLESGPSXMSVKSVNSLBSOMZAFSGSSSDESPLKASDNSURSJMSWECHESYRTWNTJKTZATHATLSTGOTKLTONTTOTUNTURTKMTCATUVUGAUKRAREGBRUMIUSAURYUZBVUTVENVNMVGBVIRWLFESHYEMZMBZWEALA',concat('',.,'')) ) ) " id="R-EDM-REQ-C056">Value supplied '<value-of xmlns="http://purl.oclc.org/dsdl/schematron" select="."/>' is unacceptable for constraints identified by 'CountryIdentificationCode-2.3' in the context 'query:QueryRequest/query:Query/rim:Slot[@name='LegalPerson']/rim:SlotValue/sdg:LegalPerson/sdg:RegisteredAddress/sdg:AdminUnitLevel1'</sch:assert>
      </sch:rule>
      
      <sch:rule context="query:QueryRequest/query:Query/rim:Slot[@name='AuthorizedRepresentative']/rim:SlotValue/sdg:Person/sdg:CurrentAddress/sdg:AdminUnitLevel1">
         <!--{}[](CountryIdentificationCode-2.3)-->
         <sch:assert test="( false() or ( contains('AFALDZASADAOAIAQAGARAMAWAUATAZBSBHBDBBBYBEBZBJBMBTBOBQBABWBVBRIOBNBGBFBICVKHCMCAKYCFTDCLCNCXCCCOKMCDCGCKCRHRCUCWCYCZCIDKDJDMDOECEGSVGQEREESZETFKFOFJFIFRGFPFTFGAGMGEDEGHGIELGLGDGPGUGTGGGNGWGYHTHMVAHNHKHUISINIDIRIQIEIMILITJMJPJEJOKZKEKIKPKRKWKGLALVLBLSLRLYLILTLUMOMGMWMYMVMLMTMHMQMRMUYTMXFMMDMCMNMEMSMAMZMMNANRNPNLNCNZNINENGNUNFMKMPNOOMPKPWPSPAPGPYPEPHPNPLPTPRQARORURWREBLSHKNLCMFPMVCWSSMSTSASNRSSCSLSGSXSKSISBSOZAGSSSESLKSDSRSJSECHSYTWTJTZTHTLTGTKTOTTTNTRTMTCTVUGUAAEGBUMUSUYUZVUVEVNVGVIWFEHYEZMZWAXAFGALBDZAASMANDAGOAIAATAATGARGARMABWAUSAUTAZEBHSBHRBGDBRBBLRBELBLZBENBMUBTNBOLBESBIHBWABVTBRAIOTBRNBGRBFABDICPVKHMCMRCANCYMCAFTCDCHLCHNCXRCCKCOLCOMCODCOGCOKCRIHRVCUBCUWCYPCZECIVDNKDJIDMADOMECUEGYSLVGNQERIESTSWZETHFLKFROFJIFINFRAGUFPYFATFGABGMBGEODEUGHAGIBGRCGRLGRDGLPGUMGTMGGYGINGNBGUYHTIHMDVATHNDHKGHUNISLINDIDNIRNIRQIRLIMNISRITAJAMJPNJEYJORKAZKENKIRPRKKORKWTKGZLAOLVALBNLSOLBRLBYLIELTULUXMACMDGMWIMYSMDVMLIMLTMHLMTQMRTMUSMYTMEXFSMMDAMCOMNGMNEMSRMARMOZMMRNAMNRUNPLNLDNCLNZLNICNERNGANIUNFKMKDMNPNOROMNPAKPLWPSEPANPNGPRYPERPHLPCNPOLPRTPRIQATROURUSRWAREUBLMSHNKNALCAMAFSPMVCTWSMSMRSTPSAUSENSRBSYCSLESGPSXMSVKSVNSLBSOMZAFSGSSSDESPLKASDNSURSJMSWECHESYRTWNTJKTZATHATLSTGOTKLTONTTOTUNTURTKMTCATUVUGAUKRAREGBRUMIUSAURYUZBVUTVENVNMVGBVIRWLFESHYEMZMBZWEALA',concat('',.,'')) ) ) " id="R-EDM-REQ-C067">Value supplied '<value-of xmlns="http://purl.oclc.org/dsdl/schematron" select="."/>' is unacceptable for constraints identified by 'CountryIdentificationCode-2.3' in the context 'query:QueryRequest/query:Query/rim:Slot[@name='AuthorizedRepresentative']/rim:SlotValue/sdg:Person/sdg:CurrentAddress/sdg:AdminUnitLevel1'</sch:assert>
      </sch:rule>
      
   </sch:pattern>
</sch:schema>   
