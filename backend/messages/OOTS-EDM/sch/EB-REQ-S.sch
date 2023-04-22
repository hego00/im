<?xml version="1.0" encoding="UTF-8"?>
<sch:schema 
    xmlns:sch="http://purl.oclc.org/dsdl/schematron" queryBinding="xslt2">
    
    <sch:ns uri="http://data.europa.eu/p4s" prefix="sdg"/>
    <sch:ns uri="urn:oasis:names:tc:ebxml-regrep:xsd:rs:4.0" prefix="rs"/>
    <sch:ns uri="urn:oasis:names:tc:ebxml-regrep:xsd:rim:4.0" prefix="rim"/>
    <sch:ns uri="urn:oasis:names:tc:ebxml-regrep:xsd:query:4.0" prefix="query"/>
    <sch:ns uri="http://www.w3.org/2001/XMLSchema-instance" prefix="xsi"/>
    <sch:ns uri="http://www.w3.org/1999/xlink" prefix="xlink"/>

    <!-- 
           EB-REQ-S excel sheet 
           Validates test sample tdd_chapters/OOTS-EDM/xml/EB/Response_for_Get_List_of_Requirements_Query.xml
     -->
    <sch:pattern>
        <sch:rule context="/node()">
            <sch:let name="ln" value="local-name(/node())"/>
            <sch:assert test="$ln ='QueryResponse'" id="R-EB-REQ-S001"
                >The root element of a query response document MUST be query:QueryResponse</sch:assert>
        </sch:rule>
    </sch:pattern>

    <sch:pattern>
        <sch:rule context="/node()">
            <sch:let name="ns" value="namespace-uri(/node())"/>
            <sch:assert test="$ns ='urn:oasis:names:tc:ebxml-regrep:xsd:query:4.0'" id="R-EB-REQ-S002"
                >The namespace of root element of a query response document must be 'urn:oasis:names:tc:ebxml-regrep:xsd:query:4.0'</sch:assert>
        </sch:rule>
    </sch:pattern>
    
    <sch:pattern>
        <sch:rule context="query:QueryResponse">
            <sch:assert test="@status" id="R-EB-REQ-S005"
                >The 'status' attribute of a 'QueryResponse' MUST be present.</sch:assert>         
        </sch:rule>
    </sch:pattern>
    
    <sch:pattern>
        <sch:rule context="query:QueryResponse">
            <sch:assert test="@status='urn:oasis:names:tc:ebxml-regrep:ResponseStatusType:Success'" id="R-EB-REQ-S006"
                >The 'status' attribute of a successfull 'QueryResponse' MUST be encoded as as 'urn:oasis:names:tc:ebxml-regrep:ResponseStatusType:Success'.</sch:assert>         
        </sch:rule>
    </sch:pattern>
    
    

    <sch:pattern>
        <!-- 
            If Response is Success there is only a RegistryObjectList 
            If Response is Failure then there is only an Exception 
        -->
        <sch:rule context="query:QueryResponse[
            @status='urn:oasis:names:tc:ebxml-regrep:ResponseStatusType:Success']">
            <sch:assert test="count(rim:RegistryObjectList) = 1" id="R-EB-REQ-S007"
                >A successful OOTS response includes a RegistryObjectList</sch:assert>
            <sch:assert test="count(rs:Exception) = 0" id="R-EB-REQ-S008"
                >A successful OOTS response does not include an Exception</sch:assert>
        </sch:rule>       
    </sch:pattern>

    <sch:pattern>
        <sch:rule context="rim:RegistryObject">
            <sch:assert test="rim:Slot[@name='Requirement']" id="R-EB-REQ-S011"
                >The rim:Slot name="Requirement" MUST be present in the QueryResponse.</sch:assert>
        </sch:rule>
        <sch:rule context="rim:RegistryObject">
            <sch:assert test="count(rim:Slot) = 1" id="R-EB-REQ-S012"
                >A 'query:QueryResponse' MUST not contain any other rim:Slots.</sch:assert>
        </sch:rule>
    </sch:pattern>

    <sch:pattern>
        <sch:rule context="rim:Slot[@name='Requirement']/rim:SlotValue">
            <sch:let name="st"  value="substring-after(@xsi:type, ':')" />
            <sch:assert test="$st ='AnyValueType'" id="R-EB-REQ-S013"
                >The rim:SlotValue of rim:Slot name="Requirement" MUST be of "rim:AnyValueType"<sch:value-of select="$st"/></sch:assert>
            <sch:assert test="count(sdg:Requirement)=1" id="R-EB-REQ-S014"
                >A  rim:Slot[@name=Requirement]/rim:SlotValue MUST contain one sdg:Requirement of the targetNamespace="http://data.europa.eu/p4s</sch:assert>
        </sch:rule>
    </sch:pattern>         

    <sch:pattern>
        <sch:rule context="rim:Slot[@name='Requirement']/rim:SlotValue/sdg:Requirement/sdg:ReferenceFramework/sdg:RelatedTo">
            <sch:assert test="count(sdg:Identifier)=1" id="R-EB-REQ-S015"
                >The xs:element name="RelatedTo" type="sdg:ReferenceFrameworkType"/ MUST only contain the 'sdg:Identifier'</sch:assert>
        </sch:rule>
    </sch:pattern>
    
    <sch:pattern>
        <sch:rule context="query:QueryResponse/rim:RegistryObjectList/rim:RegistryObject/rim:Slot[@name='Requirement']/rim:SlotValue/sdg:Requirement">          
            <sch:assert test="count(sdg:EvidenceTypeList)=0" id="R-EB-REQ-S016"
                >The xs:element name="Requirement" type="sdg:RequirementType" / MUST not contain the EvidenceTypeList.</sch:assert>      
        </sch:rule>
    </sch:pattern>
    
    <sch:pattern>
        <sch:rule context="query:QueryResponse/rim:RegistryObjectList/rim:RegistryObject/rim:Slot[@name='Requirement']/rim:SlotValue/sdg:Requirement">          
            <sch:assert test="sdg:ReferenceFramework" id="R-EB-REQ-S017"
                >The xs:element name="ReferenceFramework" type="sdg:ReferenceFrameworkType" MUST be present.</sch:assert>      
        </sch:rule>
    </sch:pattern>

    
    <sch:pattern>
        <sch:rule context="query:QueryResponse/rim:RegistryObjectList">          
            <sch:assert test="rim:RegistryObject" id="R-EB-REQ-S018"
                >A successful QueryResponse MUST include a 'rim:RegistryObject'.</sch:assert>      
        </sch:rule>
    </sch:pattern>
    
    <sch:pattern>
        <sch:rule context="query:QueryResponse/rim:RegistryObjectList/rim:RegistryObject/@id">          
            <sch:assert test="matches(normalize-space((.)),'urn:uuid:[a-f0-9]{8}-[a-f0-9]{4}-[a-f0-9]{4}-[a-f0-9]{4}-[a-f0-9]{12}$','i')" 
                flag='ERROR' id="R-EB-REQ-S019">
                The 'id' of a 'RegistryObject' MUST be unique UUID (RFC 4122) starting with prefix "urn:uuid:".
            </sch:assert>   
        </sch:rule>
    </sch:pattern>
    
    <sch:pattern>
        <sch:rule context="query:QueryResponse/rim:RegistryObjectList/rim:RegistryObject/rim:Slot[@name='Requirement']/rim:SlotValue/sdg:Requirement/sdg:ReferenceFramework">          
            <sch:assert test="sdg:RelatedTo" id="R-EB-REQ-S020"
                >The xs:element name="RelatedTo" type="sdg:ReferenceFrameworkType" MUST be present.</sch:assert>      
        </sch:rule>
    </sch:pattern>
    
    <sch:pattern>
        <sch:rule context="query:QueryResponse/rim:RegistryObjectList/rim:RegistryObject/rim:Slot[@name='Requirement']/rim:SlotValue/sdg:Requirement/sdg:ReferenceFramework">          
            <sch:assert test="sdg:Jurisdiction" id="R-EB-REQ-S021"
                >The xs:element name="sdg:Jurisdiction" type="sdg:JurisdictionType" MUST be present.</sch:assert>      
        </sch:rule>
    </sch:pattern>
   
</sch:schema>