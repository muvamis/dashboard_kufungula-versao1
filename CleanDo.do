clear all 
 
 global caminho  "C:\Users\MUVA\OneDrive - ASSOCIAÇÃO PARA O EMPODERAMENTO DA RAPARIGA-MUVA\DEPARTAMENTO MIS\DEPARTAMENTO MIS\PROJECTOS\SISTEMA DE MONITORIA\Kufungula\dashboard_kufungula-versao1\Data"
 tempfile geral nao_desistente perfildio desistente_monapo
  
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
  //ren Facilitator Fa
 foreach i in Nome_Participante Provincia Nome_District Comunidade Facilitator Formation_PI Session_PI Formation_AG Session ID_Participante Turma Presenca Reposicao_sessao interview__status {
   decode `i' , generate(`i'_1) 
   drop `i'
   ren `i'_1 `i' 

} 
 
  

 drop if Nome_District=="Ribaue" & versao!=9 // Verificar 
 
   
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
 
 // bysort ID_Participante Nome_participante Formation_PI Session_PI	Formation_AG	Session	: gen max_sessao=_n
  
  replace Comunidade=upper(Comunidade)
  
  sort ID_Participante

 
 br if inlist(interview__key, "18-19-80-09", "89-99-17-55", "81-28-65-55", "93-81-29-49" , "97-89-99-37")
   
  bysort ID_Participante Nome_participante Formation_PI Session_PI Formation_AG Session: gen max_sessao=_n
  
   drop if max_sessao>1
   
  sort  ID_Participante 
  
  drop _merge
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
 

//replace Comunidade = regexr(Comunidade, " ", "")
* Verificar o resultado

 
  
save "$caminho\Presencas_clear.dta" , replace 

 ex
 

 
