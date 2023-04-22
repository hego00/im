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
      <sch:rule context="query:QueryResponse/rim:Slot[@name='SpecificationIdentifier']/rim:SlotValue">
         <sch:assert test="rim:Value='oots-edm:v1.0'" id="R-EDM-ERR-C001"
            >The 'rim:Value' of the 'SpecificationIdentifier' MUST be the fixed value "oots-edm:v1.0".</sch:assert>         
      </sch:rule>
   </sch:pattern>
   
   <sch:pattern>  
      <sch:rule context="query:QueryResponse/rim:Slot[@name='EvidenceResponseIdentifier']/rim:SlotValue/rim:Value">
         <sch:assert test="matches(normalize-space((.)),'[a-f0-9]{8}-[a-f0-9]{4}-[a-f0-9]{4}-[a-f0-9]{4}-[a-f0-9]{12}$','i')" id="R-EDM-ERR-C002"
            >The 'rim:Value' of the 'EvidenceResponseIdentifier' MUST be unique UUID (RFC 4122) for each response."</sch:assert>
      </sch:rule>
   </sch:pattern> 
   
   <sch:pattern>
      <sch:rule context="query:QueryResponse/rim:Slot[@name='ErrorProvider']/rim:SlotValue/sdg:Agent/sdg:Identifier">
         <sch:assert test="@schemeID" id="R-EDM-ERR-C003"
            >The 'schemeID' attribute of 'Identifier' MUST be present.</sch:assert>         
      </sch:rule>
   </sch:pattern>
   
   <sch:pattern>      
      <sch:rule context="query:QueryResponse/rim:Slot[@name='ErrorProvider']/rim:SlotValue/sdg:Agent">
         <sch:assert test="not(normalize-space(sdg:Classification)='')" id="R-EDM-ERR-C007"
            >The value for 'Agent/Classification' MUST be provided.</sch:assert>         
      </sch:rule>
   </sch:pattern>
   
   <sch:pattern>
      <sch:rule context="query:QueryResponse/rim:Slot[@name='EvidenceRequester']/rim:SlotValue/sdg:Agent/sdg:Identifier">
         <sch:assert test="@schemeID" id="R-EDM-ERR-C009"
            >The 'schemeID' attribute of 'Identifier' MUST be present.</sch:assert>         
      </sch:rule>
   </sch:pattern>
   
   <sch:pattern>
      <sch:rule context="query:QueryResponse[@status='urn:oasis:names:tc:ebxml-regrep:ResponseStatusType:Failure']">
         <sch:assert test="count(rs:Exception)=1" id="R-EDM-ERR-C011"
            >The 'rs:Exception' class of a 'QueryResponse' MUST be present if  'status' attribute of a 'QueryResponse' is 
            "urn:oasis:names:tc:ebxml-regrep:ResponseStatusType:Failure".</sch:assert>         
      </sch:rule>
   </sch:pattern>
   
   <sch:pattern>
      <sch:rule context="query:QueryResponse/rs:Exception">
         <sch:assert test="@xsi:type" id="R-EDM-ERR-C012"
            >The 'xsi:type' attribute of a 'rs:Exception' MUST be present. </sch:assert>         
      </sch:rule>
   </sch:pattern>
   
   <sch:pattern>
      <sch:rule context="query:QueryResponse/rs:Exception[@xsi:type='rs:AuthorizationExceptionType']">
         <sch:assert test="not(matches(@severity,'urn:oasis:names:tc:ebxml-regrep:ErrorSeverityType:Error'))" id="R-EDM-ERR-C015"
            >The value of 'severity' attribute of a 'rs:Exception' MUST  be 'urn:oasis:names:tc:ebxml-regrep:ErrorSeverityType:Error' if the 
            rs:Exception  (@code 'EDM:ERR:0002') is NOT used.</sch:assert>         
      </sch:rule>
   </sch:pattern>
   
   <sch:pattern>
      <sch:rule context="query:QueryResponse/rs:Exception">
         <sch:assert test="@message" id="R-EDM-ERR-C016"
            >The 'message' attribute of a 'rs:Exception' MUST be present. </sch:assert>         
      </sch:rule>
   </sch:pattern>
   
   <sch:pattern>
      <sch:rule context="query:QueryResponse/rs:Exception/rim:Slot[@name='Timestamp']/rim:SlotValue/rim:Value">
         <sch:assert test="matches(normalize-space(text()),'[0-9]{4}-[0-9]{2}-[0-9]{2}T[0-9]{2}:[0-9]{2}:[0-9]{2}','i')" id="R-EDM-ERR-C018">
            The 'rim:Value' of 'IssueDateTime' MUST be according to xsd:dateTime.</sch:assert>
      </sch:rule>
   </sch:pattern>
    
   <sch:pattern>        
      <sch:rule context="query:QueryResponse/rs:Exception/rim:Slot[@name='PreviewLocation']/rim:SlotValue">
         <sch:assert test="matches(rim:Value, '^https://')" id="R-EDM-ERR-C019"
            >The 'rim:Value' of a 'PreviewLocation' MUST be a URI starting with 'https://'.</sch:assert>         
      </sch:rule>
   </sch:pattern>
   
   <sch:pattern>       
      <sch:rule context="query:QueryResponse/rs:Exception/rim:Slot[@name='PreviewMethod']/rim:SlotValue">
         <sch:assert test="matches(rim:Value, '^GET$') or matches(rim:value, '^POST$')" id="R-EDM-ERR-C021"
            >The 'rim:Value' of a 'PreviewMethod' MUST be either the HTTP verb 'GET' or 'POST'.</sch:assert>         
      </sch:rule>
   </sch:pattern>
   
   <sch:pattern>
      <sch:rule context="query:QueryResponse/rs:Exception[@severity='urn:sr.oots.tech.europa.eu:codes:ErrorSeverity:EDMErrorResponse:PreviewRequired']">
         <sch:assert test="count(rim:Slot[@name='PreviewLocation']=1)" id="R-EDM-ERR-C022"
            >If a 'rim:Slot[@name='PreviewLocation']' is provided, the 'rs:Exception' MUST  be 
            'urn:sr.oots.tech.europa.eu:codes:ErrorSeverity:EDMErrorResponse:PreviewRequired' and use the rs:Exception</sch:assert>         
      </sch:rule>
   </sch:pattern>
   
   <sch:pattern>
      <sch:rule context="query:QueryResponse/rim:Slot[@name='EvidenceRequester']/rim:SlotValue/sdg:Agent/sdg:Identifier">
         <!--{}[](EAS-CodeList)-->
         <sch:let name="suffix" value="substring-after(@schemeID, 'urn:cef.eu:names:identifier:EAS:')"/>
         <sch:assert test="( false() or ( contains('0002000700090037006000880096009701060130013501420147015101700183018401880190019101920193019401950196019801990200020102020203020402050208020902100211021202130215021699019906990799109913991499159918991999209922992399249925992699279928992999309931993299339934993599369937993899399940994199429943994499459946994799489949995099519952995399559957ANAQASAUEM',concat('',$suffix,'')) ) or starts-with(@schemeID, 'urn:oasis:names:tc:ebcore:partyid-type:unregistered') ) " id="R-EDM-ERR-C010">The value of the 'schemeID' attribute of the 'Identifier' MUST  be part of the code list 'EAS' (Electronic Address Scheme ) and use the prefix 'urn:cef.eu:names:identifier:EAS:[Code]' or  start with the following value 'urn:oasis:names:tc:ebcore:partyid-type:unregistered'</sch:assert>
      </sch:rule>
      <sch:rule context="query:QueryResponse/rim:Slot[@name='ErrorProvider']/rim:SlotValue/sdg:Agent/sdg:Identifier">
         <!--{}[](EAS-CodeList)-->
         <sch:let name="suffix" value="substring-after(@schemeID, 'urn:cef.eu:names:identifier:EAS:')"/>
         <sch:assert test="( false() or ( contains('0002000700090037006000880096009701060130013501420147015101700183018401880190019101920193019401950196019801990200020102020203020402050208020902100211021202130215021699019906990799109913991499159918991999209922992399249925992699279928992999309931993299339934993599369937993899399940994199429943994499459946994799489949995099519952995399559957ANAQASAUEM',concat('',$suffix,'')) ) or starts-with(@schemeID, 'urn:oasis:names:tc:ebcore:partyid-type:unregistered') ) " id="R-EDM-ERR-C004">The value of the 'schemeID' attribute of the 'Identifier' MUST  be part of the code list 'EAS' (Electronic Address Scheme ) and use the prefix 'urn:cef.eu:names:identifier:EAS:[Code]' or  start with the following value 'urn:oasis:names:tc:ebcore:partyid-type:unregistered'</sch:assert>
      </sch:rule>
      <sch:rule context="query:QueryResponse/rim:Slot[@name='ErrorProvider']/rim:SlotValue/sdg:Agent/sdg:Address/sdg:AdminUnitLevel1">
         <!--{}[](CountryIdentificationCode-2.3)-->
         <sch:assert test="( false() or ( contains('AFALDZASADAOAIAQAGARAMAWAUATAZBSBHBDBBBYBEBZBJBMBTBOBQBABWBVBRIOBNBGBFBICVKHCMCAKYCFTDCLCNCXCCCOKMCDCGCKCRHRCUCWCYCZCIDKDJDMDOECEGSVGQEREESZETFKFOFJFIFRGFPFTFGAGMGEDEGHGIELGLGDGPGUGTGGGNGWGYHTHMVAHNHKHUISINIDIRIQIEIMILITJMJPJEJOKZKEKIKPKRKWKGLALVLBLSLRLYLILTLUMOMGMWMYMVMLMTMHMQMRMUYTMXFMMDMCMNMEMSMAMZMMNANRNPNLNCNZNINENGNUNFMKMPNOOMPKPWPSPAPGPYPEPHPNPLPTPRQARORURWREBLSHKNLCMFPMVCWSSMSTSASNRSSCSLSGSXSKSISBSOZAGSSSESLKSDSRSJSECHSYTWTJTZTHTLTGTKTOTTTNTRTMTCTVUGUAAEGBUMUSUYUZVUVEVNVGVIWFEHYEZMZWAXAFGALBDZAASMANDAGOAIAATAATGARGARMABWAUSAUTAZEBHSBHRBGDBRBBLRBELBLZBENBMUBTNBOLBESBIHBWABVTBRAIOTBRNBGRBFABDICPVKHMCMRCANCYMCAFTCDCHLCHNCXRCCKCOLCOMCODCOGCOKCRIHRVCUBCUWCYPCZECIVDNKDJIDMADOMECUEGYSLVGNQERIESTSWZETHFLKFROFJIFINFRAGUFPYFATFGABGMBGEODEUGHAGIBGRCGRLGRDGLPGUMGTMGGYGINGNBGUYHTIHMDVATHNDHKGHUNISLINDIDNIRNIRQIRLIMNISRITAJAMJPNJEYJORKAZKENKIRPRKKORKWTKGZLAOLVALBNLSOLBRLBYLIELTULUXMACMDGMWIMYSMDVMLIMLTMHLMTQMRTMUSMYTMEXFSMMDAMCOMNGMNEMSRMARMOZMMRNAMNRUNPLNLDNCLNZLNICNERNGANIUNFKMKDMNPNOROMNPAKPLWPSEPANPNGPRYPERPHLPCNPOLPRTPRIQATROURUSRWAREUBLMSHNKNALCAMAFSPMVCTWSMSMRSTPSAUSENSRBSYCSLESGPSXMSVKSVNSLBSOMZAFSGSSSDESPLKASDNSURSJMSWECHESYRTWNTJKTZATHATLSTGOTKLTONTTOTUNTURTKMTCATUVUGAUKRAREGBRUMIUSAURYUZBVUTVENVNMVGBVIRWLFESHYEMZMBZWEALA',concat('',.,'')) ) ) " id="R-EDM-ERR-C005">Value supplied '<value-of xmlns="http://purl.oclc.org/dsdl/schematron" select="."/>' is unacceptable for constraints identified by 'CountryIdentificationCode-2.3' in the context 'query:QueryResponse/rim:Slot[@name='ErrorProvider']/rim:SlotValue/sdg:Agent/sdg:Address/sdg:AdminUnitLevel1'</sch:assert>
      </sch:rule>        
      <sch:rule context="query:QueryResponse/rim:Slot[@name='ErrorProvider']/rim:SlotValue/sdg:Agent/sdg:Classification">
         <!--{}[](AgentClassification-CodeList)-->
         <sch:assert test="( false() or ( contains('IPEPERRP',concat('',.,'')) ) ) " id="R-EDM-ERR-C008">Value supplied '<value-of xmlns="http://purl.oclc.org/dsdl/schematron" select="."/>' is unacceptable for constraints identified by 'AgentClassification-CodeList' in the context 'query:QueryResponse/rim:Slot[@name='EvidenceProvider']/rim:SlotValue/sdg:Agent/sdg:Classification'.Default value: ERRP (Error Provider). The code 'ER' shall not be used by this transaction.</sch:assert>
      </sch:rule>  
      <sch:rule context="query:QueryResponse/rs:Exception/@xsi:type">
         <!--{}[](EDMExceptionCodes-CodeList)-->
         <sch:assert test="( false() or ( contains('&#x7f;rs:AuthenticationExceptionType&#x7f;rs:AuthorizationExceptionType&#x7f;rs:InvalidRequestExceptionType&#x7f;rs:ObjectNotFoundExceptionType&#x7f;rs:TimeoutExceptionType&#x7f;rs:UnresolvedReferenceExceptionType&#x7f;rs:UnsupportedCapabilityExceptionType&#x7f;query:QueryExceptionType&#x7f;',concat('&#x7f;',.,'&#x7f;')) ) ) " id="R-EDM-ERR-C013">Value supplied '<value-of xmlns="http://purl.oclc.org/dsdl/schematron" select="."/>' is unacceptable for constraints identified by 'EDMErrorCodes-CodeList' in the context 'query:QueryResponse/rs:Exception/@xsi:type'</sch:assert>
      </sch:rule>
      <sch:rule context="query:QueryResponse/rs:Exception/@code">
         <!--{}[](EDMErrorCodes-CodeList)-->
         <sch:assert test="( false() or ( contains('EDM:ERR:0001EDM:ERR:0002EDM:ERR:0003EDM:ERR:0004EDM:ERR:0005EDM:ERR:0006EDM:ERR:0007EDM:ERR:0008',concat('',.,'')) ) ) " id="R-EDM-ERR-C017">Value supplied '<value-of xmlns="http://purl.oclc.org/dsdl/schematron" select="."/>' is unacceptable for constraints identified by 'EDMErrorCodes-CodeList' in the context 'query:QueryResponse/rs:Exception/@code'</sch:assert>
      </sch:rule>
      <sch:rule context="query:QueryResponse/rs:Exception/@severity">
         <!--{}[](ErrorSeverity-CodeList)-->
         <sch:assert test="( false() or ( contains('urn:oasis:names:tc:ebxml-regrep:ErrorSeverityType:Errorurn:sr.oots.tech.europa.eu:codes:ErrorSeverity:EDMErrorResponse:PreviewRequired',concat('',.,'')) ) ) " id="R-EDM-ERR-C014">The 'severity' attribute of a 'rs:Exception' MUST be present. It must be part of the code list 'ErrorSeverity' (Error Severity). The code 'urn:sr.oots.tech.europa.eu:codes:ErrorSeverity:DSDErrorResponse:AdditionalInput' shall not be used by this transaction.</sch:assert>
      </sch:rule>
      <sch:rule context="query:QueryResponse/rs:Exception/rim:Slot[@name='PreviewDescription']/rim:SlotValue/rim:Value/rim:LocalizedString/@*[namespace-uri()='http://www.w3.org/XML/1998/namespace' and local-name()='lang']">
         <!--{}[](LanguageCode-2.3)-->
         <sch:assert test="( false() or ( contains('AAAARABABKACEACHADAADYAEAFAFAAFHAFRAINAKAKAAKKALB (B) SQI (T)ALB (B) SQI (T)ALEALGALTAMAMHANANGANPAPAARARAARCARGARM (B) HYE (T)ARM (B) HYE (T)ARNARPARTARWASASMASTATHAUSAVAVAAVEAWAAYAYMAZAZEBABADBAIBAKBALBAMBANBAQ (B) EUS (T)BAQ (B) EUS (T)BASBATBEBEJBELBEMBENBERBGBHBHOBIBIHBIKBINBISBLABMBNBNTBOBOBOSBRBRABREBSBTKBUABUGBULBUR (B) MYA (T)BUR (B) MYA (T)BYNCACADCAICARCATCAUCECEBCELCHCHACHBCHECHGCHI (B) ZHO (T)CHI (B) ZHO (T)CHKCHMCHNCHOCHPCHRCHUCHVCHYCMCCNRCOCOPCORCOSCPECPFCPPCRCRECRHCRPCSCSCSBCUCUSCVCYCYCZE (B) CES (T)CZE (B) CES (T)DADAKDANDARDAYDEDEDELDENDGRDINDIVDOIDRADSBDUADUMDUT (B) NLD (T)DUT (B) NLD (T)DVDYUDZDZOEEEFIEGYEKAELELELXENENGENMEOEPOESESTETEUEUEWEEWOFAFAFANFAOFATFFFIFIJFILFINFIUFJFOFONFRFRFRE (B) FRA (T)FRE (B) FRA (T)FRMFROFRRFRSFRYFULFURFYGAGAAGAYGBAGDGEMGEO (B) KAT (T)GEO (B) KAT (T)GER (B) DEU (T)GER (B) DEU (T)GEZGILGLGLAGLEGLGGLVGMHGNGOHGONGORGOTGRBGRCGRE (B) ELL (T)GRE (B) ELL (T)GRNGSWGUGUJGVGWIHAHAIHATHAUHAWHEHEBHERHIHILHIMHINHITHMNHMOHOHRHRVHSBHTHUHUNHUPHYHYHZIAIBAIBOICE (B) ISL (T)ICE (B) ISL (T)IDIDOIEIGIIIIIIJOIKIKUILEILOINAINCINDINEINHIOIPKIRAIROISISITITAIUJAJAVJBOJPNJPRJRBJVKAKAKAAKABKACKALKAMKANKARKASKAUKAWKAZKBDKGKHAKHIKHMKHOKIKIKKINKIRKJKKKLKMKMBKNKOKOKKOMKONKORKOSKPEKRKRCKRLKROKRUKSKUKUAKUMKURKUTKVKWKYLALADLAHLAMLAOLATLAVLBLEZLGLILIMLINLITLNLOLOLLOZLTLTZLULUALUBLUGLUILUNLUOLUSLVMAC (B) MKD (T)MAC (B) MKD (T)MADMAGMAHMAIMAKMALMANMAO (B) MRI (T)MAO (B) MRI (T)MAPMARMASMAY (B) MSA (T)MAY (B) MSA (T)MDFMDRMENMGMGAMHMIMIMICMINMISMKMKMKHMLMLGMLTMNMNCMNIMNOMOHMONMOSMRMSMSMTMULMUNMUSMWLMWRMYMYMYNMYVNANAHNAINAPNAUNAVNBNBLNDNDENDONDSNENEPNEWNGNIANICNIUNLNLNNNNONONOBNOGNONNORNQONRNSONUBNVNWCNYNYANYMNYNNYONZIOCOCIOJOJIOMORORIORMOSOSAOSSOTAOTOPAPAAPAGPALPAMPANPAPPAUPEOPER (B) FAS (T)PER (B) FAS (T)PHIPHNPIPLPLIPOLPONPORPRAPROPSPTPUSQAA-QTZQUQUERAJRAPRARRMRNROROROAROHROMRURUM (B) RON (T)RUM (B) RON (T)RUNRUPRUSRWSASADSAGSAHSAISALSAMSANSASSATSCSCNSCOSDSESELSEMSGSGASGNSHNSISIDSINSIOSITSKSKSLSLASLO (B) SLK (T)SLO (B) SLK (T)SLVSMSMASMESMISMJSMNSMOSMSSNSNASNDSNKSOSOGSOMSONSOTSPASQSQSRSRDSRNSRPSRRSSSSASSWSTSUSUKSUNSUSSUXSVSWSWASWESYCSYRTATAHTAITAMTATTETELTEMTERTETTGTGKTGLTHTHATITIB (B) BOD (T)TIB (B) BOD (T)TIGTIRTIVTKTKLTLTLHTLITMHTNTOTOGTONTPITRTSTSITSNTSOTTTUKTUMTUPTURTUTTVLTWTWITYTYVUDMUGUGAUIGUKUKRUMBUNDURURDUZUZBVAIVEVENVIVIEVOVOLVOTWAWAKWALWARWASWEL (B) CYM (T)WEL (B) CYM (T)WENWLNWOWOLXALXHXHOYAOYAPYIYIDYOYORYPKZAZAPZBLZENZGHZHZHZHAZNDZUZULZUNZXXZZA',concat('',.,'')) ) ) " id="R-EDM-ERR-C020">Value supplied '<value-of xmlns="http://purl.oclc.org/dsdl/schematron" select="."/>' is unacceptable for constraints identified by 'LanguageCode-2.3' in the context 'query:QueryResponse/rs:Exception/rim:Slot[@name='PreviewDescription']/rim:SlotValue/rim:Value/rim:LocalizedString/@*[namespace-uri()='http://www.w3.org/XML/1998/namespace' and local-name()='lang']'</sch:assert>
      </sch:rule>
   </sch:pattern>
</sch:schema>   
