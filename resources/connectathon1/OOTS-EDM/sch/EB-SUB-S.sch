<?xml version="1.0" encoding="UTF-8"?>
<sch:schema xmlns:sch="http://purl.oclc.org/dsdl/schematron" queryBinding="xslt2">
    
    <sch:ns uri="http://data.europa.eu/p4s" prefix="sdg"/>
    <sch:ns uri="urn:oasis:names:tc:ebxml-regrep:xsd:rs:4.0" prefix="rs"/>
    <sch:ns uri="urn:oasis:names:tc:ebxml-regrep:xsd:rim:4.0" prefix="rim"/>
    <sch:ns uri="urn:oasis:names:tc:ebxml-regrep:xsd:lcm:4.0" prefix="lcm"/>
    <sch:ns uri="http://www.w3.org/2001/XMLSchema-instance" prefix="xsi"/>
    <sch:ns uri="http://www.w3.org/1999/xlink" prefix="xlink"/>

    <sch:pattern>
        <sch:rule context="/node()">
            <sch:let name="ln" value="local-name(/node())"/>
            <sch:assert test="$ln ='SubmitObjectsRequest'" id="EB-SUB-S001" flag="FATAL"
                >The root element of a query response document MUST be 'lcm:SubmitObjectsRequest'</sch:assert>
        </sch:rule>
    </sch:pattern>

    <sch:pattern>
        <sch:rule context="/node()">
            <sch:let name="ns" value="namespace-uri(/node())"/>
            <sch:assert test="$ns ='urn:oasis:names:tc:ebxml-regrep:xsd:lcm:4.0'" id="EB-SUB-S002" flag="FATAL"
                >The namespace of root element of a 'lcm:SubmitObjectsRequest' must be 'urn:oasis:names:tc:ebxml-regrep:xsd:lcm:4.0'</sch:assert>
        </sch:rule>
    </sch:pattern>
    
    <sch:pattern>
        <sch:rule context="lcm:SubmitObjectsRequest">
            <sch:assert test="matches(normalize-space(@id),'urn:uuid:[a-f0-9]{8}-[a-f0-9]{4}-[a-f0-9]{4}-[a-f0-9]{4}-[a-f0-9]{12}$','i')" 
                flag='FATAL' id="EB-SUB-S004"
                >The 'id' attribute of a 'SubmitObjectsRequest' MUST be unique UUID (RFC 4122).</sch:assert>
        </sch:rule>
    </sch:pattern>

    <sch:pattern>
        <sch:rule context="lcm:SubmitObjectsRequest">
            <sch:assert test="count(rim:RegistryObjectList)>0" id="EB-SUB-S005" flag="FATAL"
                >A 'SubmitObjectsRequest' MUST include a 'rim:RegistryObjectList'</sch:assert>
        </sch:rule>   
    </sch:pattern>
    
    <sch:pattern>
        <sch:rule context="rim:RegistryObject">
            <sch:let name="idattr" value="@id"/>
            <sch:let name="st"  value="substring-after(@xsi:type, ':')" />
            <sch:assert test="string-length($idattr)>0" id="EB-SUB-S006" flag="FATAL"
                >Each 'rim:RegistryObject' MUST include an 'id' attribute</sch:assert>
            <sch:assert test="$st ='AssociationType' or count(rim:Classification)>0" id="EB-SUB-S007"
                >Each 'rim:RegistryObject' MUST include a 'rim:Classification' if the 'rim:RegistryObject' is not an 'xsi:type="rim:AssociationType"'</sch:assert>
        </sch:rule>
    </sch:pattern>

    <sch:pattern>
        <sch:rule context="rim:RegistryObject/rim:Classification">
            <sch:let name="idattr" value="@id"/>
            <sch:let name="schemeattr" value="@classificationScheme"/>
            <sch:let name="nodeattr" value="@classificationNode"/>
            <sch:assert test="string-length($idattr)>0"  flag='FATAL' id="EB-SUB-S008"   
                >Each 'rim:Classification' MUST include an 'id' attribute</sch:assert>
            <sch:assert test="matches(normalize-space(@id),'urn:uuid:[a-f0-9]{8}-[a-f0-9]{4}-[a-f0-9]{4}-[a-f0-9]{4}-[a-f0-9]{12}$','i')" 
                flag='FATAL' id="EB-SUB-S009"
                >Each id of 'rim:Classification' MUST be unique UUID (RFC 4122).</sch:assert>
            <sch:assert test="string-length($schemeattr)>0"  flag='FATAL' id="EB-SUB-S010"   
                >Each 'rim:Classification' MUST include an 'classificationScheme' attribute</sch:assert>
            <sch:assert test="string-length($nodeattr)>0"  flag='FATAL' id="EB-SUB-S011"   
                >Each 'rim:Classification' MUST include an 'classificationNode' attribute</sch:assert>
            <sch:assert test="$schemeattr = 'urn:fdc:oots:classification:eb'" id="EB-SUB-S012"
                > The 'classificationScheme' attribute MUST be 'urn:fdc:oots:classification:eb'</sch:assert>
            <sch:assert test="$nodeattr = 'EvidenceType' or $nodeattr = 'EvidenceTypeList' or $nodeattr = 'Requirement' or $nodeattr = 'ReferenceFramework'"  flag='FATAL' id="EB-SUB-S013"   
                > The 'classificationNode' attribute MUST be 'EvidenceType', 'EvidenceTypeList', 'Requirement' or 'ReferenceFramework'</sch:assert>
        </sch:rule>

        <sch:rule context="rim:RegistryObject/EvidenceType">   
            <sch:let name="nodeattr" value="rim:Classification[@classificationNode]"/>
            <sch:assert test="$nodeattr = 'EvidenceType'" id="EB-SUB-S014" 
                > A 'rim:RegistryObject' with the classificationNode 'EvidenceType' MUST include a  rim:Slot name=EvidenceType and no other</sch:assert>
        </sch:rule>
        
        <sch:rule context="rim:RegistryObject/EvidenceTypeList">   
            <sch:let name="nodeattr" value="rim:Classification[@classificationNode]"/>
            <sch:assert test="$nodeattr = 'EvidenceTypeList'" id="EB-SUB-S015" 
                >A 'rim:RegistryObject' with the classificationNode 'EvidenceTypeList' MUST include a  rim:Slot name=EvidenceTypeList and no other</sch:assert>
        </sch:rule>
        
        <sch:rule context="rim:RegistryObject/Requirement">   
            <sch:let name="nodeattr" value="rim:Classification[@classificationNode]"/>
            <sch:assert test="$nodeattr = 'Requirement'" id="EB-SUB-S016" 
                > A 'rim:RegistryObject' with the classificationNode 'Requirement' MUST include a  rim:Slot name=Requirement and no other</sch:assert>
        </sch:rule>
        
        <sch:rule context="rim:RegistryObject/ReferenceFramework">   
            <sch:let name="nodeattr" value="rim:Classification[@classificationNode]"/>
            <sch:assert test="$nodeattr = 'ReferenceFramework'" id="EB-SUB-S017" 
                > A 'rim:RegistryObject' with the classificationNode 'ReferenceFramework' MUST include a  rim:Slot name=ReferenceFramework and no other</sch:assert>
        </sch:rule>
    </sch:pattern>    
    <sch:pattern>      
        <sch:rule context="lcm:SubmitObjectsRequest/rim:RegistryObjectList/rim:RegistryObject/rim:Slot[@name='EvidenceType']/rim:SlotValue">
            <sch:let name="st"  value="substring-after(@xsi:type, ':')" />
            <sch:assert test="$st ='AnyValueType'" id="EB-SUB-S018"
                >The rim:SlotValue of rim:Slot name="EvidenceType" MUST be of 'rim:AnyValueType'</sch:assert>
        </sch:rule>
        
        <sch:rule context="lcm:SubmitObjectsRequest/rim:RegistryObjectList/rim:RegistryObject/rim:Slot[@name='EvidenceTypeList']/rim:SlotValue">
            <sch:let name="st"  value="substring-after(@xsi:type, ':')" />
            <sch:assert test="$st ='AnyValueType'" id="EB-SUB-S019"
                >The rim:SlotValue of rim:Slot name="EvidenceTypeList" MUST be of "rim:AnyValueType"</sch:assert>
        </sch:rule>
        
        <sch:rule context="lcm:SubmitObjectsRequest/rim:RegistryObjectList/rim:RegistryObject/rim:Slot[@name='Requirement']/rim:SlotValue">
            <sch:let name="st"  value="substring-after(@xsi:type, ':')" />
            <sch:assert test="$st ='AnyValueType'" id="EB-SUB-S020"
                >The rim:SlotValue of rim:Slot name="Requirement" MUST be of "rim:AnyValueType"</sch:assert>
        </sch:rule>
        
        <sch:rule context="lcm:SubmitObjectsRequest/rim:RegistryObjectList/rim:RegistryObject/rim:Slot[@name='ReferenceFramework']/rim:SlotValue">
            <sch:let name="st"  value="substring-after(@xsi:type, ':')" />
            <sch:assert test="$st ='AnyValueType'" id="EB-SUB-S021"
                >The rim:SlotValue of rim:Slot name="ReferenceFramework" MUST be of "rim:AnyValueType"</sch:assert>
        </sch:rule>
                            
        <sch:rule context="lcm:SubmitObjectsRequest/rim:RegistryObjectList/rim:RegistryObject/rim:Slot[@name='EvidenceType']/rim:SlotValue">       
            <sch:assert test="sdg:EvidenceType" id="EB-SUB-S022"
                > A 'rim:Slot[@name='EvidenceType'/rim:SlotValue' MUST contain one sdg:EvidenceType of the targetNamespace="http://data.europa.eu/p4s"</sch:assert>
        </sch:rule>
        
        <sch:rule context="lcm:SubmitObjectsRequest/rim:RegistryObjectList/rim:RegistryObject/rim:Slot[@name='EvidenceTypeList']/rim:SlotValue">       
            <sch:assert test="sdg:EvidenceTypeList" id="EB-SUB-S023"
                > A 'rim:Slot[@name='EvidenceTypeList'/rim:SlotValue' MUST contain one sdg:EvidenceTypeList of the targetNamespace="http://data.europa.eu/p4s"</sch:assert>
        </sch:rule>
        
        <sch:rule context="lcm:SubmitObjectsRequest/rim:RegistryObjectList/rim:RegistryObject/rim:Slot[@name='Requirement']/rim:SlotValue">       
            <sch:assert test="sdg:Requirement" id="EB-SUB-S024"
                >A 'rim:Slot[@name='Requirement'/rim:SlotValue' MUST contain one sdg:Requirement of the targetNamespace="http://data.europa.eu/p4s"</sch:assert>
        </sch:rule>
        
        <sch:rule context="lcm:SubmitObjectsRequest/rim:RegistryObjectList/rim:RegistryObject/rim:Slot[@name='ReferenceFramework']/rim:SlotValue">       
            <sch:assert test="sdg:ReferenceFramework" id="EB-SUB-S025"
                >A 'rim:Slot[@name='ReferenceFramework'/rim:SlotValue' MUST contain one sdg:ReferenceFramwork of the targetNamespace="http://data.europa.eu/p4s"</sch:assert>
        </sch:rule>
       
        <sch:rule context="lcm:SubmitObjectsRequest/rim:RegistryObjectList/rim:RegistryObject/rim:Slot[@name='EvidenceType']/rim:SlotValue/sdg:EvidenceType">       
            <sch:assert test="count(sdg:Distribution)=0" id="EB-SUB-S026"
                >A 'rim:slot[@name='EvidenceType']/rim:SlotValue/sdg:EvidenceType' MUST not contain a 'sdg:Distribution'</sch:assert>
        </sch:rule>
        
        <sch:rule context="lcm:SubmitObjectsRequest/rim:RegistryObjectList/rim:RegistryObject/rim:Slot[@name='EvidenceTypeList']/rim:SlotValue/sdg:EvidenceTypeList">       
            <sch:assert test="count(sdg:EvidenceType)=0" id="EB-SUB-S027"
                >A 'rim:slot[@name='EvidenceTypeList']/rim:SlotValue/sdg:EvidenceTypeList' MUST not contain a 'sdg:EvidenceType'</sch:assert>
        </sch:rule>
        
        <sch:rule context="lcm:SubmitObjectsRequest/rim:RegistryObjectList/rim:RegistryObject/rim:Slot[@name='Requirement']/rim:SlotValue/sdg:Requirement">       
            <sch:assert test="count(sdg:EvidenceType)=0 and count(sdg:ReferenceFramework)=0" id="EB-SUB-S028"
                >A 'rim:slot[@name='Requirement']/rim:SlotValue/sdg:Requirement' MUST not contain a 'sdg:EvidenceType' and a 'sdg:ReferenceFramework'</sch:assert>
        </sch:rule>
        
        <sch:rule context="lcm:SubmitObjectsRequest/rim:RegistryObjectList/rim:RegistryObject/rim:Slot[@name='ReferenceFramework']/rim:SlotValue/sdg:ReferenceFramework/sdg:RelatedTo">       
            <sch:assert test="sdg:Identifier" id="EB-SUB-S029"
                >The xs:element name="RelatedTo" type="sdg:ReferenceFrameworkType"/ MUST only contain the 'sdg:Identifier'</sch:assert>
        </sch:rule>
            
        <sch:rule context="lcm:SubmitObjectsRequest/rim:RegistryObjectList/rim:RegistryObject">       
            <sch:assert test="count(rim:Slot[@name='rim:Classification '])+count(@xsi:type='AssociationType')=1" id="EB-SUB-S030"
                >If a 'rim:RegistryObject' does not have a 'rim:Classification" it MUST have the attribute 'xsi:type=rim:AssociationType'</sch:assert>
        </sch:rule>
    </sch:pattern>   
        
    <sch:pattern>
        <sch:rule context="rim:RegistryObject[@type='urn:oasis:names:tc:ebxml-regrep:AssociationType:ContainsEvidence']">
            <sch:let name="sourceObject"  value="@sourceObject"/>
            <sch:let name="targetObject" value="@targetObject"/>
            <sch:assert test="//rim:RegistryObject[@id=$sourceObject]/rim:Classification[@classificationNode='EvidenceTypeList']" id="R-EB-SUB-S036a"
                >Source object of ContainsEvidence association must be classified as EvidenceTypeList <sch:value-of select="$sourceObject"/></sch:assert>
            <sch:assert test="//rim:RegistryObject[@id=$targetObject]/rim:Classification[@classificationNode='EvidenceType']" id="R-EB-SUB-S036b"
                >Target object of ContainsEvidence association must be classified as EvidenceType <sch:value-of select="$targetObject"/></sch:assert>
        </sch:rule>
    </sch:pattern>

     <sch:pattern>
        <sch:rule context="rim:RegistryObject[@sourceObject and @targetObject]">
            <sch:let name="sourceObject"  value="@sourceObject"/>
            <sch:let name="targetObject" value="@targetObject"/>
            <sch:let name="type" value="@type"/>
            <sch:let name="etl_count" value="count(//rim:RegistryObject[@id=$sourceObject and child::rim:Classification[@classificationNode='EvidenceTypeList']])" />
            <sch:let name="et_count" value="count(//rim:RegistryObject[@id=$targetObject and child::rim:Classification[@classificationNode='EvidenceType']])"></sch:let>
            <sch:assert test="number($etl_count) + number($et_count) != 2 or $type = 'urn:oasis:names:tc:ebxml-regrep:AssociationType:ContainsEvidence'" id="R-EB-SUB-S037"
                >A 'rim:RegistryObject' with the attribute 'xsi:type="rim:AssociationType"' linking 'rim:RegistryObject' with the classificationNode 'EvidenceTypeList' 
                (@sourceObject) to 'rim:RegistryObject' with the classificationNode 'EvidenceType' (@targetObject) MUST use the 
                type="urn:oasis:names:tc:ebxml-regrep:AssociationType:ContainsEvidence"</sch:assert>
        </sch:rule>
    </sch:pattern>

    <sch:pattern>
        <sch:rule context="rim:RegistryObject[@type='urn:oasis:names:tc:ebxml-regrep:AssociationType:FulfillsRequirement']">
            <sch:let name="sourceObject"  value="@sourceObject"/>
            <sch:let name="targetObject" value="@targetObject"/>
            <sch:assert test="//rim:RegistryObject[@id=$sourceObject]/rim:Classification[@classificationNode='EvidenceTypeList']" id="EB-SUB-S038a"
                >Source object of FulfillsRequirement association must be classified as EvidenceTypeList <sch:value-of select="$sourceObject"/></sch:assert>
            <sch:assert test="//rim:RegistryObject[@id=$targetObject]/rim:Classification[@classificationNode='Requirement']" id="EB-SUB-S038b"
                >Target object of FulfillsRequirement association must be classified as Requirement <sch:value-of select="$targetObject"/></sch:assert>
        </sch:rule>
    </sch:pattern>
 
    <sch:pattern>
        <sch:rule context="rim:RegistryObject[@sourceObject and @targetObject]">
            <sch:let name="sourceObject"  value="@sourceObject"/>
            <sch:let name="targetObject" value="@targetObject"/>
            <sch:let name="type" value="@type"/>
            <sch:let name="etl_count" value="count(//rim:RegistryObject[@id=$sourceObject and child::rim:Classification[@classificationNode='EvidenceTypeList']])" />
            <sch:let name="et_count" value="count(//rim:RegistryObject[@id=$targetObject and child::rim:Classification[@classificationNode='Requirement']])"></sch:let>
            <sch:assert test="number($etl_count) + number($et_count) != 2 or $type = 'urn:oasis:names:tc:ebxml-regrep:AssociationType:FulfillsRequirement'" id="R-EB-SUB-S039"
                >A 'rim:RegistryObject' with the attribute 'xsi:type="rim:AssociationType"' linking 'rim:RegistryObject' with the classificationNode 'EvidenceTypeList' 
                (@sourceObject) to 'rim:RegistryObject' with the classificationNode 'Requirement' (@targetObject) or to a unique UUID (RFC 4122) starting with prefix
                "urn:uuid:" (@targetObject) MUST use the type="urn:oasis:names:tc:ebxml-regrep:AssociationType:FulfillsRequirement"</sch:assert>
        </sch:rule>
    </sch:pattern>
    
    <sch:pattern>
        <sch:rule context="rim:RegistryObject[@type='urn:oasis:names:tc:ebxml-regrep:AssociationType:DerivesFromReferenceFramework']">
            <sch:let name="sourceObject"  value="@sourceObject"/>
            <sch:let name="targetObject" value="@targetObject"/>
            <sch:assert test="//rim:RegistryObject[@id=$sourceObject]/rim:Classification[@classificationNode='Requirement']" id="EB-SUB-S040a"
                >Source object of DerivesFromReferenceFramework association must be classified as Requirement <sch:value-of select="$sourceObject"/></sch:assert>
            <sch:assert test="//rim:RegistryObject[@id=$targetObject]/rim:Classification[@classificationNode='ReferenceFramework']" id="EB-SUB-S040b"
                >Target object of DerivesFromReferenceFramework association must be classified as ReferenceFramework <sch:value-of select="$targetObject"/></sch:assert>
        </sch:rule>
    </sch:pattern>
    
    <sch:pattern>
        <sch:rule context="rim:RegistryObject[@sourceObject and @targetObject]">
            <sch:let name="sourceObject"  value="@sourceObject"/>
            <sch:let name="targetObject" value="@targetObject"/>
            <sch:let name="type" value="@type"/>
            <sch:let name="etl_count" value="count(//rim:RegistryObject[@id=$sourceObject and child::rim:Classification[@classificationNode='Requirement']])"/>
            <sch:let name="et_count" value="count(//rim:RegistryObject[@id=$targetObject and child::rim:Classification[@classificationNode='ReferenceFramework']])"></sch:let>
            <sch:assert test="number($etl_count) + number($et_count) != 2 or $type = 'urn:oasis:names:tc:ebxml-regrep:AssociationType:DerivesFromReferenceFramework'" id="R-EB-SUB-S040"
                >A 'rim:RegistryObject' with the attribute 'xsi:type="rim:AssociationType"' linking a unique UUID (RFC 4122) starting with prefix "urn:uuid:"  
                (@sourceObject) or a 'rim:RegistryObject' with the classificationNode 'Requirement' (@sourceObject) to 'rim:RegistryObject' with the classificationNode 
                'ReferenceFramework' (@targetObject) MUST use the type="urn:oasis:names:tc:ebxml-regrep:AssociationType:DerivesFromReferenceFramework"</sch:assert>
        </sch:rule>
    </sch:pattern>
    <!--

    -->
    <sch:pattern>
        <sch:rule context="lcm:SubmitObjectsRequest">       
            <sch:assert test="rim:RegistryObjectList/rim:RegistryObject" id="EB-SUB-S042"
                >A 'lcm:SubmitObjectsRequest' MUST not contain any other rim:Slots.</sch:assert>
        </sch:rule> 
    </sch:pattern>
        
        <sch:pattern>
            <sch:rule context="lcm:SubmitObjectsRequest/rim:RegistryObjectList/rim:RegistryObject/@id">
                <sch:assert test="matches(normalize-space((.)),'urn:uuid:[a-f0-9]{8}-[a-f0-9]{4}-[a-f0-9]{4}-[a-f0-9]{4}-[a-f0-9]{12}$','i')" id="R-EDM-REQ-S043">
                    Each id of 'rim:RegistryObject' MUST be unique UUID (RFC 4122) starting with prefix "urn:uuid:".
                </sch:assert>
            </sch:rule>
        </sch:pattern>
        
        <sch:pattern>
            <sch:rule context="lcm:SubmitObjectsRequest/rim:RegistryObjectList">
                <sch:assert test="count(rim:RegistryObject/rim:Slot[@name='EvidenceType'])>0" id="R-EDM-REQ-S044">
                    A 'SubmitObjectsRequest' MUST include a 'rim:RegistryObject' with a rim:Slot name="EvidenceType". 
                </sch:assert>
            </sch:rule>
        </sch:pattern>
        
        <sch:pattern>
            <sch:rule context="lcm:SubmitObjectsRequest/rim:RegistryObjectList">
                <sch:assert test="count(rim:RegistryObject/rim:Slot[@name='EvidenceTypeList'])>0" id="R-EDM-REQ-S045">
                    A 'SubmitObjectsRequest' MUST include a 'rim:RegistryObject' with a rim:Slot name="EvidenceTypeList" 
                </sch:assert>
            </sch:rule>
        </sch:pattern>
        
        <sch:pattern>
            <sch:rule context="lcm:SubmitObjectsRequest/rim:RegistryObjectList">
                <sch:assert test="count(rim:RegistryObject[@xsi:type='rim:AssociationType'])>0" id="R-EDM-REQ-S047">
                    A 'SubmitObjectsRequest' MUST include a 'rim:RegistryObject' with the attribute 'xsi:type="rim:AssociationType" 
                </sch:assert>
            </sch:rule>
        </sch:pattern>
        
        <sch:pattern>
            <sch:rule context="lcm:SubmitObjectsRequest/rim:RegistryObjectList">
                <sch:assert test="count(rim:RegistryObject/rim:Slot[@name='ReferenceFramework'])>0" id="R-EDM-REQ-S048">
                    A 'SubmitObjectsRequest' MUST include a 'rim:RegistryObject' with a rim:Slot name="ReferenceFramework" 
                </sch:assert>
            </sch:rule>
        </sch:pattern>
        
        <sch:pattern>          
            <sch:rule context="lcm:SubmitObjectsRequest/rim:RegistryObjectList/rim:RegistryObject/rim:Slot/rim:SlotValue/sdg:ReferenceFramework">
                <sch:assert test="sdg:RelatedTo" id="R-EDM-REQ-S049">
                    The xs:element name="RelatedTo" type="sdg:ReferenceFrameworkType" MUST be present.
                </sch:assert>
            </sch:rule>
        </sch:pattern>
        
        <sch:pattern>
            <sch:rule context="lcm:SubmitObjectsRequest/rim:RegistryObjectList/rim:RegistryObject/rim:Slot/rim:SlotValue/sdg:ReferenceFramework">
                <sch:assert test="sdg:Jurisdiction" id="R-EDM-REQ-S050">
                    The xs:element name="sdg:Jurisdiction" type="sdg:JurisdictionType" MUST be present.
                </sch:assert>
            </sch:rule>
        </sch:pattern>
    
        <sch:pattern>
            <sch:rule context="rim:RegistryObject[@type='urn:oasis:names:tc:ebxml-regrep:AssociationType:DerivesFromReferenceFramework']">
                <sch:let name="sourceObject"  value="@sourceObject"/>
                <sch:assert test="//rim:RegistryObject[@id=$sourceObject]/rim:Classification[@classificationNode='Requirement']"  id="EB-SUB-S051"
                    >A 'rim:RegistryObject' with type="urn:oasis:names:tc:ebxml-regrep:AssociationType:DerivesFromReferenceFramework" MUST have a @sourceObject 
                     that uses same id of the 'rim:RegistryObject' 
                    (starting with prefix "urn:uuid:") with the classificationNode 'Requirement' </sch:assert>
            </sch:rule>
        </sch:pattern>
        <sch:pattern>
            <sch:rule context="rim:RegistryObject[@type='urn:oasis:names:tc:ebxml-regrep:AssociationType:DerivesFromReferenceFramework']">
                <sch:let name="targetObject"  value="@targetObject"/>
                <sch:assert test="//rim:RegistryObject[@id=$targetObject]/rim:Classification[@classificationNode='ReferenceFramework']"  id="EB-SUB-S052"
                    > A 'rim:RegistryObject' with type="urn:oasis:names:tc:ebxml-regrep:AssociationType:DerivesFromReferenceFramework" MUST have a 
                    @targetObject that uses same UUID (RFC 4122) of the 'rim:RegistryObject' (starting with prefix "urn:uuid:") with the classificationNode 
                    'ReferenceFramework' .
                </sch:assert>
            </sch:rule>
        </sch:pattern>   
  
        <sch:pattern>
            <sch:rule context="rim:RegistryObject[@type='urn:oasis:names:tc:ebxml-regrep:AssociationType:FulfillsRequirement']">
                <sch:let name="targetObject"  value="@targetObject"/>
                <sch:assert test="//rim:RegistryObject[@id=$targetObject]/rim:Classification[@classificationNode='Requirement']"  id="EB-SUB-S053"
                    > A 'rim:RegistryObject' with type="urn:oasis:names:tc:ebxml-regrep:AssociationType:FulfillsRequirement" MUST have a @targetObject
                    that uses a unique UUID (RFC 4122) (starting with prefix "urn:uuid:") or that uses same id of the 'rim:RegistryObject' 
                    (starting with prefix "urn:uuid:") with the classificationNode 'Requirement' .
                </sch:assert>
            </sch:rule>
        </sch:pattern>
    
        <sch:pattern>
            <sch:rule context="rim:RegistryObject[@type='urn:oasis:names:tc:ebxml-regrep:AssociationType:ContainsEvidence']">
                <sch:let name="sourceObject"  value="@sourceObject"/>
                <sch:assert test="//rim:RegistryObject[@id=$sourceObject]/rim:Classification[@classificationNode='EvidenceTypeList']"  id="EB-SUB-S054"
                    > A 'rim:RegistryObject' with type="urn:oasis:names:tc:ebxml-regrep:AssociationType:ContainsEvidence" MUST have a @sourceObject that 
                    uses the same id of the 'rim:RegistryObject' (starting with prefix "urn:uuid:") with the classificationNode 'EvidenceTypeList'. 
                </sch:assert>
            </sch:rule>
        </sch:pattern>
    
        <sch:pattern>
            <sch:rule context="rim:RegistryObject[@type='urn:oasis:names:tc:ebxml-regrep:AssociationType:ContainsEvidence']">
                <sch:let name="targetObject"  value="@targetObject"/>
                <sch:assert test="//rim:RegistryObject[@id=$targetObject]/rim:Classification[@classificationNode='EvidenceType']"  id="EB-SUB-S055"
                    > A 'rim:RegistryObject' with type="urn:oasis:names:tc:ebxml-regrep:AssociationType:ContainsEvidence" MUST have a @targetObject 
                    that uses the same id of the 'rim:RegistryObject' (starting with prefix "urn:uuid:") with the classificationNode 'EvidenceType'. 
                </sch:assert>
            </sch:rule>
        </sch:pattern>

</sch:schema>