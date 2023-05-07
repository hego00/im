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
      <sch:rule context="query:QueryResponse/rs:Exception/rim:Slot[@name='JurisdictionDetermination']/rim:SlotValue/sdg:EvidenceProviderJurisdictionDetermination/sdg:JurisdictionContextId">
         <sch:assert test="matches(normalize-space((.)),'[a-f0-9]{8}-[a-f0-9]{4}-[a-f0-9]{4}-[a-f0-9]{4}-[a-f0-9]{12}$','i')" id="R-DSD-ERR-C001"
            >The value of 'JurisdictionContextId' of MUST be unique UUID (RFC 4122).</sch:assert>
      </sch:rule>
   </sch:pattern> 
   
   <sch:pattern>        
      <sch:rule context="query:QueryResponse/rs:Exception/rim:Slot[@name='JurisdictionDetermination']/rim:SlotValue/sdg:EvidenceProviderJurisdictionDetermination/sdg:JurisdictionContext">
         <sch:assert test="not(normalize-space(@lang)='')" id="R-DSD-ERR-C003"
            >The value of 'lang' attribute MUST be be provided. Default value: 'EN'.</sch:assert>         
      </sch:rule>
   </sch:pattern>
   
   <sch:pattern> 
      <sch:rule context="query:QueryResponse/rs:Exception/rim:Slot[@name='UserRequestedClassificationConcepts']/rim:SlotValue/sdg:EvidenceProviderClassification/sdg:Identifier">
         <sch:assert test="matches(normalize-space((.)),'[a-f0-9]{8}-[a-f0-9]{4}-[a-f0-9]{4}-[a-f0-9]{4}-[a-f0-9]{12}$','i')" id="R-DSD-ERR-C005"
            >The value of 'Identifier' of MUST be unique UUID (RFC 4122).</sch:assert>
      </sch:rule>
   </sch:pattern> 
   
   <sch:pattern>
      <sch:rule context="query:QueryResponse/rs:Exception/rim:Slot[@name='UserRequestedClassificationConcepts']/rim:SlotValue/sdg:EvidenceProviderClassification">
         <sch:assert test="not(normalize-space(sdg:Type)='')" id="R-DSD-ERR-C006"
            >A 'Type' MUST be provided. </sch:assert>         
      </sch:rule>
   </sch:pattern>
   
   <sch:pattern>
      <sch:rule context="query:QueryResponse/rs:Exception/rim:Slot[@name='UserRequestedClassificationConcepts']/rim:SlotValue/sdg:EvidenceProviderClassification">
         <sch:assert test="not(normalize-space(sdg:Description)='')" id="R-DSD-ERR-C007"
            >A 'Description' MUST be provided. </sch:assert>         
      </sch:rule>
   </sch:pattern>
   
   <sch:pattern>        
      <sch:rule context="query:QueryResponse/rs:Exception/rim:Slot[@name='UserRequestedClassificationConcepts']/rim:SlotValue/sdg:EvidenceProviderClassification/sdg:Description">
         <sch:assert test="not(normalize-space(@lang)='')" id="R-DSD-ERR-C009"
            >The value of 'lang' attribute MUST be be provided. Default value: 'EN'.</sch:assert>         
      </sch:rule>
   </sch:pattern>
   
   <sch:pattern> 
      <sch:rule context="query:QueryResponse/rs:Exception/rim:Slot[@name='DataServiceEvidenceType']/rim:SlotValue/sdg:DataServiceEvidenceType/sdg:Identifier">
         <sch:assert test="matches(normalize-space((.)),'[a-f0-9]{8}-[a-f0-9]{4}-[a-f0-9]{4}-[a-f0-9]{4}-[a-f0-9]{12}$','i')" id="R-DSD-ERR-C010"
            >The value of 'Identifier' of an 'DataServiceEvidenceType' MUST be unique UUID (RFC 4122).</sch:assert>
      </sch:rule>
   </sch:pattern> 
   
   <sch:pattern>
      <sch:rule context="query:QueryResponse/rs:Exception/rim:Slot[@name='DataServiceEvidenceType']/rim:SlotValue/sdg:DataServiceEvidenceType/sdg:EvidenceTypeClassification">
         <sch:assert test="matches(normalize-space((.)),'https://sr.oots.tech.europa.eu/evidencetypeclassifications/[a-z]{2}/[a-f0-9]{8}-[a-f0-9]{4}-[a-f0-9]{4}-[a-f0-9]{4}-[a-f0-9]{12}$','i')" id="R-DSD-ERR-C011"
            >The value of 'EvidenceTypeClassification' of a 'DataServiceEvidenceType' MUST be a UUID of the Evidence Broker and inlude a code of the code list 'CountryIdentificationCode' 
            (ISO 3166-1' alpha-2 codes) using the prefix and scheme ''https://sr.oots.tech.europa.eu/evidencetypeclassifications/[CountryIdentificationCode]/[UUID]'' 
            pointing to the Semantic Repository. </sch:assert>         
      </sch:rule>
   </sch:pattern>
   
   <sch:pattern>        
      <sch:rule context="query:QueryResponse/rs:Exception/rim:Slot[@name='DataServiceEvidenceType']/rim:SlotValue/sdg:DataServiceEvidenceType/sdg:Title">
         <sch:assert test="not(normalize-space(@lang)='')" id="R-DSD-ERR-C013"
            >The value of 'lang' attribute MUST be be provided. Default value: 'EN'.</sch:assert>         
      </sch:rule>
   </sch:pattern>
   
   <sch:pattern>        
      <sch:rule context="query:QueryResponse/rs:Exception/rim:Slot[@name='DataServiceEvidenceType']/rim:SlotValue/sdg:DataServiceEvidenceType/sdg:Description">
         <sch:assert test="not(normalize-space(@lang)='')" id="R-DSD-ERR-C015"
            >The value of 'lang' attribute MUST be be provided. Default value: 'EN'.</sch:assert>         
      </sch:rule>
   </sch:pattern>
     
   <sch:pattern>
      <sch:rule context="query:QueryResponse/rs:Exception">
         <sch:assert test="@xsi:type" id="R-DSD-ERR-C016"
            >The 'xsi:type' attribute of a 'rs:Exception' MUST be present. </sch:assert>         
      </sch:rule>
   </sch:pattern>
   
   <sch:pattern>
      <sch:rule context="query:QueryResponse/rs:Exception[@code='DSD:ERR:0005']">
         <sch:assert test="not(matches(@severity,'urn:oasis:names:tc:ebxml-regrep:ErrorSeverityType:Error'))" id="R-DSD-ERR-C019"
            >The value of 'severity' attribute of a 'rs:Exception' MUST  be 'urn:oasis:names:tc:ebxml-regrep:ErrorSeverityType:Error' if the rs:Exception 
            xsi:type='rs:ObjectNotFoundExceptionType' (@code 'DSD:ERR:0005') is NOT used.</sch:assert>         
      </sch:rule>
   </sch:pattern>
   
   <sch:pattern>
      <sch:rule context="query:QueryResponse/rs:Exception">
         <sch:assert test="@message" id="R-DSD-ERR-C020"
            >The 'message' attribute of a 'rs:Exception' MUST be present. </sch:assert>         
      </sch:rule>
   </sch:pattern>
   
   <sch:pattern>
      <sch:rule context="query:QueryResponse/rs:Exception">
         <sch:assert test="@code" id="R-DSD-ERR-C021"
            >The 'code' attribute of a 'rs:Exception' MUST be present. </sch:assert>         
      </sch:rule>
   </sch:pattern>
   
   <sch:pattern>
      <sch:rule context="query:QueryResponse/rs:Exception[@code='DSD:ERR:0005']">
         <sch:assert test="matches(@severity,'urn:sr.oots.tech.europa.eu:codes:ErrorSeverity:DSDErrorResponse:AdditionalInput')" id="R-DSD-ERR-C025"
            >The value of 'severity' attribute of a 'rs:Exception' MUST  be 'urn:sr.oots.tech.europa.eu:codes:ErrorSeverity:DSDErrorResponse:AdditionalInput' 
            if the rs:Exception xsi:type='rs:ObjectNotFoundExceptionType' (@code 'DSD:ERR:0005') is used. </sch:assert>         
      </sch:rule>
   </sch:pattern>
   
   <sch:pattern>   
      <sch:rule context="query:QueryResponse/rs:Exception/rim:Slot[@name='JurisdictionDetermination']/rim:SlotValue/sdg:EvidenceProviderJurisdictionDetermination/sdg:JurisdictionContext/@lang">
         <!--{}[](LanguageCode-2.3)-->
         <sch:assert test="( false() or ( contains('AAAARABABKACEACHADAADYAEAFAFAAFHAFRAINAKAKAAKKALB (B) SQI (T)ALB (B) SQI (T)ALEALGALTAMAMHANANGANPAPAARARAARCARGARM (B) HYE (T)ARM (B) HYE (T)ARNARPARTARWASASMASTATHAUSAVAVAAVEAWAAYAYMAZAZEBABADBAIBAKBALBAMBANBAQ (B) EUS (T)BAQ (B) EUS (T)BASBATBEBEJBELBEMBENBERBGBHBHOBIBIHBIKBINBISBLABMBNBNTBOBOBOSBRBRABREBSBTKBUABUGBULBUR (B) MYA (T)BUR (B) MYA (T)BYNCACADCAICARCATCAUCECEBCELCHCHACHBCHECHGCHI (B) ZHO (T)CHI (B) ZHO (T)CHKCHMCHNCHOCHPCHRCHUCHVCHYCMCCNRCOCOPCORCOSCPECPFCPPCRCRECRHCRPCSCSCSBCUCUSCVCYCYCZE (B) CES (T)CZE (B) CES (T)DADAKDANDARDAYDEDEDELDENDGRDINDIVDOIDRADSBDUADUMDUT (B) NLD (T)DUT (B) NLD (T)DVDYUDZDZOEEEFIEGYEKAELELELXENENGENMEOEPOESESTETEUEUEWEEWOFAFAFANFAOFATFFFIFIJFILFINFIUFJFOFONFRFRFRE (B) FRA (T)FRE (B) FRA (T)FRMFROFRRFRSFRYFULFURFYGAGAAGAYGBAGDGEMGEO (B) KAT (T)GEO (B) KAT (T)GER (B) DEU (T)GER (B) DEU (T)GEZGILGLGLAGLEGLGGLVGMHGNGOHGONGORGOTGRBGRCGRE (B) ELL (T)GRE (B) ELL (T)GRNGSWGUGUJGVGWIHAHAIHATHAUHAWHEHEBHERHIHILHIMHINHITHMNHMOHOHRHRVHSBHTHUHUNHUPHYHYHZIAIBAIBOICE (B) ISL (T)ICE (B) ISL (T)IDIDOIEIGIIIIIIJOIKIKUILEILOINAINCINDINEINHIOIPKIRAIROISISITITAIUJAJAVJBOJPNJPRJRBJVKAKAKAAKABKACKALKAMKANKARKASKAUKAWKAZKBDKGKHAKHIKHMKHOKIKIKKINKIRKJKKKLKMKMBKNKOKOKKOMKONKORKOSKPEKRKRCKRLKROKRUKSKUKUAKUMKURKUTKVKWKYLALADLAHLAMLAOLATLAVLBLEZLGLILIMLINLITLNLOLOLLOZLTLTZLULUALUBLUGLUILUNLUOLUSLVMAC (B) MKD (T)MAC (B) MKD (T)MADMAGMAHMAIMAKMALMANMAO (B) MRI (T)MAO (B) MRI (T)MAPMARMASMAY (B) MSA (T)MAY (B) MSA (T)MDFMDRMENMGMGAMHMIMIMICMINMISMKMKMKHMLMLGMLTMNMNCMNIMNOMOHMONMOSMRMSMSMTMULMUNMUSMWLMWRMYMYMYNMYVNANAHNAINAPNAUNAVNBNBLNDNDENDONDSNENEPNEWNGNIANICNIUNLNLNNNNONONOBNOGNONNORNQONRNSONUBNVNWCNYNYANYMNYNNYONZIOCOCIOJOJIOMORORIORMOSOSAOSSOTAOTOPAPAAPAGPALPAMPANPAPPAUPEOPER (B) FAS (T)PER (B) FAS (T)PHIPHNPIPLPLIPOLPONPORPRAPROPSPTPUSQAA-QTZQUQUERAJRAPRARRMRNROROROAROHROMRURUM (B) RON (T)RUM (B) RON (T)RUNRUPRUSRWSASADSAGSAHSAISALSAMSANSASSATSCSCNSCOSDSESELSEMSGSGASGNSHNSISIDSINSIOSITSKSKSLSLASLO (B) SLK (T)SLO (B) SLK (T)SLVSMSMASMESMISMJSMNSMOSMSSNSNASNDSNKSOSOGSOMSONSOTSPASQSQSRSRDSRNSRPSRRSSSSASSWSTSUSUKSUNSUSSUXSVSWSWASWESYCSYRTATAHTAITAMTATTETELTEMTERTETTGTGKTGLTHTHATITIB (B) BOD (T)TIB (B) BOD (T)TIGTIRTIVTKTKLTLTLHTLITMHTNTOTOGTONTPITRTSTSITSNTSOTTTUKTUMTUPTURTUTTVLTWTWITYTYVUDMUGUGAUIGUKUKRUMBUNDURURDUZUZBVAIVEVENVIVIEVOVOLVOTWAWAKWALWARWASWEL (B) CYM (T)WEL (B) CYM (T)WENWLNWOWOLXALXHXHOYAOYAPYIYIDYOYORYPKZAZAPZBLZENZGHZHZHZHAZNDZUZULZUNZXXZZA',concat('',.,'')) ) ) " id="R-DSD-ERR-C002">Value supplied '<value-of xmlns="http://purl.oclc.org/dsdl/schematron" select="."/>' is unacceptable for constraints identified by 'LanguageCode-2.3' in the context 'query:QueryResponse/rs:Exception/rim:Slot[@name='JurisdictionDetermination']/rim:SlotValue/sdg:EvidenceProviderJurisdictionDetermination/sdg:JurisdictionContext/@lang'</sch:assert>
      </sch:rule>
      <sch:rule context="query:QueryResponse/rs:Exception/rim:Slot[@name='UserRequestedClassificationConcepts']/rim:SlotValue/sdg:EvidenceProviderClassification/sdg:Description/@lang">
         <!--{}[](LanguageCode-2.3)-->
         <sch:assert test="( false() or ( contains('AAAARABABKACEACHADAADYAEAFAFAAFHAFRAINAKAKAAKKALB (B) SQI (T)ALB (B) SQI (T)ALEALGALTAMAMHANANGANPAPAARARAARCARGARM (B) HYE (T)ARM (B) HYE (T)ARNARPARTARWASASMASTATHAUSAVAVAAVEAWAAYAYMAZAZEBABADBAIBAKBALBAMBANBAQ (B) EUS (T)BAQ (B) EUS (T)BASBATBEBEJBELBEMBENBERBGBHBHOBIBIHBIKBINBISBLABMBNBNTBOBOBOSBRBRABREBSBTKBUABUGBULBUR (B) MYA (T)BUR (B) MYA (T)BYNCACADCAICARCATCAUCECEBCELCHCHACHBCHECHGCHI (B) ZHO (T)CHI (B) ZHO (T)CHKCHMCHNCHOCHPCHRCHUCHVCHYCMCCNRCOCOPCORCOSCPECPFCPPCRCRECRHCRPCSCSCSBCUCUSCVCYCYCZE (B) CES (T)CZE (B) CES (T)DADAKDANDARDAYDEDEDELDENDGRDINDIVDOIDRADSBDUADUMDUT (B) NLD (T)DUT (B) NLD (T)DVDYUDZDZOEEEFIEGYEKAELELELXENENGENMEOEPOESESTETEUEUEWEEWOFAFAFANFAOFATFFFIFIJFILFINFIUFJFOFONFRFRFRE (B) FRA (T)FRE (B) FRA (T)FRMFROFRRFRSFRYFULFURFYGAGAAGAYGBAGDGEMGEO (B) KAT (T)GEO (B) KAT (T)GER (B) DEU (T)GER (B) DEU (T)GEZGILGLGLAGLEGLGGLVGMHGNGOHGONGORGOTGRBGRCGRE (B) ELL (T)GRE (B) ELL (T)GRNGSWGUGUJGVGWIHAHAIHATHAUHAWHEHEBHERHIHILHIMHINHITHMNHMOHOHRHRVHSBHTHUHUNHUPHYHYHZIAIBAIBOICE (B) ISL (T)ICE (B) ISL (T)IDIDOIEIGIIIIIIJOIKIKUILEILOINAINCINDINEINHIOIPKIRAIROISISITITAIUJAJAVJBOJPNJPRJRBJVKAKAKAAKABKACKALKAMKANKARKASKAUKAWKAZKBDKGKHAKHIKHMKHOKIKIKKINKIRKJKKKLKMKMBKNKOKOKKOMKONKORKOSKPEKRKRCKRLKROKRUKSKUKUAKUMKURKUTKVKWKYLALADLAHLAMLAOLATLAVLBLEZLGLILIMLINLITLNLOLOLLOZLTLTZLULUALUBLUGLUILUNLUOLUSLVMAC (B) MKD (T)MAC (B) MKD (T)MADMAGMAHMAIMAKMALMANMAO (B) MRI (T)MAO (B) MRI (T)MAPMARMASMAY (B) MSA (T)MAY (B) MSA (T)MDFMDRMENMGMGAMHMIMIMICMINMISMKMKMKHMLMLGMLTMNMNCMNIMNOMOHMONMOSMRMSMSMTMULMUNMUSMWLMWRMYMYMYNMYVNANAHNAINAPNAUNAVNBNBLNDNDENDONDSNENEPNEWNGNIANICNIUNLNLNNNNONONOBNOGNONNORNQONRNSONUBNVNWCNYNYANYMNYNNYONZIOCOCIOJOJIOMORORIORMOSOSAOSSOTAOTOPAPAAPAGPALPAMPANPAPPAUPEOPER (B) FAS (T)PER (B) FAS (T)PHIPHNPIPLPLIPOLPONPORPRAPROPSPTPUSQAA-QTZQUQUERAJRAPRARRMRNROROROAROHROMRURUM (B) RON (T)RUM (B) RON (T)RUNRUPRUSRWSASADSAGSAHSAISALSAMSANSASSATSCSCNSCOSDSESELSEMSGSGASGNSHNSISIDSINSIOSITSKSKSLSLASLO (B) SLK (T)SLO (B) SLK (T)SLVSMSMASMESMISMJSMNSMOSMSSNSNASNDSNKSOSOGSOMSONSOTSPASQSQSRSRDSRNSRPSRRSSSSASSWSTSUSUKSUNSUSSUXSVSWSWASWESYCSYRTATAHTAITAMTATTETELTEMTERTETTGTGKTGLTHTHATITIB (B) BOD (T)TIB (B) BOD (T)TIGTIRTIVTKTKLTLTLHTLITMHTNTOTOGTONTPITRTSTSITSNTSOTTTUKTUMTUPTURTUTTVLTWTWITYTYVUDMUGUGAUIGUKUKRUMBUNDURURDUZUZBVAIVEVENVIVIEVOVOLVOTWAWAKWALWARWASWEL (B) CYM (T)WEL (B) CYM (T)WENWLNWOWOLXALXHXHOYAOYAPYIYIDYOYORYPKZAZAPZBLZENZGHZHZHZHAZNDZUZULZUNZXXZZA',concat('',.,'')) ) ) " id="R-DSD-ERR-C008">Value supplied '<value-of xmlns="http://purl.oclc.org/dsdl/schematron" select="."/>' is unacceptable for constraints identified by 'LanguageCode-2.3' in the context 'query:QueryResponse/rs:Exception/rim:Slot[@name='UserRequestedClassificationConcepts']/rim:SlotValue/sdg:EvidenceProviderClassification/sdg:Description/@lang'</sch:assert>
      </sch:rule>
      <sch:rule context="query:QueryResponse/rs:Exception/rim:Slot[@name='DataServiceEvidenceType']/rim:SlotValue/sdg:DataServiceEvidenceType/sdg:Title/@lang">
         <!--{}[](LanguageCode-2.3)-->
         <sch:assert test="( false() or ( contains('AAAARABABKACEACHADAADYAEAFAFAAFHAFRAINAKAKAAKKALB (B) SQI (T)ALB (B) SQI (T)ALEALGALTAMAMHANANGANPAPAARARAARCARGARM (B) HYE (T)ARM (B) HYE (T)ARNARPARTARWASASMASTATHAUSAVAVAAVEAWAAYAYMAZAZEBABADBAIBAKBALBAMBANBAQ (B) EUS (T)BAQ (B) EUS (T)BASBATBEBEJBELBEMBENBERBGBHBHOBIBIHBIKBINBISBLABMBNBNTBOBOBOSBRBRABREBSBTKBUABUGBULBUR (B) MYA (T)BUR (B) MYA (T)BYNCACADCAICARCATCAUCECEBCELCHCHACHBCHECHGCHI (B) ZHO (T)CHI (B) ZHO (T)CHKCHMCHNCHOCHPCHRCHUCHVCHYCMCCNRCOCOPCORCOSCPECPFCPPCRCRECRHCRPCSCSCSBCUCUSCVCYCYCZE (B) CES (T)CZE (B) CES (T)DADAKDANDARDAYDEDEDELDENDGRDINDIVDOIDRADSBDUADUMDUT (B) NLD (T)DUT (B) NLD (T)DVDYUDZDZOEEEFIEGYEKAELELELXENENGENMEOEPOESESTETEUEUEWEEWOFAFAFANFAOFATFFFIFIJFILFINFIUFJFOFONFRFRFRE (B) FRA (T)FRE (B) FRA (T)FRMFROFRRFRSFRYFULFURFYGAGAAGAYGBAGDGEMGEO (B) KAT (T)GEO (B) KAT (T)GER (B) DEU (T)GER (B) DEU (T)GEZGILGLGLAGLEGLGGLVGMHGNGOHGONGORGOTGRBGRCGRE (B) ELL (T)GRE (B) ELL (T)GRNGSWGUGUJGVGWIHAHAIHATHAUHAWHEHEBHERHIHILHIMHINHITHMNHMOHOHRHRVHSBHTHUHUNHUPHYHYHZIAIBAIBOICE (B) ISL (T)ICE (B) ISL (T)IDIDOIEIGIIIIIIJOIKIKUILEILOINAINCINDINEINHIOIPKIRAIROISISITITAIUJAJAVJBOJPNJPRJRBJVKAKAKAAKABKACKALKAMKANKARKASKAUKAWKAZKBDKGKHAKHIKHMKHOKIKIKKINKIRKJKKKLKMKMBKNKOKOKKOMKONKORKOSKPEKRKRCKRLKROKRUKSKUKUAKUMKURKUTKVKWKYLALADLAHLAMLAOLATLAVLBLEZLGLILIMLINLITLNLOLOLLOZLTLTZLULUALUBLUGLUILUNLUOLUSLVMAC (B) MKD (T)MAC (B) MKD (T)MADMAGMAHMAIMAKMALMANMAO (B) MRI (T)MAO (B) MRI (T)MAPMARMASMAY (B) MSA (T)MAY (B) MSA (T)MDFMDRMENMGMGAMHMIMIMICMINMISMKMKMKHMLMLGMLTMNMNCMNIMNOMOHMONMOSMRMSMSMTMULMUNMUSMWLMWRMYMYMYNMYVNANAHNAINAPNAUNAVNBNBLNDNDENDONDSNENEPNEWNGNIANICNIUNLNLNNNNONONOBNOGNONNORNQONRNSONUBNVNWCNYNYANYMNYNNYONZIOCOCIOJOJIOMORORIORMOSOSAOSSOTAOTOPAPAAPAGPALPAMPANPAPPAUPEOPER (B) FAS (T)PER (B) FAS (T)PHIPHNPIPLPLIPOLPONPORPRAPROPSPTPUSQAA-QTZQUQUERAJRAPRARRMRNROROROAROHROMRURUM (B) RON (T)RUM (B) RON (T)RUNRUPRUSRWSASADSAGSAHSAISALSAMSANSASSATSCSCNSCOSDSESELSEMSGSGASGNSHNSISIDSINSIOSITSKSKSLSLASLO (B) SLK (T)SLO (B) SLK (T)SLVSMSMASMESMISMJSMNSMOSMSSNSNASNDSNKSOSOGSOMSONSOTSPASQSQSRSRDSRNSRPSRRSSSSASSWSTSUSUKSUNSUSSUXSVSWSWASWESYCSYRTATAHTAITAMTATTETELTEMTERTETTGTGKTGLTHTHATITIB (B) BOD (T)TIB (B) BOD (T)TIGTIRTIVTKTKLTLTLHTLITMHTNTOTOGTONTPITRTSTSITSNTSOTTTUKTUMTUPTURTUTTVLTWTWITYTYVUDMUGUGAUIGUKUKRUMBUNDURURDUZUZBVAIVEVENVIVIEVOVOLVOTWAWAKWALWARWASWEL (B) CYM (T)WEL (B) CYM (T)WENWLNWOWOLXALXHXHOYAOYAPYIYIDYOYORYPKZAZAPZBLZENZGHZHZHZHAZNDZUZULZUNZXXZZA',concat('',.,'')) ) ) " id="R-DSD-ERR-C012">Value supplied '<value-of xmlns="http://purl.oclc.org/dsdl/schematron" select="."/>' is unacceptable for constraints identified by 'LanguageCode-2.3' in the context 'query:QueryResponse/rs:Exception/rim:Slot[@name='DataServiceEvidenceType']/rim:SlotValue/sdg:DataServiceEvidenceType/sdg:Title/@lang'</sch:assert>
      </sch:rule>    
      <sch:rule context="query:QueryResponse/rs:Exception/rim:Slot[@name='DataServiceEvidenceType']/rim:SlotValue/sdg:DataServiceEvidenceType/sdg:Description/@lang">
         <!--{}[](LanguageCode-2.3)-->
         <sch:assert test="( false() or ( contains('AAAARABABKACEACHADAADYAEAFAFAAFHAFRAINAKAKAAKKALB (B) SQI (T)ALB (B) SQI (T)ALEALGALTAMAMHANANGANPAPAARARAARCARGARM (B) HYE (T)ARM (B) HYE (T)ARNARPARTARWASASMASTATHAUSAVAVAAVEAWAAYAYMAZAZEBABADBAIBAKBALBAMBANBAQ (B) EUS (T)BAQ (B) EUS (T)BASBATBEBEJBELBEMBENBERBGBHBHOBIBIHBIKBINBISBLABMBNBNTBOBOBOSBRBRABREBSBTKBUABUGBULBUR (B) MYA (T)BUR (B) MYA (T)BYNCACADCAICARCATCAUCECEBCELCHCHACHBCHECHGCHI (B) ZHO (T)CHI (B) ZHO (T)CHKCHMCHNCHOCHPCHRCHUCHVCHYCMCCNRCOCOPCORCOSCPECPFCPPCRCRECRHCRPCSCSCSBCUCUSCVCYCYCZE (B) CES (T)CZE (B) CES (T)DADAKDANDARDAYDEDEDELDENDGRDINDIVDOIDRADSBDUADUMDUT (B) NLD (T)DUT (B) NLD (T)DVDYUDZDZOEEEFIEGYEKAELELELXENENGENMEOEPOESESTETEUEUEWEEWOFAFAFANFAOFATFFFIFIJFILFINFIUFJFOFONFRFRFRE (B) FRA (T)FRE (B) FRA (T)FRMFROFRRFRSFRYFULFURFYGAGAAGAYGBAGDGEMGEO (B) KAT (T)GEO (B) KAT (T)GER (B) DEU (T)GER (B) DEU (T)GEZGILGLGLAGLEGLGGLVGMHGNGOHGONGORGOTGRBGRCGRE (B) ELL (T)GRE (B) ELL (T)GRNGSWGUGUJGVGWIHAHAIHATHAUHAWHEHEBHERHIHILHIMHINHITHMNHMOHOHRHRVHSBHTHUHUNHUPHYHYHZIAIBAIBOICE (B) ISL (T)ICE (B) ISL (T)IDIDOIEIGIIIIIIJOIKIKUILEILOINAINCINDINEINHIOIPKIRAIROISISITITAIUJAJAVJBOJPNJPRJRBJVKAKAKAAKABKACKALKAMKANKARKASKAUKAWKAZKBDKGKHAKHIKHMKHOKIKIKKINKIRKJKKKLKMKMBKNKOKOKKOMKONKORKOSKPEKRKRCKRLKROKRUKSKUKUAKUMKURKUTKVKWKYLALADLAHLAMLAOLATLAVLBLEZLGLILIMLINLITLNLOLOLLOZLTLTZLULUALUBLUGLUILUNLUOLUSLVMAC (B) MKD (T)MAC (B) MKD (T)MADMAGMAHMAIMAKMALMANMAO (B) MRI (T)MAO (B) MRI (T)MAPMARMASMAY (B) MSA (T)MAY (B) MSA (T)MDFMDRMENMGMGAMHMIMIMICMINMISMKMKMKHMLMLGMLTMNMNCMNIMNOMOHMONMOSMRMSMSMTMULMUNMUSMWLMWRMYMYMYNMYVNANAHNAINAPNAUNAVNBNBLNDNDENDONDSNENEPNEWNGNIANICNIUNLNLNNNNONONOBNOGNONNORNQONRNSONUBNVNWCNYNYANYMNYNNYONZIOCOCIOJOJIOMORORIORMOSOSAOSSOTAOTOPAPAAPAGPALPAMPANPAPPAUPEOPER (B) FAS (T)PER (B) FAS (T)PHIPHNPIPLPLIPOLPONPORPRAPROPSPTPUSQAA-QTZQUQUERAJRAPRARRMRNROROROAROHROMRURUM (B) RON (T)RUM (B) RON (T)RUNRUPRUSRWSASADSAGSAHSAISALSAMSANSASSATSCSCNSCOSDSESELSEMSGSGASGNSHNSISIDSINSIOSITSKSKSLSLASLO (B) SLK (T)SLO (B) SLK (T)SLVSMSMASMESMISMJSMNSMOSMSSNSNASNDSNKSOSOGSOMSONSOTSPASQSQSRSRDSRNSRPSRRSSSSASSWSTSUSUKSUNSUSSUXSVSWSWASWESYCSYRTATAHTAITAMTATTETELTEMTERTETTGTGKTGLTHTHATITIB (B) BOD (T)TIB (B) BOD (T)TIGTIRTIVTKTKLTLTLHTLITMHTNTOTOGTONTPITRTSTSITSNTSOTTTUKTUMTUPTURTUTTVLTWTWITYTYVUDMUGUGAUIGUKUKRUMBUNDURURDUZUZBVAIVEVENVIVIEVOVOLVOTWAWAKWALWARWASWEL (B) CYM (T)WEL (B) CYM (T)WENWLNWOWOLXALXHXHOYAOYAPYIYIDYOYORYPKZAZAPZBLZENZGHZHZHZHAZNDZUZULZUNZXXZZA',concat('',.,'')) ) ) " id="R-DSD-ERR-C014">Value supplied '<value-of xmlns="http://purl.oclc.org/dsdl/schematron" select="."/>' is unacceptable for constraints identified by 'LanguageCode-2.3' in the context 'query:QueryResponse/rs:Exception/rim:Slot[@name='DataServiceEvidenceType']/rim:SlotValue/sdg:DataServiceEvidenceType/sdg:Description/@lang'</sch:assert>
      </sch:rule>
      <sch:rule context="query:QueryResponse/rs:Exception/rim:Slot[@name='JurisdictionDetermination']/rim:SlotValue/sdg:EvidenceProviderJurisdictionDetermination/sdg:JurisdictionLevel">
         <!--{}[](JurisdictionLevel-CodeList)-->
         <sch:assert test="( false() or ( contains('CountryNUTS1NUTS2NUTS3LAU',concat('',.,'')) ) )" id="R-DSD-ERR-C004" >Value supplied '<value-of xmlns="http://purl.oclc.org/dsdl/schematron" select="."/>' is unacceptable for constraints identified by 'JurisdictionLevel-CodeList' in the context 'query:QueryResponse/rs:Exception/rim:Slot[@name='JurisdictionDetermination']/rim:SlotValue/sdg:EvidenceProviderJurisdictionDetermination/sdg:JurisdictionLevel'</sch:assert>
      </sch:rule>   
      <sch:rule context="query:QueryResponse/rs:Exception/@xsi:type">
         <!--{}[](DSDErrorCodes-CodeList)-->
         <sch:assert test="( false() or ( contains('&#x7f;rs:ObjectNotFoundExceptionType&#x7f;rs:ObjectNotFoundExceptionType&#x7f;rs:InvalidRequestExceptionType&#x7f;rs:InvalidRequestExceptionType&#x7f;rs:ObjectNotFoundExceptionType&#x7f;rs:InvalidRequestExceptionType&#x7f;',concat('&#x7f;',.,'&#x7f;')) ) )" id="R-DSD-ERR-C017">The value of 'xsi:type' attribute of a 'rs:Exception' MUST be a 'type' provided by the code list 'DSDErrorCodes' (Data Service Directory Error Response Codes).</sch:assert>
      </sch:rule>
      <sch:rule context="query:QueryResponse/rs:Exception/@code">
         <!--{}[](DSDErrorCodes-CodeList)-->
         <sch:assert test="( false() or ( contains('DSD:ERR:0001DSD:ERR:0002DSD:ERR:0003DSD:ERR:0004DSD:ERR:0005DSD:ERR:0006',concat('',.,'')) ) ) " id="R-DSD-ERR-C023">Value supplied '<value-of xmlns="http://purl.oclc.org/dsdl/schematron" select="."/>' is unacceptable for constraints identified by 'DSDErrorCodes-CodeList' in the context 'query:QueryResponse/rs:Exception/@xsi:type'</sch:assert>
      </sch:rule>  
      <sch:rule context="query:QueryResponse/rs:Exception/@severity">
         <!--{}[](ErrorSeverity-CodeList)-->
         <sch:assert test="( false() or ( contains('urn:oasis:names:tc:ebxml-regrep:ErrorSeverityType:Errorurn:sr.oots.tech.europa.eu:codes:ErrorSeverity:DSDErrorResponse:AdditionalInputurn:sr.oots.tech.europa.eu:codes:ErrorSeverity:EDMErrorResponse:PreviewRequired',concat('',.,'')) ) )" id="R-DSD-ERR-C018">Value supplied '<value-of xmlns="http://purl.oclc.org/dsdl/schematron" select="."/>' is unacceptable for constraints identified by 'ErrorSeverity-CodeList' in the context 'query:QueryResponse/rs:Exception/@severity'</sch:assert>
      </sch:rule>
      <sch:rule context="query:QueryResponse/rs:Exception/rim:Slot[@name='DataServiceEvidenceType']/rim:SlotValue/sdg:DataServiceEvidenceType/sdg:AuthenticationLevelOfAssurance">
         <!--{}[](LevelsOfAssurance-CodeList)-->
         <sch:assert test="( false() or ( contains('LowSubstantialHigh',concat('',.,'')) ) ) " id="R-DSD-ERR-C024">Value supplied '<value-of xmlns="http://purl.oclc.org/dsdl/schematron" select="."/>' is unacceptable for constraints identified by 'LevelsOfAssurance-CodeList' in the context 'query:QueryResponse/rs:Exception/rim:Slot[@name='DataServiceEvidenceType']/rim:SlotValue/sdg:DataServiceEvidenceType/sdg:AuthenticationLevelOfAssurance'</sch:assert>
      </sch:rule>
   </sch:pattern> 
</sch:schema>   
