<?xml version="1.0" encoding="UTF-8"?>
<sch:schema 
    xmlns:sch="http://purl.oclc.org/dsdl/schematron" >
    
    <sch:ns uri="http://data.europa.eu/p4s" prefix="sdg"/>
    <sch:ns uri="urn:oasis:names:tc:ebxml-regrep:xsd:rs:4.0" prefix="rs"/>
    <sch:ns uri="urn:oasis:names:tc:ebxml-regrep:xsd:rim:4.0" prefix="rim"/>
    <sch:ns uri="urn:oasis:names:tc:ebxml-regrep:xsd:query:4.0" prefix="query"/>
    <sch:ns uri="http://www.w3.org/2001/XMLSchema-instance" prefix="xsi"/>
    <sch:ns uri="http://www.w3.org/1999/xlink" prefix="xlink"/>
    
    <sch:pattern>
        <sch:rule context="/node()">
            <sch:let name="ln" value="local-name(/node())"/>
            <sch:assert test="$ln ='QueryResponse'" id="R-EB-ERR-S001"
                >The root element of a query response document MUST be query:QueryResponse</sch:assert>
        </sch:rule>
    </sch:pattern>
    
    <sch:pattern>
        <sch:rule context="/node()">
            <sch:let name="ns" value="namespace-uri(/node())"/>
            <sch:assert test="$ns ='urn:oasis:names:tc:ebxml-regrep:xsd:query:4.0'" id="R-EB-ERR-S002"
                >The namespace of root element of a query response document must be 'urn:oasis:names:tc:ebxml-regrep:xsd:query:4.0'</sch:assert>
        </sch:rule>
    </sch:pattern>
    
    <sch:pattern>
        <sch:rule context="query:QueryResponse">
            <sch:assert test="@status" id="R-EB-ERR-S005">
                The 'status' attribute of a 'QueryResponse' MUST be present. 
            </sch:assert>
        </sch:rule>
    </sch:pattern>
     
    <sch:pattern>
        <sch:rule context="query:QueryResponse">
            <sch:assert test="@status='urn:oasis:names:tc:ebxml-regrep:ResponseStatusType:Failure'" id="R-EB-ERR-S006"
                >The 'status' attribute of an unsuccessfull 'query:QueryResponse' MUST be encoded as as 'urn:oasis:names:tc:ebxml-regrep:ResponseStatusType:Failure'.</sch:assert>         
        </sch:rule>
    </sch:pattern>
    
    <sch:pattern>
        <!-- 
            If Response is Success there is only a RegistryObjectList 
            If Response is Failure then there is only an Exception 
        -->
        <sch:rule context="query:QueryResponse[@status='urn:oasis:names:tc:ebxml-regrep:ResponseStatusType:Failure']">
            <sch:assert test="count(rim:RegistryObjectList) = 0" id="R-EB-ERR-S007"
                >An unsuccessful 'query:QueryResponse' does not include a 'rim:RegistryObjectList'</sch:assert>
        </sch:rule> 
    </sch:pattern> 
    <sch:pattern>      
        <sch:rule context="query:QueryResponse[@status='urn:oasis:names:tc:ebxml-regrep:ResponseStatusType:Failure']">
            <sch:assert test="count(rs:Exception) = 1" id="R-EB-ERR-S008"
                >An unsuccessful 'query:QueryResponse' includes an Exception</sch:assert>
        </sch:rule>       
    </sch:pattern>
   
    <sch:pattern>
        <sch:rule context="query:QueryResponse/rs:Exception">
            <sch:assert test="@xsi:type" id="R-EB-ERR-009"
                >The 'xsi:type' attribute of a 'rs:Exception' MUST be present. </sch:assert>
        </sch:rule> 
    </sch:pattern> 
    <sch:pattern>
        <sch:rule context="query:QueryResponse/rs:Exception">          
            <sch:assert test="@severity" id="R-EB-ERR-011a"
                >The 'severity' attribute of a 'rs:Exception' MUST be present. </sch:assert>
            </sch:rule>
    </sch:pattern> 
    <sch:pattern>       
        <sch:rule context="query:QueryResponse/rs:Exception">
            <sch:assert test="@severity='urn:oasis:names:tc:ebxml-regrep:ErrorSeverityType:Error'" id="R-EB-ERR-012"
                >The value of 'severity' attribute of a 'rs:Exception' MUST  be 'urn:oasis:names:tc:ebxml-regrep:ErrorSeverityType:Error'. </sch:assert>          
            </sch:rule>   
    </sch:pattern> 
    <sch:pattern>
        <sch:rule context="query:QueryResponse/rs:Exception">
            <sch:assert test="@message" id="R-EB-ERR-013"
                >The 'message' attribute of a 'rs:Exception' MUST be present. </sch:assert>
            </sch:rule> 
    </sch:pattern> 
    <sch:pattern>
        <sch:rule context="query:QueryResponse/rs:Exception">
            <sch:assert test="@code" id="R-EB-ERR-015"
                >The 'code' attribute of a 'rs:Exception' MUST be present. </sch:assert>
            </sch:rule>
    </sch:pattern> 
    <sch:pattern>
        <sch:rule context="query:QueryResponse">
            <sch:assert test="count(rim:Slot) = 0" id="R-EB-ERR-017"
                >An unsuccessfull 'query:QueryResponse' MUST not contain any rim:Slots.</sch:assert>          
        </sch:rule>      
    </sch:pattern>  
    <sch:pattern>
        <sch:rule context="query:QueryResponse/rs:Exception/@code">
            <!--{}[](EBErrorCodes-CodeList)-->
            <sch:assert test="( false() or ( contains('EB:ERR:0001EB:ERR:0002EB:ERR:0003EB:ERR:0004EB:ERR:0005EB:ERR:0006EB:ERR:0007',concat('',.,'')) ) )" id="R-EB-ERR-016">Value supplied '<value-of xmlns="http://purl.oclc.org/dsdl/schematron" select="."/>' is unacceptable for constraints identified by 'EBErrorCodes-CodeList' in the context 'query:QueryResponse/rs:Exception/@code'</sch:assert>
        </sch:rule>
        <sch:rule context="query:QueryResponse/rs:Exception/@xsi:type">
            <!--{}[](EBDErrorCodes-CodeList)-->
            <sch:assert test="( false() or ( contains('&#x7f;rs:ObjectNotFoundExceptionType&#x7f;rs:ObjectNotFoundExceptionType&#x7f;rs:InvalidRequestExceptionType&#x7f;rs:InvalidRequestExceptionType&#x7f;rs:InvalidRequestExceptionType&#x7f;rs:InvalidRequestExceptionType&#x7f;',concat('&#x7f;',.,'&#x7f;')) ) )" id="R-EB-ERR-010">The value of 'xsi:type' attribute of a 'rs:Exception' MUST be a 'type' provided by the code list 'EBErrorCodes'</sch:assert>
        </sch:rule>
        <sch:rule context="query:QueryResponse/rs:Exception/@severity">
            <!--{}[](ErrorSeverity-CodeList)-->
            <sch:assert test="( false() or ( contains('urn:oasis:names:tc:ebxml-regrep:ErrorSeverityType:Errorurn:sr.oots.tech.europa.eu:codes:ErrorSeverity:DSDErrorResponse:AdditionalInputurn:sr.oots.tech.europa.eu:codes:ErrorSeverity:EDMErrorResponse:PreviewRequired',concat('',.,'')) ) )" id="R-EB-ERR-011b">Value supplied '<value-of xmlns="http://purl.oclc.org/dsdl/schematron" select="."/>' is unacceptable for constraints identified by 'ErrorSeverity-CodeList' in the context 'query:QueryResponse/rs:Exception/@severity'</sch:assert>
        </sch:rule>
        
        
    </sch:pattern>  
</sch:schema>