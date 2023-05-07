<?xml version="1.0" encoding="UTF-8"?>
<sch:schema xmlns:sch="http://purl.oclc.org/dsdl/schematron" queryBinding="xslt2">
    
    <sch:ns uri="http://data.europa.eu/p4s" prefix="sdg"/>
    <sch:ns uri="urn:oasis:names:tc:ebxml-regrep:xsd:rs:4.0" prefix="rs"/>
    <sch:ns uri="urn:oasis:names:tc:ebxml-regrep:xsd:rim:4.0" prefix="rim"/>
    <sch:ns uri="urn:oasis:names:tc:ebxml-regrep:xsd:query:4.0" prefix="query"/>
    <sch:ns uri="http://www.w3.org/2001/XMLSchema-instance" prefix="xsi"/>
    <sch:ns uri="http://www.w3.org/1999/xlink" prefix="xlink"/>

    <sch:pattern>
        <sch:rule context="/node()">
            <sch:let name="ln" value="local-name(/node())"/>
            <sch:assert test="$ln ='QueryResponse'" id="R-DSD-RESP-S001"
                >Root element of a query response document must be QueryResponse</sch:assert>
        </sch:rule>
    </sch:pattern>

    <sch:pattern>
        <sch:rule context="/node()">
            <sch:let name="ns" value="namespace-uri(/node())"/>
            <sch:assert test="$ns ='urn:oasis:names:tc:ebxml-regrep:xsd:query:4.0'" id="R-DSD-RESP-S002"
                >The namespace of root element of a query response document must be 'urn:oasis:names:tc:ebxml-regrep:xsd:query:4.0'</sch:assert>
        </sch:rule>
    </sch:pattern>
    
    <sch:pattern>
        <sch:rule context="query:QueryResponse">
            <sch:let name="status" value="@status" />
            <sch:assert test="@status" id="R-DSD-RESP-S005"
                >The 'status' attribute of a 'QueryResponse' MUST be present. </sch:assert>
        </sch:rule>
    </sch:pattern>
    
    <sch:pattern>
        <sch:rule context="query:QueryResponse">
            <sch:let name="status" value="@status" />
            <sch:assert test="$status = 'urn:oasis:names:tc:ebxml-regrep:ResponseStatusType:Success'" id="R-DSD-RESP-S006"
                >The 'status' attribute of a successfull 'QueryResponse' MUST be encoded as as 'urn:oasis:names:tc:ebxml-regrep:ResponseStatusType:Success'.</sch:assert>
        </sch:rule>
    </sch:pattern>

    <sch:pattern>
        <sch:rule context="query:QueryResponse[@status='urn:oasis:names:tc:ebxml-regrep:ResponseStatusType:Success']">
            <sch:assert test="count(rim:RegistryObjectList) = 1" id="R-DSD-RESP-S007"
                >A successful QueryResponse includes a RegistryObjectList</sch:assert>
            <sch:assert test="count(rim:RegistryObjectList/rim:RegistryObject) = 1" id="R-DSD-RESP-S0015"
                >A successful QueryResponse MUST include a 'rim:RegistryObject'</sch:assert>
            <sch:assert test="count(rs:Exception) = 0" id="R-DSD-RESP-S008"
                >A successful QueryResponse does not include an Exception</sch:assert>
        </sch:rule>       
    </sch:pattern>
    
    
    <sch:pattern>
        <sch:rule context="rim:RegistryObject">
            <sch:assert test="rim:Slot[@name='DataServiceEvidenceType']" id="R-DSD-RESP-S009"
                >The rim:Slot name="DataServiceEvidenceType" MUST be present in the QueryResponse.</sch:assert>
            <sch:assert test="count(rim:Slot) = 1" 
                >A 'query:QueryResponse' MUST not contain any other rim:Slots.</sch:assert>
        </sch:rule>
    </sch:pattern>
    
    <sch:pattern>
        <sch:rule context="rim:RegistryObject/rim:Slot[@name='DataServiceEvidenceType']/rim:SlotValue">
            <sch:let name="st"  value="substring-after(@xsi:type, ':')" />
            <sch:assert test="$st ='AnyValueType'" id="R-DSD-RESP-S010"
                >The rim:SlotValue of rim:Slot name="DataServiceEvidenceType" MUST be of "rim:AnyValueType"</sch:assert>
            <sch:assert test="count(sdg:DataServiceEvidenceType)=1" id="R-DSD-RESP-S011"
                >A  'rim:Slot[@name='DataServiceEvidenceType'/rim:SlotValue/sdg:DataServiceEvidenceType' MUST contain one sdg:DataServiceEvidenceType of the targetNamespace="http://data.europa.eu/p4s"</sch:assert>
        </sch:rule>
    </sch:pattern>
    
    <sch:pattern>
        <sch:rule context="query:QueryResponse/rim:RegistryObjectList/rim:RegistryObject/rim:Slot[@name='DataServiceEvidenceType']/rim:SlotValue/sdg:DataServiceEvidenceType">
            <sch:assert test="count(sdg:AccessService/sdg:Publisher/sdg:ClassificationConcept/sdg:SupportedValue) >= count(sdg:EvidenceProviderClassification)" id="R-DSD-RESP-S012"
                >A 'sdg:SupportedValue' MUST be provided if the 'sdg:EvidenceProviderClassification' is present in the 'rim:RegistryObject/rim:Slot[@name='DataServiceEvidenceType']'</sch:assert>
        </sch:rule>
    </sch:pattern>
    
    <sch:pattern>
        <sch:rule context="query:QueryResponse/rim:RegistryObjectList/rim:RegistryObject/rim:Slot[@name='DataServiceEvidenceType']/rim:SlotValue/sdg:DataServiceEvidenceType">
            <sch:assert test="sdg:AccessService" id="R-DSD-RESP-S013"
                >The xs:element name="sdg:AccessService" type="sdg:DataServiceType" MUST be present.</sch:assert>
        </sch:rule>
    </sch:pattern>
    
    <sch:pattern>
        <sch:rule context="query:QueryResponse/rim:RegistryObjectList/rim:RegistryObject/@id">
            <sch:assert test="matches(normalize-space((.)),'urn:uuid:[a-f0-9]{8}-[a-f0-9]{4}-[a-f0-9]{4}-[a-f0-9]{4}-[a-f0-9]{12}$','i')"  id="R-DSD-RESP-S014"
                >Each 'id' of 'rim:RegistryObject' MUST be unique UUID (RFC 4122) starting with prefix "urn:uuid:"
            </sch:assert>
        </sch:rule>
    </sch:pattern>


    
    
    
</sch:schema>