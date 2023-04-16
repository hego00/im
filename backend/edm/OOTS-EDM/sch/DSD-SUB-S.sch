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
            <sch:assert test="$ln ='SubmitObjectsRequest'" id="R-DSD-SUB-S001" flag="FATAL"
                >The root element of a query response document MUST be 'lcm:SubmitObjectsRequest'</sch:assert>
        </sch:rule>
    </sch:pattern>

    <sch:pattern>
        <sch:rule context="/node()">
            <sch:let name="ns" value="namespace-uri(/node())"/>
            <sch:assert test="$ns ='urn:oasis:names:tc:ebxml-regrep:xsd:lcm:4.0'" id="R-DSD-SUB-S002" flag="FATAL"
                >The namespace of root element of a 'lcm:SubmitObjectsRequest' must be 'urn:oasis:names:tc:ebxml-regrep:xsd:lcm:4.0'</sch:assert>
        </sch:rule>
    </sch:pattern>
    
    <sch:pattern>
        <sch:rule context="lcm:SubmitObjectsRequest">
            <sch:assert test="@id" flag='FATAL' id="R-DSD-SUB-S003"
                >The 'id' attribute of a 'SubmitObjectsRequest' MUST be present.</sch:assert>
        </sch:rule>
    </sch:pattern>
    
    <sch:pattern>
        <sch:rule context="lcm:SubmitObjectsRequest">
            <sch:assert test="matches(normalize-space(@id),'urn:uuid:[a-f0-9]{8}-[a-f0-9]{4}-[a-f0-9]{4}-[a-f0-9]{4}-[a-f0-9]{12}$','i')" 
                flag='FATAL' id="R-DSD-SUB-S004"
                >The 'id' attribute of a 'SubmitObjectsRequest' MUST be unique UUID (RFC 4122).</sch:assert>
        </sch:rule>
    </sch:pattern>

    <sch:pattern>
        <sch:rule context="lcm:SubmitObjectsRequest">
            <sch:assert test="count(rim:RegistryObjectList)>0" id="R-DSD-SUB-S005" flag="FATAL"
                >A  'SubmitObjectsRequest' MUST include a 'rim:RegistryObjectList'.'</sch:assert>
        </sch:rule>
        <sch:rule context="lcm:SubmitObjectsRequest/rim:RegistryObjectList">
            <sch:assert test="count(rim:RegistryObject)>0" id="R-DSD-SUB-S036" flag="FATAL"
                >A 'SubmitObjectsRequest' MUST include a 'rim:RegistryObject'</sch:assert>
        </sch:rule>        
    </sch:pattern>
    
    <sch:pattern>
        <sch:rule context="rim:RegistryObject">
            <sch:let name="idattr" value="@id"/>
            <sch:let name="st"  value="substring-after(@xsi:type, ':')" />
            <sch:assert test="string-length($idattr)>0" id="R-DSD-SUB-S006" flag="FATAL"
                >Each 'rim:RegistryObject' MUST include an 'id' attribute</sch:assert>
            <sch:assert test="$st ='AssociationType' or count(rim:Classification)>0" id="R-DSD-SUB-S007"
                >Each 'rim:RegistryObject' MUST include a 'rim:Classification' if the 'rim:RegistryObject' is not an 'xsi:type="rim:AssociationType"'</sch:assert>
        </sch:rule>
    </sch:pattern>

    <sch:pattern>
        <sch:rule context="rim:RegistryObject/rim:Classification">
            <sch:let name="idattr" value="@id"/>
            <sch:let name="schemeattr" value="@classificationScheme"/>
            <sch:let name="nodeattr" value="@classificationNode"/>
            <sch:assert test="string-length($idattr)>0"  flag='FATAL' id="R-DSD-SUB-S008"   
                >Each 'rim:Classification' MUST include an 'id' attribute</sch:assert>
            <sch:assert test="matches(normalize-space(@id),'urn:uuid:[a-f0-9]{8}-[a-f0-9]{4}-[a-f0-9]{4}-[a-f0-9]{4}-[a-f0-9]{12}$','i')" 
                flag='FATAL' id="R-DSD-SUB-S009"
                >Each id of 'rim:Classification' MUST be unique UUID (RFC 4122).</sch:assert>
            <sch:assert test="string-length($schemeattr)>0"  flag='FATAL' id="R-DSD-SUB-S010"   
                >Each 'rim:Classification' MUST include an 'classificationScheme' attribute</sch:assert>
            <sch:assert test="string-length($nodeattr)>0"  flag='FATAL' id="R-DSD-SUB-S011"   
                >Each 'rim:Classification' MUST include an 'classificationNode' attribute</sch:assert>
            <sch:assert test="$schemeattr = 'urn:fdc:oots:classification:dsd'" id="R-DSD-SUB-S012"
                > The 'classificationScheme' attribute MUST be 'urn:fdc:oots:classification:dsd'</sch:assert>
            <sch:assert test="$nodeattr = 'EvidenceProvider' or $nodeattr = 'DataServiceEvidenceType'"  flag='FATAL' id="R-DSD-SUB-S013"   
                > The 'classificationNode' attribute MUST be 'EvidenceProvider' or 'DataServiceEvidenceType'</sch:assert>
            
        </sch:rule>
    </sch:pattern>
   
    <sch:pattern>
        <!-- 
        <sch:rule context="lcm:SubmitObjectsRequest/rim:RegistryObjectList/rim:RegistryObject/rim:Classification[@classificationNode='EvidenceProvider']">
            <sch:assert test="//rim:RegistryObject/rim:Slot[@name='EvidenceProvider']" id="R-DSD-SUB-S014"
                >A 'rim:RegistryObject' with the classificationNode 'EvidenceProvider' MUST include a  rim:Slot name="EvidenceProvider" and no other</sch:assert>
        </sch:rule>
        --> 
        <sch:rule context="lcm:SubmitObjectsRequest/rim:RegistryObjectList/rim:RegistryObject/rim:Slot[@name='EvidenceProvider']/rim:SlotValue">
            <sch:let name="st"  value="substring-after(@xsi:type, ':')"/>
            <sch:assert test="$st ='AnyValueType'" id="R-DSD-SUB-S016"
                >The rim:SlotValue of rim:Slot name="EvidenceProvider" MUST be of "rim:AnyValueType"</sch:assert>
        </sch:rule>
        
        <sch:rule context="lcm:SubmitObjectsRequest/rim:RegistryObjectList/rim:RegistryObject/rim:Slot[@name='DataServiceEvidenceType']/rim:SlotValue">
            <sch:let name="st"  value="substring-after(@xsi:type, ':')"/>
            <sch:assert test="$st ='AnyValueType'" id="R-DSD-SUB-S017"
                >The rim:SlotValue of rim:Slot name="DataServiceEvidenceType" MUST be of "rim:AnyValueType"</sch:assert>
        </sch:rule>    
        
        <sch:rule context="lcm:SubmitObjectsRequest/rim:RegistryObjectList/rim:RegistryObject/rim:Slot[@name='EvidenceProvider']">
            <sch:assert test="count(rim:SlotValue/sdg:AccessService)=1" id="R-DSD-SUB-S018"
                >A  'rim:Slot[@name='EvidenceProvider']/rim:SlotValue' MUST contain one sdg:AccessService of the targetNamespace="http://data.europa.eu/p4s"</sch:assert>
        </sch:rule>   
                     
        <sch:rule context="lcm:SubmitObjectsRequest/rim:RegistryObjectList/rim:RegistryObject/rim:Slot[@name='DataServiceEvidenceType']">
            <sch:assert test="count(rim:SlotValue/sdg:DataServiceEvidenceType)=1" id="R-DSD-SUB-S019"
                >A  'rim:Slot[@name='DataServiceEvidenceType']/rim:SlotValue' MUST contain one sdg:DataServiceEvidenceType of the targetNamespace="http://data.europa.eu/p4s"</sch:assert>
        </sch:rule>   
        
        <sch:rule context="lcm:SubmitObjectsRequest/rim:RegistryObjectList/rim:RegistryObject">       
            <sch:assert test="count(rim:Slot[@name='rim:Classification '])+count(@xsi:type='AssociationType')=1" id="R-DSD-SUB-S022"
                >If a 'rim:RegistryObject' does not have a 'rim:Classification" it MUST have the attribute 'xsi:type=rim:AssociationType'</sch:assert>
        </sch:rule>
    </sch:pattern>
        
    <sch:pattern>  
        <sch:rule context="rim:RegistryObject[@sourceObject and @targetObject]">       
            <sch:let name="sourceObject"  value="@sourceObject"/>
            <sch:let name="targetObject" value="@targetObject"/>
            <sch:let name="etl_count" value="count(//rim:RegistryObject[@id=$sourceObject and child::rim:Classification[@classificationNode='EvidenceProvider']])"/>
            <sch:let name="et_count" value="count(//rim:RegistryObject[@id=$targetObject and child::rim:Classification[@classificationNode='DataServiceEvidenceType']])"/>
            <sch:assert test="$etl_count + $et_count = 2" id="R-DSD-SUB-S023"
                >Each 'rim:RegistryObject' with a classificationNode 'EvidenceProvider' or 'DataServiceEvidenceType' MUST have an association described in a
                the attribute  'xsi:type="rim:AssociationType"'</sch:assert>
        </sch:rule>
    </sch:pattern>
    
    <sch:pattern> 
        <sch:rule context="rim:RegistryObject[@xsi:type='rim:AssociationType']">
            <sch:assert test="@sourceObject" id="R-DSD-SUB-S024"
                >A 'rim:RegistryObject' with the attribute 'xsi:type="rim:AssociationType"' MUST have an attribute 'sourceObject'</sch:assert>
        </sch:rule>
        
        <sch:rule context="rim:RegistryObject[@xsi:type='rim:AssociationType']">
            <sch:let name="sourceObject"  value="@sourceObject"/>
            <sch:assert test="//rim:RegistryObject[@id=$sourceObject]/rim:Classification[@classificationNode='EvidenceProvider']" id="R-DSD-SUB-S025"
                >A 'rim:RegistryObject' with the attribute 'xsi:type="rim:AssociationType"' MUST have an attribute 'sourceObject' that lists the id of the 
            'rim:RegistryObject' (starting with prefix "urn:uuid:") from classificationNode 'EvidenceProvider' </sch:assert>
        </sch:rule>
        
        <sch:rule context="rim:RegistryObject[@xsi:type='rim:AssociationType']">
            <sch:assert test="@targetObject" id="R-DSD-SUB-S026"
                >A 'rim:RegistryObject' with the attribute 'xsi:type="rim:AssociationType"' MUST have an attribute 'targetObject'</sch:assert>
        </sch:rule>
        
        <sch:rule context="rim:RegistryObject[@xsi:type='rim:AssociationType']">
            <sch:let name="targetObject" value="@targetObject"/>
            <sch:assert test="//rim:RegistryObject[@id=$targetObject]/rim:Classification[@classificationNode='DataServiceEvidenceType']" id="R-DSD-SUB-S027"
                >A 'rim:RegistryObject' with the attribute 'xsi:type="rim:AssociationType"' MUST have an attribute 'targetObject' that lists the id of the 
                'rim:RegistryObject' (starting with prefix "urn:uuid:") with classificationNode 'DataServiceEvidenceType'  </sch:assert>
        </sch:rule>
    </sch:pattern>
    
    <sch:pattern>
        <sch:rule context="rim:RegistryObject[@type='urn:oasis:names:tc:ebxml-regrep:AssociationType:ServesEvidenceType']">
            <sch:let name="sourceObject"  value="@sourceObject"/>
            <sch:let name="targetObject" value="@targetObject"/>
            <sch:assert test="//rim:RegistryObject[@id=$sourceObject]/rim:Classification[@classificationNode='EvidenceProvider']" id="R-DSD-SUB-S028a"
                >Source object of ServesEvidenceType association must be classified as EvidenceProvider <sch:value-of select="$sourceObject"/></sch:assert>
            <sch:assert test="//rim:RegistryObject[@id=$targetObject]/rim:Classification[@classificationNode='DataServiceEvidenceType']" id="R-DSD-SUB-S028b"
                >Target object of ServesEvidenceType association must be classified as DataServiceEvidenceType <sch:value-of select="$targetObject"/></sch:assert>
         </sch:rule>
    </sch:pattern>
    
    <sch:pattern>
        <sch:rule context="rim:RegistryObject[@sourceObject and @targetObject]">
            <sch:let name="sourceObject"  value="@sourceObject"/>
            <sch:let name="targetObject" value="@targetObject"/>
            <sch:let name="type" value="@type"/>
            <sch:let name="etl_count" value="count(//rim:RegistryObject[@id=$sourceObject and child::rim:Classification[@classificationNode='EvidenceProvider']])" />
            <sch:let name="et_count" value="count(//rim:RegistryObject[@id=$targetObject and child::rim:Classification[@classificationNode='DataServiceEvidenceType']])"></sch:let>
            <sch:assert test="number($etl_count) + number($et_count) != 2 or $type = 'urn:oasis:names:tc:ebxml-regrep:AssociationType:ServesEvidenceType'" id="R-DSD-SUB-S029"
                >A 'rim:RegistryObject' with the attribute 'xsi:type="rim:AssociationType"' linking 'rim:RegistryObject' with the classificationNode 
                'EvidenceProvider' (@sourceObject) to 'rim:RegistryObject' with the classificationNode 'DataServiceEvidenceType' (@targetObject) MUST 
                use the type="urn:oasis:names:tc:ebxml-regrep:AssociationType:ServesEvidenceType"</sch:assert>
        </sch:rule>
    </sch:pattern>
        
    <sch:pattern>
        <sch:rule context="lcm:SubmitObjectsRequest">       
            <sch:assert test="rim:RegistryObjectList/rim:RegistryObject" id="R-DSD-SUB-S030"
                >A 'lcm:SubmitObjectsRequest' MUST not contain any other rim:Slots.</sch:assert>
        </sch:rule> 
    </sch:pattern>    
    
    <sch:pattern>
        <sch:rule context="lcm:SubmitObjectsRequest/rim:RegistryObjectList/rim:RegistryObject/rim:Slot/rim:SlotValue/sdg:AccessService/sdg:Publisher/sdg:ClassificationConcept">
            <sch:assert test="sdg:SupportedValue" id="R-DSD-SUB-S031">
                A value for 'sdg:SupportedValue' MUST be provided if the 'sdg:EvidenceProviderClassification' 
                is present in the 'rim:RegistryObject/rim:Slot[@name='DataServiceEvidenceType']'.  
            </sch:assert>
        </sch:rule>
    </sch:pattern>
    
    <sch:pattern>
        <sch:rule context="lcm:SubmitObjectsRequest/rim:RegistryObjectList/rim:RegistryObject/@id">
            <sch:assert test="matches(normalize-space((.)),'urn:uuid:[a-f0-9]{8}-[a-f0-9]{4}-[a-f0-9]{4}-[a-f0-9]{4}-[a-f0-9]{12}$','i')" 
                flag='ERROR' id="R-DSD-SUB-S032">
                Each id of 'rim:RegistryObject' MUST be unique UUID (RFC 4122) starting with prefix "urn:uuid:". 
            </sch:assert>
        </sch:rule>
    </sch:pattern>
    
    <sch:pattern>
        <sch:rule context="lcm:SubmitObjectsRequest/rim:RegistryObjectList">
            <sch:assert test="rim:RegistryObject/rim:Slot[@name='EvidenceProvider']" 
                flag='ERROR' id="R-DSD-SUB-S033">
                A 'SubmitObjectsRequest' MUST include a 'rim:RegistryObject' with a rim:Slot name="EvidenceProvider"  
            </sch:assert>
        </sch:rule>
    </sch:pattern>
    
    <sch:pattern>
        <sch:rule context="lcm:SubmitObjectsRequest/rim:RegistryObjectList">
            <sch:assert test="rim:RegistryObject/rim:Slot[@name='DataServiceEvidenceType']" 
                flag='ERROR' id="R-DSD-SUB-S034">
                A 'SubmitObjectsRequest' MUST include a 'rim:RegistryObject' with a rim:Slot name="DataServiceEvidenceType"  
            </sch:assert>
        </sch:rule>
    </sch:pattern>
    
    <sch:pattern>
        <sch:rule context="lcm:SubmitObjectsRequest/rim:RegistryObjectList">
            <sch:assert test="rim:RegistryObject[@xsi:type='rim:AssociationType']" 
                flag='ERROR' id="R-DSD-SUB-S035">
                A 'SubmitObjectsRequest' MUST include a 'rim:RegistryObject' with the attribute 'xsi:type="rim:AssociationType"
            </sch:assert>
        </sch:rule>
    </sch:pattern>
   
</sch:schema>