  clear all 
  
  global caminho  "C:\Users\MUVA\OneDrive - ASSOCIAÇÃO PARA O EMPODERAMENTO DA RAPARIGA-MUVA\DEPARTAMENTO MIS\DEPARTAMENTO MIS\PROJECTOS\SISTEMA DE MONITORIA\Kufungula\dashboard_kufungula-versao1\Data"
  global raw  "C:\Users\MUVA\OneDrive - ASSOCIAÇÃO PARA O EMPODERAMENTO DA RAPARIGA-MUVA\DEPARTAMENTO MIS\DEPARTAMENTO MIS\PROJECTOS\SISTEMA DE MONITORIA\Kufungula\dashboard_kufungula-versao1\Data\Raw"

 tempfile geral geral_PI geral_AG PI AG
   
 use "$caminho\Lista_Nampula_Kufugula.dta", clear
 drop if Nome_participante=="ALGlRA MACARlO"

  replace Nome_participante="ACACIO ΑLΒΑΝΟ" if Nome_participante=="ACAClO ΑLΒΑΝΟ"
replace ID_Participante="ΚΜ2052" if Nome_participante=="ACACIO ΑLΒΑΝΟ"
 replace ID_Participante = subinstr(ID_Participante, "O", "0", .)
  replace ID_Participante = subinstr(ID_Participante, " ", "", .)
  replace ID_Participante = subinstr(ID_Participante, "o", "0", .)
  replace Nome_participante=trim(Nome_participante)
  replace ID_Participante=trim(ID_Participante)
  replace  ID_Participante="KM1169" if  Nome_participante== "ALEX JUNIOR" 
  replace ID_Participante="KM2052" if Nome_participante=="ACáCIO ΑLΒΑΝΟ" & Distrito=="Monapo" & Comunidade=="Carapira"
  replace ID_Participante="KM2060" if Nome_participante=="ALGIRA MACARIO" & Distrito=="Monapo" & Comunidade=="Carapira"
  replace ID_Participante="KM2056" if Nome_participante=="ANGELINA VICTOR" & Distrito=="Monapo" & Comunidade=="Carapira"
  replace ID_Participante="KM2061" if Nome_participante=="CRISTlNA ERNESTO" & Distrito=="Monapo" & Comunidade=="Carapira"
  replace ID_Participante="KM2062" if Nome_participante=="DERCIA LUIS" & Distrito=="Monapo" & Comunidade=="Carapira"
  replace ID_Participante="KM2199" if Nome_participante=="ELGlDlO LUIS JORGE" & Distrito=="Monapo" & Comunidade=="Carapira"
  replace ID_Participante="KM2057" if Nome_participante=="HILARIO RODRIGUES" & Distrito=="Monapo" & Comunidade=="Carapira"
  replace ID_Participante="KM2063" if Nome_participante=="OSVALDO ΡΑULIΝΟ" & Distrito=="Monapo" & Comunidade=="Carapira"
  replace ID_Participante="KM2200" if Nome_participante=="ΒΟΝIFACIO AGOSTlNHO" & Distrito=="Monapo" & Comunidade=="Carapira"
  
  replace Distrito=upper(Distrito)
    replace Comunidade = upper(Comunidade)

	    replace Sexo="FEMININO" if Nome_participante=="ESMERALDA S. MOMADE"
	replace Sexo="FEMININO" if inlist(Nome_participante, "MARINA DOMINGOS", "SOFIA VALENTIM","TONIHA ALVARO", "GENITA DANIEL")
	replace Sexo="MASCULINO" if Nome_participante=="RAIMUNDO J SARAIVA"
	
	replace Sexo="FEMININO" if inlist(Nome_participante, "VANEZA NERANE" , "CRlSTlNA ERNESTO", "DERCIA LUIS", "ANGELINA VICTOR")
	replace Sexo="MASCULINO" if inlist(Nome_participante, "ACACIO ΑLΒΑΝΟ" , "OSVALDO ΡΑULIΝΟ", "ELGlDlO LUIS JORGE", "ΒΟΝIFACIO AGOSTlNHO", "HILARIO RODRIGUES")
	
	
	








 

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
 
  

  save "$caminho\Lista_Nampula_Kufugula.dta", replace 
  save `geral', replace
 

 
  ///importar dados de presenca Nampula
  import excel "$raw\Lista de Presenças Kufungula actual.xlsx", sheet("Sheet1") firstrow clear 
  sort Nome
 
 replace ID = subinstr(ID, "O", "0", .)
  replace ID = subinstr(ID, " ", "", .)
  replace ID = subinstr(ID, "o", "0", .)
  replace Nome=trim(Nome)
  replace ID=trim(ID)
 
  replace ID = "KM" + substr(ID, 3, .)
  gen numero_caracteres = strlen(ID)
  replace ID = "KM" + substr(ID, 4, .) if numero_caracteres>6
  replace numero_caracteres = strlen(ID)
    
   replace Nome="ANGELINA VICTOR." if ID=="KM0014"


  replace ID="KM2052" if Nome=="ACáCIO ΑLΒΑΝΟ" & Distrito=="Monapo" & Comunidade=="Carapira"
  replace ID="KM2060" if Nome=="ALGIRA MACARlO" & Distrito=="Monapo" & Comunidade=="Carapira"
  replace ID="KM2056" if Nome=="ANGELINA VICTOR" & Distrito=="Monapo" & Comunidade=="Carapira"
  replace ID="KM2061" if Nome=="CRISTINA ERNESTO" & Distrito=="Monapo" & Comunidade=="Carapira"
  replace ID="KM2062" if Nome=="DERCIA LUIS" & Distrito=="Monapo" & Comunidade=="Carapira"
  replace ID="KM2199" if Nome=="ELGIDIO LUIS JORGE" & Distrito=="Monapo" & Comunidade=="Carapira"
  replace ID="KM2057" if Nome=="HILARIO RODRIGUES" & Distrito=="Monapo" & Comunidade=="Carapira"
  replace ID="KM2063" if Nome=="OSVALDO ΡΑULIΝΟ" & Distrito=="Monapo" & Comunidade=="Carapira"
  replace ID="KM2200" if Nome=="ΒΟΝIFACIO AGOSTlNHO" & Distrito=="Monapo" & Comunidade=="Carapira"
  
   replace Nome="ACACIO ΑLΒΑΝΟ" if Nome=="ACAClO ΑLΒΑΝΟ"
   replace ID="ΚΜ2052" if Nome=="ACACIO ΑLΒΑΝΟ"
 
 
  ren Nome Nome_participante
  ren ID ID_Participante
  replace Nome=upper(Nome) // Colocando em maisculo
 
  drop if Nome_participante=="TANIA JULIO MUSSEQUERE" & ID_Participante=="KM0085"
  drop if Nome_participante=="JORDâNIA FELISBERTO" & ID_Participante=="KM0577"
  drop if Nome_participante=="FELICIANO HENRIQUE" & ID_Participante=="KM0559"
 drop if Nome_participante=="LIDIA CELESTINO"	& SessaoPI_2=="F"
	 drop if Nome_participante=="LIONORA HENRIQUES"	 & ID_Participante=="KM1064"
   drop if Nome_participante=="DELFINA GONçALVES" & SessaoPI_2=="F"

	* Substituir acentos
	replace Nome_participante = regexr(Nome_participante, "á|Á", "A")
	replace Nome_participante = regexr(Nome_participante, "é|É", "E")
	replace Nome_participante = regexr(Nome_participante, "í|Í", "I")
	replace Nome_participante = regexr(Nome_participante, "ó|Ó", "O")
	replace Nome_participante = regexr(Nome_participante, "ú|Ú", "U")
	replace Nome_participante = regexr(Nome_participante, "à|À", "A")
	replace Nome_participante = regexr(Nome_participante, "è|È", "E")
	replace Nome_participante = regexr(Nome_participante, "ì|Ì", "I")
	replace Nome_participante = regexr(Nome_participante, "ò|Ò", "O")
	replace Nome_participante = regexr(Nome_participante, "ù|Ù", "U")
	replace Nome_participante = regexr(Nome_participante, "ã|Ã", "A")
	replace Nome_participante = regexr(Nome_participante, "õ|Õ", "O")
	replace Nome_participante = regexr(Nome_participante, "â|Â", "A")
	replace Nome_participante = regexr(Nome_participante, "ê|Ê", "E")
	replace Nome_participante = regexr(Nome_participante, "î|Î", "I")
	replace Nome_participante = regexr(Nome_participante, "ô|Ô", "O")
	replace Nome_participante = regexr(Nome_participante, "û|Û", "U")
	replace Nome_participante = regexr(Nome_participante, "ä|Ä", "A")
	replace Nome_participante = regexr(Nome_participante, "ë|Ë", "E")
	replace Nome_participante = regexr(Nome_participante, "ï|Ï", "I")
	replace Nome_participante = regexr(Nome_participante, "ö|Ö", "O")
	replace Nome_participante = regexr(Nome_participante, "ü|Ü", "U")
	replace Nome_participante = regexr(Nome_participante, "ç|Ç", "C")
	replace Nome_participante = regexr(Nome_participante, "ñ|Ñ", "N")
	replace Nome_participante = trim(Nome_participante)

 drop if Nome_participante=="SONIA VICTOR ANTONIO" & ID_Participante=="KM1180"
replace ID_Participante="KM2117" if Nome_participante=="SUMALIA ADRIANO"	& ID_Participante=="KM2118"

 drop if Nome_participante=="MELITA FRANCISCO" & SessaoPI_5=="F"



 
  replace ID_Participante="KM2235" if Nome_participante=="ANCHA FERNANDO"
  replace ID_Participante="KM2234" if Nome_participante=="ANGELICA JOSE"
  //replace ID_Participante="" if Nome_participante==""
  duplicates report ID_Participante
  duplicates tag  ID_Participante, gen(dup)
  tab dup
  sort ID_Participante
  br if dup==1
  
  ******************Eliminando duplicados***********
  drop if dup==1
  ********************************************
  drop dup
  
   
 merge m:m ID_Participante using  "$caminho\Lista_Nampula_Kufugula.dta" 
 
 
 replace Distrito =upper(Distrito)
 keep if _merge==3
 drop numero_caracteres _merge
 foreach i in SessaoPI_1 SessaoPI_2 SessaoPI_3 ///
 SessaoPI_4 SessaoPI_5 SessaoPI_6 SessaoPI_7 SessaoPI_8 ///
 SessaoPI_9 SessaoAG_1 SessaoAG_2 SessaoAG_3 SessaoAG_4 SessaoAG_5 ///
 SessaoAG_6 SessaoAG_7 SessaoAG_8 SessaoAG_9{
 
tostring `i', replace
 replace `i'=upper(`i')
 replace `i'="F" if `i'==""
 replace `i'="F" if `i'=="."
 }
 
 save `geral_PI', replace 
 
 
 foreach i in 1 2 3 4 5 6 7 8 9 {
 use `geral_PI', clear 
 
  keep Nome_participante ID_Participante Distrito Comunidade ///
  SessaoPI_`i' Sexo Provincia Idade Posto_Administrativo Facilitador Deslocado Estado_saúde Actividade Faz_venda Culturas_praticadas_técnica Culturas_técnica_Milho Culturas_técnica_Gergelim Culturas_técnica_Mandioca Mercado_frequentado Mercado_Insumos Mercado_Produtos Mercado_Ambos Nomeecontactodoanimador Contacto Associação ContactoAnimador Província Nome_District Desistencia Data_nascimento Nome_Participante Facilitadores
  //gen Tipo_sessao="PI"
  //gen Nome_sessao="Sessao `i'"
  gen Session_PI="Sessao `i'"
  gen Formation_PI="Sim"

  ren SessaoPI_`i' Presenca 
/// save `i', replace
save "tempfile`i'", replace
  }

  * Juntar os arquivos temporários usando append
	append using "tempfile1.dta"
	append using "tempfile2.dta"
	append using "tempfile3.dta"
	append using "tempfile4.dta"
	append using "tempfile5.dta"
	append using "tempfile6.dta"
	append using "tempfile7.dta"
	append using "tempfile8.dta"
	
	
	
	replace Presenca=upper(Presenca)
	replace Presenca="Sim" if Presenca=="P " | Presenca=="P" | Presenca==" P"
	replace Presenca="Nao" if Presenca=="F"
	replace Presenca="Nao" if Presenca==" F"
	replace Presenca="Nao" if Presenca=="F "
	
	ren Presenca Presenca_PI 
save `PI', replace 

 
erase "tempfile1.dta"
erase "tempfile2.dta"
erase "tempfile3.dta"
erase "tempfile4.dta"
erase "tempfile5.dta"
erase "tempfile6.dta"
erase "tempfile7.dta"
erase "tempfile8.dta"
erase "tempfile9.dta"

foreach i in 1 2 3 4 5 6 7 8 9 {
 use `geral_PI', clear 
 
  keep Nome_participante ID_Participante Distrito Comunidade ///
  SessaoAG_`i' Sexo Provincia Idade Posto_Administrativo Facilitador Deslocado Estado_saúde Actividade Faz_venda Culturas_praticadas_técnica Culturas_técnica_Milho Culturas_técnica_Gergelim Culturas_técnica_Mandioca Mercado_frequentado Mercado_Insumos Mercado_Produtos Mercado_Ambos Nomeecontactodoanimador Contacto Associação ContactoAnimador Província Nome_District Desistencia Data_nascimento Nome_Participante Facilitadores
  //gen Tipo_sessao="PI"
  //gen Nome_sessao="Sessao `i'"
  gen Session="Sessao `i'"
  gen Formation_AG="Sim"

  ren SessaoAG_`i' Presenca 
/// save `i', replace
save "tempfile`i'", replace
  }

  * Juntar os arquivos temporários usando append
	append using "tempfile1.dta"
	append using "tempfile2.dta"
	append using "tempfile3.dta"
	append using "tempfile4.dta"
	append using "tempfile5.dta"
	append using "tempfile6.dta"
	append using "tempfile7.dta"
	append using "tempfile8.dta"
	
	
	replace Presenca = trim(Presenca)
	replace Presenca=upper(Presenca)
	replace Presenca="Sim" if Presenca=="P " | Presenca=="P" | Presenca==" P" | Presenca==" P "
	replace Presenca="Nao" if Presenca=="F"
	replace Presenca="Nao" if Presenca==" F"
	replace Presenca="Nao" if Presenca=="F "
	
	ren Presenca Presenca_AG
save `AG', replace 

 
erase "tempfile1.dta"
erase "tempfile2.dta"
erase "tempfile3.dta"
erase "tempfile4.dta"
erase "tempfile5.dta"
erase "tempfile6.dta"
erase "tempfile7.dta"
erase "tempfile8.dta"
erase "tempfile9.dta"
 
merge m:m ID_Participante using `PI' 
 tab Presenca_PI Presenca_AG
  
 
  replace Distrito=upper(Distrito)
  
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
 
   
   *Retificar duplicados 
   //replace ID="KM..." if Nome_participante=="TANIA JULIO MUSSEQUERE
   
   
   
    replace Sexo="FEMININO" if Nome_participante=="ESMERALDA S. MOMADE"
	replace Sexo="FEMININO" if inlist(Nome_participante, "MARINA DOMINGOS", "SOFIA VALENTIM","TONIHA ALVARO", "GENITA DANIEL")
	replace Sexo="MASCULINO" if Nome_participante=="RAIMUNDO J SARAIVA"

 






     duplicates tag  ID_Participante, gen(dup)
  tab dup
  sort ID_Participante
  br if dup==1
  drop dup
  br if Sexo==""
	save "$caminho\Presencas_clear.dta", replace 
   

 
ex 

 
 

 
