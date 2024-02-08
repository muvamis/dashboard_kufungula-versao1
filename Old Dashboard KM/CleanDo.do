clear all 
  
 global caminho  "C:\Users\MUVA\OneDrive - ASSOCIAÇÃO PARA O EMPODERAMENTO DA RAPARIGA-MUVA\DEPARTAMENTO MIS\DEPARTAMENTO MIS\PROJECTOS\SISTEMA DE MONITORIA\Kufungula\dashboard_kufungula-versao1\Data"
 tempfile geral nao_desistente perfildio desistente_monapo ribaue_presenca 1 2 3 4 5 6 7 8 9 Ribaue PI AG monapo_presenca monapo PI_monapo
  
 import excel "C:\Users\MUVA\OneDrive - ASSOCIAÇÃO PARA O EMPODERAMENTO DA RAPARIGA-MUVA\DEPARTAMENTO MIS\DEPARTAMENTO MIS\PROJECTOS\SISTEMA DE MONITORIA\Kufungula\Raw Kufungula\Desistente 15.xls", sheet("Sheet1") firstrow clear
 save `desistente_monapo', replace 
   
 use "$caminho\Lista_Nampula_Kufugula.dta", clear 
     
	 
 merge m:1 ID_Participante using `desistente_monapo'
 keep if _merge==1
 drop _merge 
 drop if ID_Participante=="" 
 sort ID_Participante
 
  
  merge m:1 ID_Participante using  "C:\Users\MUVA\OneDrive - ASSOCIAÇÃO PARA O EMPODERAMENTO DA RAPARIGA-MUVA\DEPARTAMENTO MIS\DEPARTAMENTO MIS\PROJECTOS\SISTEMA DE MONITORIA\Kufungula\Raw Kufungula\lucas.dta"
  drop if _merge==3 | _merge==2
  drop _merge
  append using "C:\Users\MUVA\OneDrive - ASSOCIAÇÃO PARA O EMPODERAMENTO DA RAPARIGA-MUVA\DEPARTAMENTO MIS\DEPARTAMENTO MIS\PROJECTOS\SISTEMA DE MONITORIA\Kufungula\Raw Kufungula\lucas.dta"
  replace Nome_District=Distrito 
  replace Provincia="NAMPULA"
  
  replace Nome_Participante=Nome_participante
  /*  drop _merge
	merge m:m ID_Participante using "C:\Users\MUVA\OneDrive - ASSOCIAÇÃO PARA O EMPODERAMENTO DA RAPARIGA-MUVA\DEPARTAMENTO MIS\DEPARTAMENTO MIS\PROJECTOS\SISTEMA DE MONITORIA\Kufungula\Raw Kufungula\fac.dta"

	replace Facilitador=Facilitadores if Facilitador==""
	replace Facilitator =Facilitador
	replace Deslocado=Deslocados if Deslocado==""
	drop Facilitadores Deslocados 
	 drop _merge*/
	
		* Parte 1
	replace Facilitador = "Domingas Abilio" if inlist(ID_Participante, "KM1574", "KM1575", "KM1576", "KM1577", "KM1580", "KM1581")
	 replace Facilitador = "Domingas Abilio" if inlist(ID_Participante, "KM1583", "KM1584", "KM1585", "KM1586", "KM1587", "KM1588")
	 replace Facilitador = "Domingas Abilio" if inlist(ID_Participante, "KM1589", "KM1590", "KM1592", "KM1593", "KM1597", "KM1598")
	 replace Facilitador = "Domingas Abilio" if inlist(ID_Participante, "KM1599", "KM1601", "KM1602", "KM1603", "KM1604", "KM1605")
	 replace Facilitador = "Domingas Abilio" if inlist(ID_Participante, "KM1606", "KM1609", "KM1612", "KM1614", "KM1615", "KM1617")
	 replace Facilitador = "Domingas Abilio" if inlist(ID_Participante, "KM1621", "KM1622", "KM1625", "KM1626", "KM1628", "KM1629")
	replace  Facilitador = "Domingas Abilio" if inlist(ID_Participante,"KM1630", "KM1631", "KM1632", "KM1633", "KM1636", "KM1637")
	replace Facilitador = "Domingas Abilio" if inlist(ID_Participante, "KM1639", "KM1640", "KM1641", "KM1642", "KM1643", "KM1644", "KM1645")
	replace Facilitador = "Domingas Abilio" if inlist(ID_Participante, "KM1646", "KM1647", "KM1648", "KM1649", "KM1650", "KM1651", "KM1652")
	replace Facilitador = "Domingas Abilio" if inlist(ID_Participante, "KM1653", "KM1654", "KM1656", "KM1657", "KM1658", "KM1659")
	replace Facilitador = "Domingas Abilio" if inlist(ID_Participante, "KM1660", "KM1661", "KM1664", "KM1665", "KM1666", "KM1667") 
	replace Facilitador = "Domingas Abilio" if inlist(ID_Participante,"KM1669", "KM1671", "KM1672", "KM2108", "KM2109", "KM2110")
	replace Facilitador = "Domingas Abilio" if inlist(ID_Participante,"KM2111", "KM2112", "KM2113", "KM2114", "KM2115", "KM2116")
	 replace Facilitador=upper(Facilitador)
	replace Facilitador="SERGIO SULULO" if Facilitador=="SéRGIO JOAQUIM SULULO"
	replace Facilitador="REMIGIO HORACIO" if Facilitador=="REMIGIO HORACIO "
	replace Facilitador="REMIGIO EUGENIO HORACIO" if Facilitador=="REMIGIO HORACIO"
	replace Facilitador="OMAR ALI" if Facilitador=="OMAR FRANCISCO ALI"
	replace Facilitador = trim(Facilitador)

	replace Facilitador="ALBERTINA CUALEIA" if Facilitador=="ALBERTINA LOURENçO JõAO CUALEIA"

	replace Facilitador="AGOSTINHO ADELINO" if Facilitador=="AGOSTINHO JúLIO ADELINO"

	replace Facilitador="CARLA ALBINO" if Facilitador=="CARLA ALFREDO ALBINO"

	replace Facilitador="DOMINGAS ABILIO" if Facilitador=="DOMINGAS ALBINO"

	replace Facilitador="ALBERTINA CUALEIA" if Facilitador=="ARGENTINA CUALEIA"

	replace Facilitador="JULECA FELISBERTO" if Facilitador=="JULECA JOAQUINA MARIA FELISBERTO"

	replace Facilitador="MAINOTE ABACAR" if Facilitador=="MAINOTE ABACAR CARLITOS" |  Facilitador=="MAINOTE ABUBACAR"

	replace Facilitador="MARLENE ALFREDO" if Facilitador=="MARLENE JOãO ALFREDO"
	replace Facilitador="CANDIDA FELISBERTO" if Facilitador=="CâNDIDA FELISBERTO CARLOS"


	//
	* Converter para maiúsculas
	replace Comunidade = upper(Comunidade)

	* Substituir acentos
	replace Comunidade = regexr(Comunidade, "á|Á", "A")
	replace Comunidade = regexr(Comunidade, "é|É", "E")
	replace Comunidade = regexr(Comunidade, "í|Í", "I")
	replace Comunidade = regexr(Comunidade, "ó|Ó", "O")
	replace Comunidade = regexr(Comunidade, "ú|Ú", "U")
	replace Comunidade = regexr(Comunidade, "à|À", "A")
	replace Comunidade = regexr(Comunidade, "è|È", "E")
	replace Comunidade = regexr(Comunidade, "ì|Ì", "I")
	replace Comunidade = regexr(Comunidade, "ò|Ò", "O")
	replace Comunidade = regexr(Comunidade, "ù|Ù", "U")
	replace Comunidade = regexr(Comunidade, "ã|Ã", "A")
	replace Comunidade = regexr(Comunidade, "õ|Õ", "O")
	replace Comunidade = regexr(Comunidade, "â|Â", "A")
	replace Comunidade = regexr(Comunidade, "ê|Ê", "E")
	replace Comunidade = regexr(Comunidade, "î|Î", "I")
	replace Comunidade = regexr(Comunidade, "ô|Ô", "O")
	replace Comunidade = regexr(Comunidade, "û|Û", "U")
	replace Comunidade = regexr(Comunidade, "ä|Ä", "A")
	replace Comunidade = regexr(Comunidade, "ë|Ë", "E")
	replace Comunidade = regexr(Comunidade, "ï|Ï", "I")
	replace Comunidade = regexr(Comunidade, "ö|Ö", "O")
	replace Comunidade = regexr(Comunidade, "ü|Ü", "U")
	replace Comunidade = regexr(Comunidade, "ç|Ç", "C")
	replace Comunidade = regexr(Comunidade, "ñ|Ñ", "N")
	replace Comunidade = trim(Comunidade)
	replace Comunidade ="MISEREPANE" if inlist(Comunidade, "MESEREPANE AND", "MESEREPANE", "MISEREPANE", "MISERIPANE")
	replace Comunidade ="MARROCANE" if inlist(Comunidade, "MAROCANE")
	replace Facilitator= Facilitador if Facilitator==""

	  replace Deslocado="NAO" if ID_Participante=="KM0083"
	 save `geral', replace 
	  
	 //merge m:m ID_Participante using  "C:\Users\MUVA\OneDrive - ASSOCIAÇÃO PARA O EMPODERAMENTO DA RAPARIGA-MUVA\DEPARTAMENTO MIS\DEPARTAMENTO MIS\PROJECTOS\SISTEMA DE MONITORIA\Kufungula\dashboard_kufungula-versao1\Data\Raw\facilitador 12.dta"

	 tab  Comunidade
	 

	replace Facilitador=Facilitator if Facilitador==""
	tab Facilitador Comunidade, m 
	replace Sexo=upper(Sexo)
	 drop if ID_Participante==""
	 drop if Nome_participante==""
	  replace Facilitador=Facilitadores if Facilitador==""
	  
	 

	replace Comunidade = ustrregexra(Comunidade, "[éèêë]", "e") in 1
	replace Comunidade = ustrregexra(Comunidade, "[íìîï]", "i") in 1
	replace Comunidade = ustrregexra(Comunidade, "[óòõôö]", "o") in 1
	replace Comunidade = ustrregexra(Comunidade, "[úùûü]", "u") in 1
	replace Comunidade = ustrregexra(Comunidade, "[ç]", "c") in 1

	tab Comunidade

	 
	 
		save "$caminho\Lista_Nampula_Kufugula.dta", replace  //gravar kufungula
		 
	   
	 use "$caminho\Raw\Versao 3\Presencas.dta", clear 
	 gen versao=3

	  append using "$caminho\Raw\Versao 5\Presencas.dta"  
	  replace versao=5 if versao==.
	  append using "$caminho\Raw\Versao 6\Presencas.dta" 
	  replace versao=6 if versao==.
	  append using "$caminho\Raw\Versao 8\Presencas.dta" 
	  replace versao=8 if versao==.
	  append using "$caminho\Raw\Versao 9\Presencas.dta" 
	  replace versao=9 if versao==.
		append using "$caminho\Raw\Versao 10\Presencas.dta" 
	  replace versao=10 if versao==.
	  //ren Facilitator Fa
	 foreach i in Nome_Participante Provincia Nome_District Comunidade Facilitator Formation_PI Session_PI Formation_AG Session ID_Participante Turma Presenca Reposicao_sessao interview__status {
	   decode `i' , generate(`i'_1) 
	   drop `i'
	   ren `i'_1 `i' 

	} 
	  
	merge m:m ID_Participante using "$caminho\Lista_Nampula_Kufugula.dta"
	
	
	ex
	   

	 //drop if Nome_District=="Ribaue" & versao!=9 // Verificar 
	 
	   
	 keep if interview__status=="ApprovedByHeadquarters"
	 merge m:1 ID_Participante using   `desistente_monapo'
	 keep if _merge==1
	 drop _merge
	 // drop if Nome_Participante==""
	 // drop if ID_Participante==""

	  
	//drop Nome_District	Comunidade	Facilitator interview__key interview__id Imagem sssys_irnd has__errors interview__status assignment__id
	sort  Nome_Participante
	 //ren Nome_Participante Nome_participante
	 replace Nome_participante=upper(Nome_participante)
	 drop if ID_Participante==""
	 drop  interview__id Imagem sssys_irnd has__errors interview__status assignment__id
	replace Nome_District=upper(Nome_District)

	 

	// Crie as variáveis dummy com base nas listas de IDs
	gen dummy_lista1 = inlist(ID_Participante, "KM0146", "KM0177", "KM0187", "KM0188")
	gen dummy_lista2 = inlist(ID_Participante, "KM0192", "KM0304", "KM0358", "KM0387")
	gen dummy_lista3 = inlist(ID_Participante, "KM0418", "KM0485", "KM0736", "KM1076")
	gen dummy_lista4 = inlist(ID_Participante, "KM1093", "KM2157", "KM2226", "KM2227")
	drop if interview__key=="32-99-53-55"

	br if dummy_lista1 | dummy_lista2 | dummy_lista3 | dummy_lista4
	 
	replace ID = "KM0146" if Nome_participante == "JULIETA MANUEL"
	replace ID = "KM0736" if Nome_participante == "ANA ALVES"
	replace ID = "KM0485" if Nome_participante == "JULIETA CAETANO ALI"
	replace ID = "KM0304" if Nome_participante == "GILDA ADRIANO"
	drop if ID_Participante=="KM0944"
	drop   if inlist(ID_Participante, "KM0737", "KM0901")
	drop if ID_Participante==""
	 
	 foreach i in   Provincia Comunidade  Turma   {
	 
	 drop `i'  
	 
	 }
	   
	  merge m:m ID_Participante using "$caminho\Lista_Nampula_Kufugula.dta"
	  
	 
	  replace Nome_Participante=Nome_participante if Nome_Participante==""
	  drop if ID_Participante==""
	   drop if Desistencia=="SIM"
	  drop Nome_participante	Desistencia	dummy_lista1	dummy_lista2	dummy_lista3	dummy_lista4
	   replace Sexo=upper(Sexo)
	   replace Nome_District=upper(Nome_District)
	  replace Nome_District=Distrito 
	  drop if Nome_Participante=="ELISABETE JOANITO"
	  drop if _merge==1
	  replace Facilitador="Carla Albino" if ID_Participante=="KM2188"
	  replace Facilitador="Agostinho Adelino" if inlist(ID_Participante, "KM0385", "KM2170")

	  replace Facilitador=Facilitator if Facilitador==""
	  drop Facilitator
	  
	  
	  
	  
	 foreach i in Nome_Participante Facilitador Provincia Comunidade  {
	 replace `i'=upper(`i')
	 
	 }
  
  
  
	  ren  Nome_Participante Nome_participante
	  order ID_Participante	 Nome_participante Provincia	Distrito	Sexo	Idade	Data	Nome_District	Formation_PI	 Session_PI	Formation_AG	Session	Presenca
 
 
 
	 //generate Data_datetime = clock(Data, "YMDhms")
	generate Data_clean = subinstr(Data, "T", " ", .)
	generate Data_datetime = clock(Data_clean, "YMDhms")
	format Data_datetime %tc
	drop Data_clean Data_nascimento Data
	ren Data_datetime Data


	sort ID_Participante Nome_participante Formation_PI Session_PI Formation_AG Session Data
	by ID_Participante Nome_participante Formation_PI Session_PI Formation_AG Session: gen duplicado = _n


	 //bysort ID_Participante Nome_participante Formation_PI Session_PI Formation_AG Session: 
	drop if inlist(interview__key, "03-72-41-71", "89-99-17-55","47-58-04-77","97-03-85-88", ///
	"93-81-29-49","16-86-46-94","30-76-11-21","81-28-65-55")
	 
	drop if inlist(interview__key, "63-58-08-26", "94-24-90-56", "12-94-44-71", "99-75-99-77", "20-56-46-63") | ///
	inlist(interview__key, "65-55-21-66", "65-28-89-99", "45-05-53-15", "57-22-59-04", "64-91-01-35") | inlist(interview__key, ///
	"97-89-99-37", "17-13-22-09", "71-86-61-52", "71-71-67-86", "83-00-87-31", "20-98-38-72")  | ///
	inlist(interview__key, "08-13-29-30", "21-19-06-52", "28-94-15-34", "18-13-28-37", "26-18-42-16", "07-22-40-77", "30-86-61-74")  
	  

	drop if inlist(interview__key, "36-03-28-90", "81-95-23-71", "81-80-97-85", "23-65-64-16", "81-56-91-96", "23-92-87-17", "62-43-93-08", "85-63-99-65")
	drop if inlist(interview__key, "77-37-46-23", "23-54-33-27", "97-69-23-72", "53-07-15-81", "73-45-48-68", "30-44-56-79", "91-21-55-51", "34-27-77-02")
	drop if inlist(interview__key, "19-95-31-01", "24-29-99-55", "22-05-32-33", "78-40-82-12", "47-70-35-12", "73-71-79-39", "81-79-26-30", "83-83-43-51", "11-29-79-79")
	drop if inlist(interview__key, "95-22-14-72", "43-72-88-28", "82-13-13-11", "15-88-69-10", "66-65-14-09", "05-22-91-09", "15-93-46-49", "20-83-24-95", "20-64-16-14")
	drop if inlist(interview__key, "73-61-43-28", "49-89-87-45")
	drop if inlist(interview__key, "44-99-25-48", "27-88-73-16", "60-23-22-18", "69-31-19-70", "35-87-96-97", "50-36-47-40", "46-03-58-64", "04-84-61-04")
	drop if inlist(interview__key, "96-13-28-88", "13-44-75-10", "71-80-98-92", "63-96-46-43", "34-90-05-08", "10-59-60-61", "58-34-23-41", "65-16-14-20")
	drop if inlist(interview__key, "05-07-87-74", "67-54-81-02", "82-27-80-40", "69-12-44-37", "56-10-38-85", "30-10-36-03", "68-05-67-41", "60-33-10-34") 
	drop if inlist(interview__key, "55-92-02-62", "87-26-74-45", "34-18-45-22", "05-27-36-73", "42-87-56-54", "24-47-37-91", "89-61-37-00", "99-84-57-63")
	drop if inlist(interview__key, "15-70-27-93", "66-22-43-46", "37-01-04-15", "87-63-07-67", "36-88-01-69", "83-22-91-24")
	drop if inlist(interview__key, "41-60-44-27", "66-19-35-99", "58-67-60-34", "01-22-36-52","93-30-97-18")
	drop if inlist(interview__key, "18-28-06-22", "51-37-85-78", "56-08-79-04", "40-42-99-51", "87-31-00-85", "77-83-26-48", "50-34-34-49", "83-11-96-44", "01-99-73-85")
	drop if inlist(interview__key, "71-29-52-30", "67-55-75-95", "47-07-62-67", "95-39-07-08")
	drop if inlist(interview__key, "66-40-94-90", "85-95-87-52", "54-53-25-70", "87-96-64-95")
	drop if inlist(interview__key, "22-07-69-02", "68-35-58-45", "28-05-63-04", "83-79-89-73")
	drop if inlist(interview__key, "75-90-48-41", "72-29-37-92", "51-11-22-84", "42-20-42-71")
	drop if inlist(interview__key, "36-53-26-20", "54-76-10-55", "20-68-10-90", "20-53-41-81")
	drop if inlist(interview__key, "30-06-59-73", "22-85-60-56", "78-54-88-35", "13-00-00-65", "10-55-29-63")
	drop if inlist(interview__key, "06-77-65-66", "59-01-36-18", "44-47-24-07", "46-48-99-44", "34-64-72-86", "06-62-57-40", "40-94-44-78")
	drop if inlist(interview__key, "66-23-69-13", "45-84-40-78", "27-78-51-29", "82-35-17-81", "15-66-57-16", "32-27-36-78", "32-27-47-30")
	drop if inlist(interview__key, "23-62-08-14", "33-77-21-66", "53-88-03-18", "98-40-72-14", "63-40-68-49", "76-04-29-80", "78-55-28-02")
	drop if inlist(interview__key, "65-30-94-23", "98-25-23-16", "07-47-77-25", "77-31-73-83", "14-57-59-34", "95-21-33-24", "00-63-31-71")
	drop if inlist(interview__key, "98-38-59-84", "26-27-73-15", "11-72-69-74")
	drop if inlist(interview__key, "59-37-86-03", "24-04-03-19", "96-83-72-70", "62-57-18-72", "04-80-81-98", "11-60-25-90", "74-68-93-44")
	drop if inlist(interview__key, "89-87-28-35", "09-81-88-13", "98-46-95-80", "22-21-70-79", "08-39-74-87", "89-50-16-68", "99-75-62-30") | ///
	inlist(interview__key, "41-10-86-74", "71-14-03-80", "39-18-20-96", "73-17-14-29", "85-93-39-71", "76-02-08-10", "18-80-75-36") | ///
	inlist(interview__key, "45-46-26-23", "69-77-95-16", "11-17-08-20", "64-23-35-13", "91-42-07-04", "67-35-70-23", "55-57-36-71") | ///
	inlist(interview__key, "32-75-96-04", "24-79-25-67", "21-94-95-21", "33-53-63-28", "27-88-47-15", "05-65-65-59", "28-66-03-42") | ///
	inlist(interview__key, "43-10-09-61", "78-94-32-82", "41-05-14-57", "08-97-75-54", "13-51-22-53", "94-32-36-18") | ///
	inlist(interview__key, "39-83-30-77", "04-59-41-44", "24-31-46-20", "33-86-65-11", "89-54-50-02", "27-66-58-21", "71-90-18-23") | /// 
	inlist(interview__key, "49-30-91-64", "56-04-85-89", "68-57-80-18", "28-64-44-57", "59-85-40-05", "57-59-20-58", "97-87-77-22") | ///
	inlist(interview__key, "20-45-12-82", "99-91-79-35", "38-28-63-10", "69-73-61-83", "72-05-36-61", "34-41-15-22", "63-50-84-75") | ///
	inlist(interview__key, "36-77-64-99") | inlist(interview__key, "44-47-72-59", "16-85-50-30", "78-57-97-12", "39-88-84-36", "86-30-11-05", "60-07-25-02", "00-56-25-95") | ///
	inlist(interview__key, "98-50-28-36") | inlist(interview__key, "65-74-08-53", "97-95-55-85", "16-69-73-12", "02-09-38-01", "19-42-96-26", "91-11-50-26", "69-22-64-66") | ///
	inlist(interview__key, "08-76-77-41", "98-17-42-30", "73-10-28-21", "69-80-58-65", "87-32-43-42", "36-84-36-56", "09-00-42-69") | ///
	inlist(interview__key, "63-79-22-31", "79-98-96-04", "56-75-30-93", "62-31-02-12", "51-21-93-84", "55-28-08-09", "00-13-19-60") | ///
	inlist(interview__key, "56-87-81-77","76-04-40-51","48-44-57-88","73-95-09-84","33-48-08-00")  | ///
	inlist(interview__key,"13-25-34-93", "13-34-24-97", "60-92-32-83", "93-03-47-96", "48-52-40-95", "74-62-41-06", "19-59-93-49") | ///
	inlist(interview__key,"03-38-42-80", "31-63-78-42", "17-04-21-34", "66-81-88-65")

	drop if inlist(interview__key,"13-25-34-93", "13-34-24-97", "60-92-32-83", "93-03-47-96", "48-52-40-95", "74-62-41-06", "19-59-93-49") | ///
	inlist(interview__key,"03-38-42-80", "31-63-78-42")

	drop if inlist(interview__key, "34-96-55-52", "64-14-26-61", "50-01-72-05", "25-62-87-02", "41-15-85-33", "13-72-60-22", "86-65-90-26")
	drop if inlist(interview__key,"46-48-27-68", "84-44-13-64", "74-41-78-48", "99-07-54-17", "81-30-80-30", "86-88-19-34", "61-82-38-82")
	drop if inlist(interview__key,"11-18-18-21", "56-36-87-09", "49-00-57-58", "70-39-11-09", "75-89-36-00", "68-17-55-42", "90-04-52-83")
	drop if inlist(interview__key,"69-41-27-10", "70-11-47-23", "48-77-68-27", "45-75-38-17", "66-96-89-40", "00-16-18-42", "65-24-37-75")
	drop if inlist(interview__key,"86-00-93-87", "74-69-85-74", "19-86-13-33", "21-63-03-55", "48-04-08-57", "98-89-54-40", "79-61-75-30")
	drop if inlist(interview__key,"36-85-30-09", "66-76-27-81", "73-65-73-69", "01-82-35-91", "14-27-75-20", "75-51-43-15", "60-21-30-26")
	drop if inlist(interview__key,"45-28-20-28", "92-74-30-70", "84-09-67-52", "05-44-07-05", "55-24-98-47", "31-90-26-19", "66-34-77-96")
	drop if inlist(interview__key,"95-51-96-17", "94-54-55-12", "66-78-12-27", "03-46-84-93", "11-77-24-94", "01-21-33-76", "97-88-30-19")
	drop if interview__key =="36-44-54-62"
	drop if interview__key == "39-49-62-65" 
	drop if inlist(interview__key,"32-14-35-97", "87-46-88-03", "60-99-24-55","89-94-24-34", "98-30-98-32", "72-22-89-30", "75-50-62-54")
	drop if inlist(interview__key,"91-88-41-75", ///
	"79-25-01-75", ///
	"76-65-59-63", ///
	"35-36-77-52", ///
	"20-77-68-31", ///
	"74-49-72-56", ///
	"01-83-66-56")
	drop if inlist(interview__key,"89-32-72-33", ///
	"90-73-06-92", ///
	"30-25-28-14", ///
	"05-98-48-26", ///
	"02-66-98-79", ///
	"04-43-26-69", ///
	"93-82-18-67")
	drop if inlist(interview__key,"06-10-47-99", ///
	"64-14-90-13", ///
	"88-34-77-56", ///
	"05-31-88-13", ///
	"25-73-78-03", ///
	"52-37-84-92")
	drop if inlist(interview__key,"44-83-44-86", ///
	"88-15-09-79", ///
	"17-28-56-16", ///
	"92-29-46-14", ///
	"17-11-60-62", ///
	"03-92-79-91", ///
	"18-97-34-38")
	drop if inlist(interview__key,"92-08-10-55", ///
	"40-09-81-22", ///
	"47-50-16-51", ///
	"61-78-72-22", ///
	"43-42-11-78", ///
	"77-62-08-50", ///
	"83-81-39-98")
	drop if inlist(interview__key,"62-29-35-73", ///
	"19-65-41-88", ///
	"51-65-21-99", ///
	"35-15-34-55", ///
	"90-99-88-81", ///
	"60-11-91-84", ///
	"03-99-68-09")
	drop if inlist(interview__key,"63-16-60-04", ///
	"53-47-03-85", ///
	"81-65-34-09", ///
	"14-96-99-79", ///
	"78-22-17-20", ///
	"56-42-72-56", ///
	"95-19-18-15", ///
	"88-80-15-62")
	drop if inlist(interview__key,"22-29-85-04", ///
	"28-07-61-08", ///
	"58-06-02-16", ///
	"64-24-98-60", ///
	"96-57-47-64", ///
	"99-52-50-24", ///
	"18-37-24-60")
	drop if inlist(interview__key,"86-08-18-99", ///
	"34-34-79-46", ///
	"62-11-15-86", ///
	"40-91-78-35", ///
	"38-87-99-52", ///
	"23-71-52-44")
	drop if inlist(interview__key,"48-00-46-89", ///
	"10-95-06-28", ///
	"61-47-07-72", ///
	"07-18-62-39", ///
	"66-14-81-41", ///
	"88-93-66-58")
	drop if inlist(interview__key,"71-91-23-58", ///
	"72-04-09-07", ///
	"60-52-67-98", ///
	"46-07-01-03", ///
	"49-23-76-68", ///
	"63-40-07-47", ///
	"76-20-44-09")
	drop if inlist(interview__key,"26-61-04-71", ///
	"23-62-00-15", ///
	"13-42-88-90", ///
	"14-74-04-58", ///
	"05-37-41-82", ///
	"06-10-86-98")
	drop if inlist(interview__key,"06-68-63-88", ///
	"54-60-76-97", ///
	"08-05-39-35", ///
	"59-25-32-22", ///
	"87-78-51-62", ///
	"81-81-08-30", ///
	"94-90-58-63") 
	drop if inlist(interview__key,"48-90-15-67", ///
	"98-26-85-16", ///
	"61-73-69-53", ///
	"17-28-23-43", ///
	"01-13-28-54", ///
	"85-70-36-43", ///
	"84-39-01-88")
	drop if inlist(interview__key,"03-71-15-52", ///
	"52-82-13-54", ///
	"62-23-35-55", ///
	"05-08-98-19", ///
	"64-90-75-05", ///
	"78-71-24-03")
	drop if inlist(interview__key,"88-41-94-30", ///
	"07-90-51-37", ///
	"25-51-98-78", ///
	"10-82-13-48", ///
	"88-30-95-41", /// 
	"10-95-28-03", ///
	"49-26-39-27")
	drop if inlist(interview__key,"79-05-86-50", ///
	"90-05-49-54", ///
	"20-57-64-49", ///
	"92-31-57-32", ///
	"45-31-66-88", ///
	"12-99-92-72")
	drop if inlist(interview__key,"78-48-25-20", ///
	"55-80-83-91", ///
	"06-57-71-35", ///
	"29-84-28-56", ///
	"77-49-17-27")
	drop if inlist(interview__key,"01-91-13-84", ///
	"41-79-89-27", ///
	"86-70-92-60", ///
	"99-75-38-37", /// 
	"54-76-72-51")
	drop if inlist(interview__key, "55-70-23-21", "45-80-24-29", "53-26-52-35", "27-81-02-37", "58-92-91-45", "43-43-38-16", "44-65-17-53", "79-38-33-79") ///
		| inlist(interview__key, "62-83-77-06", "24-48-50-36", "37-17-55-64", "21-12-89-16", "37-03-13-41", "91-74-55-80", "48-47-30-95", "59-39-08-57") ///
		| inlist(interview__key, "98-83-09-73", "65-48-06-29", "11-38-75-56", "31-12-16-55", "52-02-64-04", "60-40-61-03", "88-70-06-53", "40-53-26-61") ///
		| inlist(interview__key, "24-05-54-81", "48-78-35-80", "54-58-44-33", "94-10-92-18", "25-91-98-66", "52-49-70-78", "20-36-31-05", "21-88-03-08") ///
		| inlist(interview__key, "31-52-88-20", "21-93-28-52", "06-68-12-24", "38-45-44-68", "56-83-06-74", "72-56-98-12", "92-91-07-45", "26-68-49-68") ///
		| inlist(interview__key, "25-43-17-64", "71-24-49-60", "32-66-59-83", "59-11-83-68", "20-28-75-97", "42-17-17-83", "83-66-47-38", "75-44-21-64") ///
		| inlist(interview__key, "96-47-40-94", "98-23-80-82", "95-04-19-88", "58-76-80-70", "56-12-16-17", "77-99-59-51", "04-50-31-93", "67-85-57-76") ///
		| inlist(interview__key, "13-08-91-37", "45-10-51-36", "79-26-29-03", "82-13-23-33", "72-94-72-23", "97-56-24-06", "26-64-92-42", "70-85-49-26") ///
		| inlist(interview__key, "19-48-16-08", "89-77-23-23", "90-43-82-84", "29-74-52-63", "14-57-98-81", "01-83-70-54", "84-23-41-35", "83-71-46-14") ///
		| inlist(interview__key, "73-43-00-10", "18-82-76-61", "22-88-33-16", "05-15-48-29", "79-61-39-73", "38-20-26-88", "99-62-94-57", "44-13-87-44") ///
		| inlist(interview__key, "93-56-27-15", "06-70-20-79", "70-94-31-37", "43-39-16-95", "71-49-22-05", "58-70-58-38", "03-92-21-44", "51-71-97-32") ///
		| inlist(interview__key, "10-00-92-88", "71-98-48-23", "02-00-04-84", "13-02-70-49", "62-04-05-26", "10-91-60-37", "59-05-79-84", "94-98-18-98") ///
		| inlist(interview__key, "08-51-55-10", "35-85-11-45", "10-41-13-38", "14-59-11-97", "21-46-76-41", "92-40-96-22", "85-46-18-33", "10-82-09-05") 
	 
	 

	drop if interview__key=="16-44-51-26"
	drop if interview__key=="26-79-96-17"
	drop if interview__key=="14-96-97-16"
	drop if interview__key=="09-15-33-70"
	drop if interview__key=="43-58-85-38"
	drop if interview__key=="22-23-74-31"
	drop if interview__key=="90-26-07-05"
	drop if interview__key=="04-37-09-20"
	drop if interview__key=="26-80-76-83"
	drop if interview__key=="82-35-96-37"
	drop if interview__key=="15-94-61-82"
	drop if interview__key=="76-78-61-96"
	drop if interview__key=="97-45-20-48"
	drop if interview__key=="71-98-91-30"
	drop if interview__key=="19-99-15-89"
	drop if interview__key=="94-36-37-52"
	drop if interview__key=="59-89-24-39"
	drop if interview__key=="98-96-87-42"
	drop if interview__key=="24-85-67-65"
	drop if interview__key=="49-96-61-88"
	drop if interview__key=="56-58-48-11"
	drop if interview__key=="49-90-21-17"
	drop if interview__key=="53-85-43-26"
	drop if interview__key=="19-57-61-59"
	drop if interview__key=="90-22-86-31"
	drop if interview__key=="87-19-24-02"
	drop if interview__key=="80-51-54-54"
	drop if interview__key=="93-17-52-33"
	drop if interview__key=="84-73-93-44"
	drop if interview__key=="51-86-45-03"
	drop if interview__key=="30-10-28-35"
	drop if interview__key=="53-23-49-17"
	drop if interview__key=="72-28-05-32"
	drop if interview__key=="22-46-58-18"
	drop if interview__key=="98-96-80-47"
	drop if interview__key=="18-75-37-33"
	drop if interview__key=="35-81-22-28"
	drop if interview__key=="18-74-93-78"
	drop if interview__key=="07-25-01-92"
	drop if interview__key=="84-68-78-56"
	drop if interview__key=="40-91-80-20"
	drop if interview__key=="09-29-51-29"
	drop if interview__key=="33-97-16-23"
	drop if interview__key=="09-82-67-66"
	drop if interview__key=="63-67-42-89"
	drop if interview__key=="73-89-61-81"
	drop if interview__key=="88-88-66-97"
	drop if interview__key=="80-40-42-03"
	drop if interview__key=="00-22-21-13"
	drop if interview__key=="17-04-44-96"
	drop if interview__key=="20-62-13-39"
	drop if interview__key=="90-59-58-40"
	drop if interview__key=="28-79-52-47"
	drop if interview__key=="46-26-19-83"
	drop if interview__key=="64-75-32-12"
	drop if interview__key=="55-24-59-94"
	drop if interview__key=="88-30-75-98"
	drop if interview__key=="52-42-42-52"
	drop if interview__key=="43-25-71-53"
	drop if interview__key=="46-37-21-70"
	drop if interview__key=="08-82-81-56"
	drop if interview__key=="79-70-07-03"
	drop if interview__key=="90-45-82-19"
	drop if interview__key=="56-68-55-68"
	drop if interview__key=="53-35-85-76"
	drop if interview__key=="41-00-96-48"
	drop if interview__key=="99-23-18-30"
	drop if interview__key=="68-38-05-61"
	drop if interview__key=="71-74-50-49"
	drop if interview__key=="34-22-77-36"
	drop if interview__key=="45-69-83-11"
	drop if interview__key=="94-81-20-50"
	drop if interview__key=="46-40-77-23"
	drop if interview__key=="98-44-25-79"
	drop if interview__key=="00-26-03-77"
	drop if interview__key=="45-53-17-49"
	drop if interview__key=="65-82-24-18"
	drop if interview__key=="65-19-80-21"
	drop if interview__key=="38-85-56-90"
	drop if interview__key=="48-22-84-41"
	drop if interview__key=="68-01-22-48"
	drop if interview__key=="50-28-72-67"
	drop if interview__key=="12-81-56-96"
	drop if interview__key=="00-65-03-96"
	drop if interview__key=="39-50-99-97"
	drop if interview__key=="71-72-22-78"
	drop if interview__key=="31-14-66-08"
	drop if interview__key=="83-78-59-83"
	drop if interview__key=="67-89-74-45"
	drop if interview__key=="42-65-28-45"
	drop if interview__key=="65-80-44-44"
	drop if interview__key=="28-54-69-49"
	drop if interview__key=="29-78-71-04"
	drop if interview__key=="14-32-34-54"
	drop if interview__key=="34-52-84-54"
	drop if interview__key=="11-36-32-07"
	drop if interview__key=="85-69-81-45"
	drop if interview__key=="39-14-25-09"
	drop if interview__key=="62-79-34-58"
	drop if interview__key=="41-79-67-84"
	drop if interview__key=="80-57-54-49"
	drop if interview__key=="42-45-51-74"
	drop if interview__key=="45-83-04-32"

	drop if interview__key=="01-69-88-61"
	drop if interview__key=="34-97-07-15"
	drop if interview__key=="42-29-66-19"
	drop if interview__key=="07-30-97-59"
	drop if interview__key=="25-82-62-08"
	drop if interview__key=="33-45-09-25"
	drop if interview__key=="87-90-16-52"
	drop if interview__key=="05-42-10-44"
	drop if interview__key=="01-58-87-79"
	drop if interview__key=="37-19-15-97"
	drop if interview__key=="29-13-60-78"
	drop if interview__key=="22-44-35-21"
	drop if interview__key=="80-13-11-97"
	drop if interview__key=="59-70-16-20"
	drop if interview__key=="79-54-52-01"
	drop if interview__key=="18-74-86-17"
	drop if interview__key=="23-43-50-16"
	drop if interview__key=="63-53-98-54"
	drop if interview__key=="05-50-18-21"
	drop if interview__key=="54-22-59-19"
	drop if interview__key=="76-42-54-70"
	drop if interview__key=="87-71-20-90"
	drop if interview__key=="91-84-09-71"
	drop if interview__key=="79-17-74-08"
	drop if interview__key=="34-29-55-94"
	drop if interview__key=="99-44-42-22"
	drop if interview__key=="96-42-55-72"
	drop if interview__key=="88-56-49-62"
	drop if interview__key=="10-77-31-28"
	drop if interview__key=="17-15-94-73"
	drop if interview__key=="80-03-52-47"
	drop if interview__key=="00-93-81-48"
	drop if interview__key=="78-54-32-89"
	drop if interview__key=="23-18-41-55"
	drop if interview__key=="50-69-14-83"
	drop if interview__key=="58-60-19-38"
	drop if interview__key=="14-15-01-11"
	drop if interview__key=="10-22-33-70"
	drop if interview__key=="28-33-58-35"
	drop if interview__key=="21-39-61-38"
	drop if interview__key=="89-17-52-73"
	drop if interview__key=="38-40-78-07"
	drop if interview__key=="43-57-17-54"
	drop if interview__key=="59-50-25-82"
	drop if interview__key=="07-51-66-10"
	drop if interview__key=="18-94-12-93"
	drop if interview__key=="06-50-12-92"
	drop if interview__key=="42-32-18-54"
	drop if interview__key=="80-23-51-58"
	drop if interview__key=="03-32-34-78"
	drop if interview__key=="42-35-75-96"
	drop if interview__key=="84-34-50-74"
	drop if interview__key=="97-90-56-25"
	drop if interview__key=="24-79-02-70"
	drop if interview__key=="41-41-24-14"
	drop if interview__key=="75-39-88-04"
	drop if interview__key=="17-71-82-64"
	drop if interview__key=="91-33-47-84"
	drop if interview__key=="51-26-76-40"
	drop if interview__key=="78-68-61-74"
	drop if interview__key=="65-84-39-96"
	drop if interview__key=="97-93-97-01"
	drop if interview__key=="07-95-65-52"
	drop if interview__key=="54-06-44-48"
	drop if interview__key=="70-49-17-20"
	drop if interview__key=="37-37-51-68"
	drop if interview__key=="99-91-92-78"
	drop if interview__key=="32-15-16-25"
	drop if interview__key=="31-87-82-72"
	drop if interview__key=="38-76-53-89"
	drop if interview__key=="23-09-23-38"
	drop if interview__key=="81-00-96-65"
	drop if interview__key=="89-04-97-06"
	drop if interview__key=="87-65-46-74"
	drop if interview__key=="54-52-02-20"
	drop if interview__key=="87-19-50-25"
	drop if interview__key=="83-36-99-01"
	drop if interview__key=="38-42-24-68"
	drop if interview__key=="02-18-74-38"
	drop if interview__key=="71-85-38-23"
	drop if interview__key=="31-75-42-07"
	drop if interview__key=="42-61-80-08"
	drop if interview__key=="15-52-57-58"
	drop if interview__key=="44-32-56-75"
	drop if interview__key=="79-03-46-82"
	drop if interview__key=="69-26-72-21"
	drop if interview__key=="82-37-98-15"
	drop if interview__key=="54-03-78-52"
	drop if interview__key=="65-51-01-64"
	drop if interview__key=="05-52-19-84"
	drop if interview__key=="75-85-05-62"
	drop if interview__key=="92-09-75-31"
	drop if interview__key=="86-27-82-76"
	drop if interview__key=="38-57-26-18"
	drop if interview__key=="38-15-32-25"
	drop if interview__key=="58-52-52-28"
	drop if interview__key=="17-90-85-37"
	drop if interview__key=="45-08-77-64"
	drop if interview__key=="14-93-26-17"
	drop if interview__key=="44-93-06-39"
	drop if interview__key=="96-96-32-68"
	drop if interview__key=="47-59-01-52"
	drop if interview__key=="24-57-14-65"
	drop if interview__key=="35-16-00-92"
	drop if interview__key=="82-41-43-47"
	drop if interview__key=="26-64-75-96"
	drop if interview__key=="14-94-50-45"
	drop if interview__key=="89-26-72-54"
	drop if interview__key=="76-42-03-70"
	drop if interview__key=="49-47-12-09"
	drop if interview__key=="68-33-14-84"
	drop if interview__key=="99-94-72-43"
	drop if interview__key=="32-83-33-11"
	drop if interview__key=="10-61-10-47"
	drop if interview__key=="91-42-50-76"
	drop if interview__key=="97-98-51-88"
	drop if interview__key=="46-82-27-60"
	drop if interview__key=="13-94-94-97"
	drop if interview__key=="74-85-42-73"
	drop if interview__key=="53-00-25-92"
	drop if interview__key=="83-46-95-86"
	drop if interview__key=="54-55-86-41"
	drop if interview__key=="40-50-01-60"
	drop if interview__key=="29-06-84-80"
	drop if interview__key=="16-80-89-99"
	drop if interview__key=="24-94-73-68"
	drop if interview__key=="72-48-35-71"
	drop if interview__key=="45-44-81-10"
	drop if interview__key=="83-26-66-89"
	drop if interview__key=="43-87-14-08"
	drop if interview__key=="88-51-87-45"
	drop if interview__key=="35-02-21-73"
	drop if interview__key=="79-19-10-66"
	drop if interview__key=="12-21-98-48"
	drop if interview__key=="76-17-09-66"
	drop if interview__key=="96-00-19-71"
	drop if interview__key=="36-57-44-32"
	drop if interview__key=="09-67-72-97"
	drop if interview__key=="25-80-55-52"
	drop if interview__key=="54-48-43-98"
	drop if interview__key=="81-24-15-97"
	drop if interview__key=="88-34-92-01"
	drop if interview__key=="39-82-59-80"
	drop if interview__key=="30-68-39-09"
	drop if interview__key=="78-44-93-01"
	drop if interview__key=="39-58-99-59"
	drop if interview__key=="58-84-10-77"
	drop if interview__key=="12-24-89-41"
	drop if interview__key=="24-70-50-34"
	drop if interview__key=="94-34-38-53"
	drop if interview__key=="27-49-87-28"
	drop if interview__key=="14-90-68-34"
	drop if interview__key=="22-32-77-50"
	drop if interview__key=="95-04-75-21"
	drop if interview__key=="50-90-67-68"
	drop if interview__key=="30-50-44-77"
	drop if interview__key=="25-66-20-46"
	drop if interview__key=="13-31-34-82"
	drop if interview__key=="78-19-16-26"
	drop if interview__key=="01-50-16-24"
	drop if interview__key=="93-14-07-12"
	drop if interview__key=="48-08-02-84"
	drop if interview__key=="96-11-61-65"
	drop if interview__key=="35-11-14-46"
	drop if interview__key=="58-93-20-07"
	drop if interview__key=="02-14-42-80"
	drop if interview__key=="26-48-77-35"
	drop if interview__key=="02-32-28-74"
	drop if interview__key=="57-66-59-78"
	drop if interview__key=="30-41-47-77"
	drop if interview__key=="67-46-28-25"
	drop if interview__key=="64-46-24-86"
	drop if interview__key=="96-51-48-58"
	drop if interview__key=="59-69-57-03"
	drop if interview__key=="95-77-80-92"
	drop if interview__key=="45-89-96-56"
	drop if interview__key=="11-05-96-96"
	drop if interview__key=="43-64-47-58"
	drop if interview__key=="04-79-11-66"
	drop if interview__key=="76-93-55-28"
	drop if interview__key=="87-74-50-13"
	drop if interview__key=="15-74-78-59"
	drop if interview__key=="87-21-77-75"
	drop if interview__key=="64-47-89-31"
	drop if interview__key=="04-39-92-34"
	drop if interview__key=="38-19-81-58"
	drop if interview__key=="75-21-17-67"
	drop if interview__key=="58-83-97-03"
	drop if interview__key=="45-87-09-18"
	drop if interview__key=="99-63-62-19"
	drop if interview__key=="75-06-33-09"
	drop if interview__key=="82-73-93-85"
	drop if interview__key=="11-17-62-38"
	drop if interview__key=="70-28-04-86"
	drop if interview__key=="57-05-71-56"
	drop if interview__key=="01-21-31-30"
	drop if interview__key=="08-24-01-13"
	drop if interview__key=="11-12-83-68"
	drop if interview__key=="84-55-38-84"
	drop if interview__key=="83-75-03-85"
	drop if interview__key=="87-53-51-47"
	drop if interview__key=="81-23-01-92"
	drop if interview__key=="63-95-86-27"
	drop if interview__key=="12-05-23-33"
	drop if interview__key=="31-10-98-47"
	drop if interview__key=="53-64-84-35"
	drop if interview__key=="23-49-12-01"
	drop if interview__key=="35-90-27-02"
	drop if interview__key=="24-05-08-17"
	drop if interview__key=="24-12-85-16"
	drop if interview__key=="89-04-19-60"
	drop if interview__key=="82-13-58-73"
	drop if interview__key=="78-44-90-08"
	drop if interview__key=="53-34-09-69"
	drop if interview__key=="04-54-41-67"
	drop if interview__key=="27-70-66-56"
	drop if interview__key=="75-73-21-44"
	drop if interview__key=="37-91-39-01"
	drop if interview__key=="34-43-21-70"
	drop if interview__key=="15-28-40-23"
	drop if interview__key=="51-09-78-72"
	drop if interview__key=="87-61-43-77"
	drop if interview__key=="79-04-82-68"
	drop if interview__key=="99-87-68-73"
	drop if interview__key=="76-79-92-92"
	drop if interview__key=="79-96-32-88"
	drop if interview__key=="78-76-95-00"
	drop if interview__key=="15-52-86-37"
	drop if interview__key=="15-61-77-29"
	drop if interview__key=="01-39-29-74"
	drop if interview__key=="34-10-53-92"
	drop if interview__key=="66-36-72-97"
	drop if interview__key=="90-54-25-17"
	drop if interview__key=="62-51-58-37"
	drop if interview__key=="93-60-24-78"
	drop if interview__key=="41-57-98-91"
	drop if interview__key=="02-55-99-47"
	drop if interview__key=="92-61-35-47"
	drop if interview__key=="37-98-83-75"
	drop if interview__key=="23-43-39-58"
	drop if interview__key=="50-25-16-67"
	drop if interview__key=="10-05-43-54"
	drop if interview__key=="69-45-20-98"
	drop if interview__key=="99-32-98-29"
	drop if interview__key=="01-03-41-15"
	drop if interview__key=="39-28-22-35"
	drop if interview__key=="96-63-88-87"
	drop if interview__key=="95-77-96-09"
	drop if interview__key=="49-83-18-81"
	drop if interview__key=="16-92-46-94"
	drop if interview__key=="88-37-68-90"
	drop if interview__key=="32-57-40-11"
	drop if interview__key=="74-72-10-10"
	drop if interview__key=="68-49-84-99"
	drop if interview__key=="46-15-57-38"
	drop if interview__key=="56-94-04-06"
	drop if interview__key=="24-51-37-28"
	drop if interview__key=="71-41-45-62"
	drop if interview__key=="07-84-50-91"
	drop if interview__key=="15-70-97-76"
	drop if interview__key=="49-01-61-47"
	drop if interview__key=="53-46-41-66"
	drop if interview__key=="52-58-85-31"
	drop if interview__key=="62-34-49-23"
	drop if interview__key=="93-24-99-86"
	drop if interview__key=="66-23-53-69"
	drop if interview__key=="95-57-01-94"
	drop if interview__key=="54-67-16-84"
	drop if interview__key=="41-98-71-28"
	drop if interview__key=="36-75-42-46"
	drop if interview__key=="68-80-72-50"
	drop if interview__key=="77-15-33-48"
	drop if interview__key=="60-51-59-36"
	drop if interview__key=="01-06-82-32"
	drop if interview__key=="05-44-03-52"
	drop if interview__key=="72-99-33-65"
	drop if interview__key=="18-23-00-84"
	drop if interview__key=="37-74-70-33"
	drop if interview__key=="86-59-71-73"
	drop if interview__key=="18-71-79-89"
	drop if interview__key=="12-16-80-04"
	drop if interview__key=="17-81-96-26"
	drop if interview__key=="55-16-09-56"
	drop if interview__key=="47-58-68-23"
	drop if interview__key=="15-87-19-72"
	drop if interview__key=="67-84-79-06"
	drop if interview__key=="19-16-83-15"
	drop if interview__key=="05-62-08-22"
	drop if interview__key=="79-00-14-75"
	drop if interview__key=="28-11-45-95"
	drop if interview__key=="15-84-78-35"
	drop if interview__key=="65-10-91-73"
	drop if interview__key=="58-01-70-47"
	drop if interview__key=="96-92-79-69"
	drop if interview__key=="14-79-05-06"
	drop if interview__key=="73-81-17-14"
	drop if interview__key=="25-92-78-80"
	drop if interview__key=="19-76-07-29"
	drop if interview__key=="06-58-36-09"
	drop if interview__key=="39-43-81-22"
	drop if interview__key=="11-84-77-15"
	drop if interview__key=="22-50-00-71"
	drop if interview__key=="46-88-38-89"
	drop if interview__key=="72-50-30-65"
	drop if interview__key=="55-66-63-09"
	drop if interview__key=="46-23-71-59"
	drop if interview__key=="43-17-02-05"
	drop if interview__key=="05-65-44-75"
	drop if interview__key=="55-07-23-13"
	drop if interview__key=="28-12-39-94"
	drop if interview__key=="44-69-49-88"
	drop if interview__key=="12-04-15-28"
	drop if interview__key=="10-87-07-05"
	drop if interview__key=="63-19-47-43"
	drop if interview__key=="24-48-35-38"
	drop if interview__key=="66-03-24-23"
	drop if interview__key=="66-61-03-40"
	drop if interview__key=="12-01-17-56"
	drop if interview__key=="46-22-04-34"
	drop if interview__key=="01-21-88-97"
	drop if interview__key=="77-98-18-65"
	drop if interview__key=="82-52-72-54"
	drop if interview__key=="44-24-76-86"
	drop if interview__key=="42-16-82-64"
	drop if interview__key=="70-71-85-34"
	drop if interview__key=="73-27-50-44"
	drop if interview__key=="03-23-73-32"
	drop if interview__key=="62-80-77-52"
	drop if interview__key=="82-74-88-12"
	drop if interview__key=="66-99-97-36"
	drop if interview__key=="29-16-17-18"
	drop if interview__key=="37-06-30-70"
	drop if interview__key=="44-23-91-14"


//drop if   
  
 sort  Session_PI Session ID_Participante versao Data ID_Participante


	duplicates tag ID_Participante Nome_participante Formation_PI Session_PI Formation_AG Session, gen(duplicados)
	sort  Session_PI Session ID_Participante versao Data ID_Participante
	bysort ID_Participante Nome_participante Formation_PI Session_PI Formation_AG Session: gen duplica=_n
	tab duplica
	tab duplicados
	drop if duplica>1
	drop duplica duplicados 
	 
	  
	replace Comunidade=upper(Comunidade)
	sort ID_Participante
 
  drop _merge duplicado  
 
  sort ID_Participante
  br ID_Participante Nome_participante Formation_PI Session_PI Formation_AG Session
   replace Nome_District=Distrito 
   replace Provincia="NAMPULA"
    gen Nome_Participante=Nome_participante
	gen Facilitator=Facilitador 
	
	
 
	// Primeira transformação
	replace Session_PI = "Sessao 1" if Session_PI == "Introdução: Pontos-Chave  (Proatividade e Reatividade, Pensar no futuro, Superar obstáculos, Explorar iniciativas pessoais))"
	replace Session_PI = "Sessao 2" if Session_PI == "O processo  empreendedor (Identificando oportunidades de negócio,  Tu e a IP,  Recursos)"
	replace Session_PI = "Sessao 3" if Session_PI == "O Processo Empreendedor Identificando Oportunidades de  Negócio (Mercado,  Avaliação & Comentários)"
	replace Session_PI = "Sessao 4" if Session_PI == "O Processo  Empreendedor Definição de Metas,  Planejamento"
	replace Session_PI = "Sessao 5" if Session_PI == "O Processo Empreendedor (Planejamento: Arranjar financiamento,  Estabelecer ligações,  Monitorar o progresso,  Contabilidade &amp;  Poupança)"
	replace Session_PI = "Sessao 5" if Session_PI == "O Processo Empreendedor (Planejamento: Arranjar financiamento,  Estabelecer ligações,  Monitorar o progresso,  Contabilidade &  Poupança)"
	replace Session_PI = "Sessao 6" if Session_PI == "O Processo  Empreendedor (Comentários:  Experimentar, Erros)"
	replace Session_PI = "Sessao 7" if Session_PI == "Iniciativa Pessoal (Superar Obstáculos - Ténicas de resolução de  problemas)"
	replace Session_PI = "Sessao 8" if Session_PI == "Iniciativa Pessoal (Superar obstáculos - Técnicas de resolução de  problemas)"
	replace Session_PI = "Sessao 9" if Session_PI == "Revisão"
	replace Session_PI = "Sessao 3" if Session_PI == "O Processo Empreendedor Identificando Oportunidades de  Negócio (Mercado,  Avaliação &amp; Comentários)"

// Segunda transformação
	replace Session = "Sessao 1" if Session == "Abordagem sobre principios basicos de implementação de FFS"
	replace Session = "Sessao 2" if Session == "Criterios de Identificação de areas para estabelecimento dos FFS (DRP)"
	replace Session = "Sessao 3" if Session == "Demarcaçao de campos de(Parcelas para monocultura e culturas de consorciação)"
	replace Session = "Sessao 4" if Session == "Sessões de demonstração de diversas técnicas de sementeira"
	replace Session = "Sessao 5" if Session == "Sessões de Controlo de pragas e Infestantes (produção de pesticidas botanicos)"
	replace Session = "Sessao 6" if Session == "Sessões de Monitoria de campos (estagio fenologico da cultura)Tecnica de AESA"
	replace Session = "Sessao 7" if Session == "Tecnicas de cuidados pre colheita, colheita e pos colheita (PHM)"
	replace Session = "Sessao 8" if Session == "Abordagem do Sistema de Desenvolvimento de Mercados (Ligação com o mercado)"
	// Substituir facilitadores para IDs correspondentes
 
save "$caminho\Presencas_clear.dta" , replace 
//replace Comunidade = regexr(Comunidade, " ", "")
* Verificar o resultado
  
 
  
	drop Formation_AG Session
	drop if Formation_PI=="Nao" 
	ren Presenca Presenca_PI
	drop if Nome_participante==""
	save "$caminho\Presencas_PI.dta" , replace 

	use "$caminho\Presencas_clear.dta", clear 
	drop Formation_PI Session_PI
	drop if Formation_AG=="Nao"
	ren Presenca Presenca_AG
	drop if Nome_participante==""
	save "$caminho\Presencas_AG.dta" , replace 

	merge m:m ID_Participante using "$caminho\Presencas_PI.dta"
	drop _merge
	save "$caminho\Presencas_clear.dta" , replace 

 
 * Carregar os dados do Excel
 
import excel "$caminho\Lista de presença Ribáuè .xlsx", sheet("folha") firstrow allstring clear
ren ID ID_Participante

 
save `ribaue_presenca', replace 

  foreach i in 1 2 3 4 5 6 {
  use `ribaue_presenca', clear 
  keep Nome ID_Participante Distrito Comunidade sexo SessaoPI`i'
  //gen Tipo_sessao="PI"
  //gen Nome_sessao="Sessao `i'"
  gen Session_PI="Sessao `i'"
  gen Formation_PI="Sim"

  ren SessaoPI`i' Presenca 
/// save `i', replace
save "tempfile`i'", replace
  }

  * Juntar os arquivos temporários usando append
	append using "tempfile1.dta"
	append using "tempfile2.dta"
	append using "tempfile3.dta"
	append using "tempfile4.dta"
	append using "tempfile5.dta"
//append using "tempfile6.dta"

	replace Presenca=upper(Presenca)
	replace Presenca="Sim" if Presenca=="P " | Presenca=="P" | Presenca==" P"
	replace Presenca="Nao" if Presenca=="F"
	replace Distrito="Ribaue"
	replace Distrito=upper(Distrito)

	merge m:m ID_Participante using "$caminho\Lista_Nampula_Kufugula.dta"
	keep if _merge==3
	drop _merge Nome 
	replace sexo="FEMININO" if sexo=="F"
	replace sexo="MASCULINO" if sexo=="M"
	replace Sexo="FEMININO" if Nome_participante=="JORDANIA FELISBERTO"
	replace Sexo="MASCULINO"  if Nome_participante=="MANUEL ANTONIO"
	drop sexo
	 ren Presenca Presenca_PI
	save `PI', replace 

*****************************************************
use `ribaue_presenca', clear 

  foreach i in 1 2 3 4 5 6  {
  use `ribaue_presenca', clear 
  keep Nome ID_Participante Distrito Comunidade sexo SessaoAG`i'
  //gen Tipo_sessao="AG"
  //gen Nome_sessao="Sessao `i'"
  gen Session="Sessao `i'"
  ren SessaoAG`i' Presenca
  gen Formation_AG="SIM"
/// save `i', replace
save "tempfileAG`i'", replace
  }

  * Juntar os arquivos temporários usando append
	append using "tempfileAG1.dta"
	append using "tempfileAG2.dta"
	append using "tempfileAG3.dta" 
	append using "tempfileAG4.dta"
	append using "tempfileAG5.dta"
//append using "tempfile6.dta"

	replace Presenca=upper(Presenca)
	replace Presenca="Sim" if Presenca=="P " | Presenca=="P" | Presenca==" P"
	replace Presenca="Nao" if Presenca=="F"

	replace Presenca="Sim" if Presenca==" P" | Presenca=="P" | Presenca==" P"
	replace Presenca="Nao" if Presenca==" F"

	replace Distrito="Ribaue"
	replace Distrito=upper(Distrito)

	merge m:m ID_Participante using "$caminho\Lista_Nampula_Kufugula.dta"
	keep if _merge==3
	drop _merge Nome 
	replace sexo="FEMININO" if sexo=="F"
	replace sexo="MASCULINO" if sexo=="M"
	replace Sexo="FEMININO" if Nome_participante=="JORDANIA FELISBERTO"
	replace Sexo="MASCULINO"  if Nome_participante=="MANUEL ANTONIO"
	drop sexo
	ren Presenca Presenca_AG
	merge m:m ID_Participante using `PI'
	gen com=1
	replace com=0 if Presenca_AG==Presenca_PI
	 drop _merge
	 
	//  foreach i in  Formation_PI Session_PI Formation_AG Session Presenca_AG Presenca_PI {
	// ren `i'  `i'_1
//	}

save `Ribaue', replace
******************************************
* Carregar os dados do Excel
 ******************************************
	import excel "$caminho\Lista Monapo.xlsx", sheet("Sheet1") firstrow allstring clear
	ren ID ID_Participante

 
   save `monapo_presenca', replace 
 
   foreach i in 1 2 3 4  {
   use `monapo_presenca', clear 
   keep Nome ID_Participante Distrito Comunidade SessaoPI_`i'
  //gen Tipo_sessao="PI"
  //gen Nome_sessao="Sessao `i'"
   gen Session_PI="Sessao `i'"
   gen Formation_PI="Sim"

   ren SessaoPI_`i' Presenca 
/// save `i', replace 
	save "tempfileMonapo`i'", replace
  }

  * Juntar os arquivos temporários usando append
	append using "tempfileMonapo1.dta"
	append using "tempfileMonapo2.dta"
	append using "tempfileMonapo3.dta"
	append using "tempfileMonapo4.dta"
 
//append using "tempfile6.dta"
 
	replace Presenca=upper(Presenca)
	replace Presenca="Sim" if Presenca=="P " | Presenca=="P" | Presenca==" P"
	replace Presenca="Nao" if Presenca=="F"
	replace Distrito="Monapo"
	replace Distrito=upper(Distrito)

merge m:m ID_Participante using "$caminho\Lista_Nampula_Kufugula.dta"

 
	keep if _merge==3
	drop _merge Nome 
	 
	//drop sexo
	ren Presenca Presenca_PI
	save `PI_monapo', replace 

*****************************************************
	use `monapo_presenca', clear 
	 
	  foreach i in 1 2 3 4   {
	  use `monapo_presenca', clear 
	  keep Nome ID_Participante Distrito Comunidade SessaoAG_`i'
	  //gen Tipo_sessao="AG"
	  //gen Nome_sessao="Sessao `i'"
	  gen Session="Sessao `i'"
	  ren SessaoAG_`i' Presenca
	  gen Formation_AG="SIM"
	/// save `i', replace
	  save "tempfileAGmonapo`i'", replace
	  }
	 
  * Juntar os arquivos temporários usando append
	  append using "tempfileAGmonapo1.dta"
	  append using "tempfileAGmonapo2.dta"
	  append using "tempfileAGmonapo3.dta" 
	  append using "tempfileAGmonapo4.dta"
 
//append using "tempfile6.dta" 

	replace Presenca=upper(Presenca)
	replace Presenca="Sim" if Presenca=="P " | Presenca=="P" | Presenca==" P"
	replace Presenca="Nao" if Presenca=="F"

	replace Presenca="Sim" if Presenca==" P" | Presenca=="P" | Presenca==" P"
	replace Presenca="Nao" if Presenca==" F"

	replace Distrito="Monapo"
	replace Distrito=upper(Distrito)

	merge m:m ID_Participante using "$caminho\Lista_Nampula_Kufugula.dta"
	keep if _merge==3

	  
	drop _merge Nome 
	 
	ren Presenca Presenca_AG
	merge m:m ID_Participante using `PI_monapo'
	gen com=1
	replace com=0 if Presenca_AG==Presenca_PI
	 drop _merge

	// foreach i in  Formation_PI Session_PI Formation_AG Session Presenca_AG Presenca_PI {
	 //ren `i'  `i'_1
	//}
	 
	  
	save `monapo', replace
	merge m:m ID_Participante using `Ribaue'
	drop _merge
	//gen identificador =ID_Participante +Session_PI_1  +Session_1
	//sort ID_Participante Session_PI_1 Session_1
	save `geral', replace 
	
	 
	******************************************
	use "$caminho\Presencas_clear.dta", clear 
	
	  
	//drop if Distrito=="MONAPO"
	replace ID_Participante="KM5000" if Nome_participante=="GENITA S. ASSUATE"
	replace ID_Participante="KM6000" if Nome_participante=="OLIVIA RAFAEL"
	save "$caminho\Presencas_clear.dta", replace
	 
	sort ID_Participante Session_PI Session
	 
	merge m:m ID_Participante using `geral'
//	append  using `geral'
	//drop _merge
	  
	  
	 
	 //foreach i in  Formation_PI Session_PI Formation_AG Session Presenca_AG Presenca_PI {
	 //ren `i'  `i'_1
	//}
	 
	  
	 
	ex
	replace Session_PI="Sessao " + string(dup) 
	replace Session="Sessao " + string(dup) 
	  
	duplicates tag ID_Participante Nome_participante Formation_PI Session_PI Formation_AG Session, gen(duplicados)
	sort  Session_PI Session ID_Participante versao Data ID_Participante
	bysort ID_Participante Nome_participante Formation_PI Session_PI Formation_AG Session: gen duplica=_n
	
	  
	drop if duplica>1
	
 
	save "$caminho\Presencas_clear.dta", replace 


 
ex 

 
 

 
