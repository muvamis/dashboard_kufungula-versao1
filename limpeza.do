clear all 
  
tempfile 1 2 Geral geral Ribaue MonapoID Monapo

//adicionando a base geral 
import excel "C:\Users\MUVA\OneDrive\Projectos Rstudio\2023\dashboard_kufungula-versao1\Data\Lista_Selecionados_Kufungula.xlsx", sheet("Sheet 1") firstrow clear
gen identificador=Nome_participante+string(Data_nascimento)+Comunidade
bysort identificador: gen dup=_n
drop if dup>1
drop dup identificador
gen identificador=Nome_participante+ID_Participante
save `Geral', replace 
save `geral', replace 
 
import excel "C:\Users\MUVA\OneDrive\Projectos Rstudio\2023\dashboard_kufungula-versao1\Data\Kufungula.xlsx", sheet("Participantes_Selecionados") firstrow clear

gen identificador=Nome_participante+string(Data_nascimento)+Comunidade

append using `geral'
bysort identificador: gen dup=_n
drop if dup>1
drop dup
save `geral', replace 

 //adicionando as bases extras 
import excel "C:\Users\MUVA\OneDrive\Projectos Rstudio\2023\dashboard_kufungula-versao1\Data\Raw\Cópia de Lista de Participantes a serem inseridos no sistema-Ribaue.xlsx", sheet("Folha1") firstrow clear
tostring Nomeecontactodoanimador, replace
 save `1', replace

import excel "C:\Users\MUVA\OneDrive\Projectos Rstudio\2023\dashboard_kufungula-versao1\Data\Raw\Cópia de Lista de Participantes que ja estao no sistema - Ribaue.xlsx", sheet("Folha1") firstrow clear
tostring Nomeecontactodoanimador, replace
destring Idade, replace
append using `1'
save `1', replace
 
import excel "C:\Users\MUVA\OneDrive\Projectos Rstudio\2023\dashboard_kufungula-versao1\Data\Raw\Novos participantes Ribaue.xlsx", sheet(" 1º de maio") firstrow clear
//destring Idade, replace
replace Idade = substr(Idade, 1, 2)
destring Idade, replace
 
append using `1'
ren Nomedoparticipante Nome_participante 
gen identificador=Nome_participante+string(Idade)+Comunidade+string(Anodenascimento)
save `1', replace

append using `geral'
save `geral', replace 

/////////////////////////monapo/////////////////////////

 import excel "C:\Users\MUVA\OneDrive\Projectos Rstudio\2023\dashboard_kufungula-versao1\Data\Raw\lista_IDS.xlsx", sheet("Sheet1") firstrow clear

drop if Distrito=="Ribaue"
ren ID ID_Participante
ren Nome_Participante Nome_participante
save `MonapoID'
 
import excel "C:\Users\MUVA\OneDrive\Projectos Rstudio\2023\dashboard_kufungula-versao1\Data\Lista_monapoo.xlsx", sheet("Sheet1") firstrow clear
 ren Nomedoparticipante Nome_participante
 ren Sexo sexo
foreach i in  ContactoAnimador Nomeecontactodoanimador ///
 Contacto Édeslocado MercadofrequentadoAmbos ///
 MercadofrequentadoProdutos MercadofrequentadoInsumos ///
 Mercadofrequentado Fazvenda Mandioca Gergelim Milho Culturaspraticadascomtécnica ///
 Actividade Estadodesaúde Idade sexo Nome_participante Associação Comunidade ///
 PostoAdministrativo Distrito Província {
 ren `i' `i'_1
 
 }
merge m:m ID_Participante using `MonapoID'
drop _merge 
merge m:m ID_Participante using `Geral'
replace Deslocado=Édeslocado_1 if Deslocado==""
replace Idade = Idade_1 if Idade==.
drop Idade_1
replace Milho_1=Culturas_técnica_Milho if Milho_1==.
drop Culturas_técnica_Milho
replace Gergelim_1=Culturas_técnica_Gergelim if Gergelim_1==.
drop Culturas_técnica_Gergelim
replace  Mandioca_1=Culturas_técnica_Mandioca if Mandioca_1==. 
drop Culturas_técnica_Mandioca
replace Deslocado=Édeslocado_1 if Deslocado==""
replace Mercado_Insumos=MercadofrequentadoInsumos_1 if Mercado_Insumos==.
replace Mercado_Produtos=MercadofrequentadoProdutos_1 if Mercado_Produtos==.
replace Mercado_Ambos=MercadofrequentadoAmbos_1  if Mercado_Ambos==.
drop MercadofrequentadoInsumos_1 MercadofrequentadoProdutos_1 MercadofrequentadoAmbos_1
 replace Mercado_frequentado=Mercadofrequentado_1 if Mercado_frequentado==""

 replace Contacto_1=Contacto if Contacto_1==.
 replace ContactoAnimador_1=ContactoAnimador if ContactoAnimador_1==.
 replace Nomeecontactodoanimador_1=Nomeecontactodoanimador if Nomeecontactodoanimador_1==""
 
 drop ContactoAnimador Contacto Nomeecontactodoanimador
 ren   ContactoAnimador_1 ContactoAnimador
 ren Contacto_1 Contacto
 ren Nomeecontactodoanimador_1 Nomeecontactodoanimador
 
  replace Culturas_praticadas_técnica=Culturaspraticadascomtécnica_1 if Culturas_praticadas_técnica==""
  
replace Faz_venda=Fazvenda_1 if Faz_venda==""
 drop Mercadofrequentado_1 Fazvenda_1 Édeslocado_1 Culturaspraticadascomtécnica_1
foreach i in  sexo Nome_participante  Comunidade Actividade  ///
  Distrito Província PostoAdministrativo Estadodesaúde Associação  {
 replace `i'=`i'_1 if `i'==""
 
 drop `i'_1
 }
drop if _merge==2
order ID_Participante Nome_participante Sexo Provincia Data_nascimento Idade Distrito Posto_Administrativo Comunidade Facilitator Deslocado ///
 Estado_saúde Actividade Faz_venda Culturas_praticadas_técnica Milho_1 Gergelim_1 Mandioca_1 ///
 Mercado_frequentado Mercado_Insumos Mercado_Produtos Mercado_Ambos Nomeecontactodoanimador Contacto  
 sort _merge
 replace Provincia="Nampula"
 replace Distrito="Monapo"

drop value	Associação	identificador	

duplicates tag Nome_participante, generate(dup_tag)
br if dup_tag > 0
 replace Comunidade=upper(Comunidade)
duplicates tag Nome_participante, generate(dup)

 //bysort identificador :  gen dup=_n
 br if dup>0
 
save "C:\Users\MUVA\OneDrive\Projectos Rstudio\2023\dashboard_kufungula-versao1\Data\Lista_Final_Monapo.dta", replace
 
 

import excel "C:\Users\MUVA\OneDrive\Projectos Rstudio\2023\dashboard_kufungula-versao1\Data\Lista Final Ribaue.xlsx", sheet("folha1") firstrow clear

keep NomeCompletodoparticipante ID Sexo Facilitador Distrito Comunidade
ren NomeCompletodoparticipante Nome_participante 
ren ID ID_Participante 
//replace Nome_participante="Angelica Jose Lavaque" if Nome_participante=="Angelica Jose"
//drop if Nome_participante=="Angelica Lavaque"
drop if Nome_participante=="Feliciano Henrique"
//drop if Nome_participante=="Anchita Graciano"
drop if Nome_participante=="Leonora Enriques"
drop if Nome_participante=="Antonio Armando"
drop if Nome_participante=="Sonia Vitor"
drop if Nome_participante=="Jordânia Felisberto"
replace Nome_participante="Angelina Cuchereque" if Nome_participante=="Angelica Cuchereque"
replace ID_Participante="KM2117" if Nome_participante=="Sumalia Adriano"
replace ID_Participante="KM2129" if Nome_participante=="Rosalia Antonio"
//Angelina CucherequeNome_participante
replace Facilitador="Albertina Cualeia" if Nome_participante=="Delfina Gonçalves"
* Assumindo que as variáveis do dataset são 'Nome', 'ID_Participante' e 'Sexo'
replace ID_Participante = "KM2214" if Nome_participante == "Celina Paulino"
replace Sexo = "F" if Nome_participante == "Celina Paulino"

replace ID_Participante = "KM2215" if Nome_participante == "Estelita Antonio"
replace Sexo = "F" if Nome_participante == "Estelita Antonio"

replace ID_Participante = "KM2216" if Nome_participante == "Melita Francisco"
replace Sexo = "F" if Nome_participante == "Melita Francisco"

replace ID_Participante = "KM2217" if Nome_participante == "Lidia Agostinho"
replace Sexo = "F" if Nome == "Lidia Agostinho"

replace ID_Participante = "KM2218" if Nome_participante == "Felismino Daniel"
replace Sexo = "M" if Nome == "Felismino Daniel"

replace ID_Participante = "KM2219" if Nome_participante == "Leandro Simão"
replace Sexo = "M" if Nome == "Leandro Simão"

replace ID_Participante = "KM2220" if Nome_participante == "Ananias Momade"
replace Sexo = "F" if Nome == "Ananias Momade"

replace ID_Participante = "KM2221" if Nome_participante == "Mustefa Omar"
replace Sexo = "M" if Nome_participante == "Mustefa Omar"

replace ID_Participante = "KM2222" if Nome_participante == "Sandra Adelino"
replace Sexo = "F" if Nome_participante == "Sandra Adelino"

replace ID_Participante = "KM2223" if Nome_participante == "Lidia Henriques"
replace Sexo = "F" if Nome_participante == "Lidia Henriques"

replace ID_Participante = "KM2224" if Nome_participante == "Esperança Eusebio"
replace Sexo = "F" if Nome == "Esperança Eusebio"

replace ID_Participante = "KM2225" if Nome_participante == "Sonia Livre"
replace Sexo = "F" if Nome_participante == "Sonia Livre"

replace ID_Participante = "KM2226" if Nome_participante == "Abdul Manuel"
replace Sexo = "M" if Nome == "Abdul Manuel"

replace ID_Participante = "KM2227" if Nome_participante == "Gamito Rocheque"
replace ID_Participante = "KM2228" if Nome_participante == "Alex Junior"
replace ID_Participante = "KM2229" if Nome_participante == "Sandra Victor"
replace ID_Participante = "KM2230" if Nome_participante == "Maimuna da Flora"
replace ID_Participante = "KM2231" if Nome_participante == "Nelsa Calisto"
replace ID_Participante = "KM2232" if Nome_participante == "Aires Júlio"
replace ID_Participante = "KM2233" if Nome_participante == "Jose Júlio"

 * Substitui os valores da variável Nome_participante
replace Nome_participante = "Ancha Fernando" if Nome_participante == "Ancha Fernando"
replace Nome_participante = "Anchita Graciano" if Nome_participante == "Anchita Graciano"
replace Nome_participante = "Angelica J. Laveque" if Nome_participante == "Angelica Lavaque"
replace Nome_participante = "Angelica Jose" if Nome_participante == "Angelica Jose"
replace Nome_participante = "Rosalia Antonio" if Nome_participante == "Rosalia Antonio"
replace Nome_participante = "Rosita Antonio" if Nome_participante == "Rosita Antonio"

* Substitui os valores da variável ID_Participante com base no Nome_participante
replace ID_Participante = "KM0527" if Nome_participante == "Angelica J. Laveque"
replace ID_Participante = "KM0902" if Nome_participante == "Anchita Graciano"
replace ID_Participante = "KM2129" if Nome_participante == "Rosalia Antonio"
replace ID_Participante = "KM1085" if Nome_participante == "Rosita Antonio"
replace ID_Participante = "KM1150" if Nome_participante == "Delfina Gonçalves"
replace ID_Participante = "KM1155" if Nome_participante == "Antonio Armando"
replace ID_Participante = "KM2234" if Nome_participante == "Angelica Jose"
replace ID_Participante = "KM2235" if Nome_participante == "Ancha Fernando"
* Verifica as alterações
list Nome_participante
 
 
sort Nome_participante
 bysort ID_Participante :  gen dup=_n
 br if dup>1
 drop if dup>1
 //drop identificador
 gen identificador=Nome_participante+ID_Participante
   
////////////////////////
ren Nome_participante Nome_participante_origin
merge m:m ID_Participante using `Geral'

 
drop if _merge==2
sort _merge
replace Provincia="Nampula"


replace Nome_participante="Esmeralda Antônio" if ID_Participante=="KM0553"	
replace Nome_participante="Esmeralda L. Maliqueta" if ID_Participante=="KM0554"
replace Nome_participante_origin="Esmeralda Antônio" if ID_Participante=="KM0553"	
replace Nome_participante_origin="Esmeralda L. Maliqueta" if ID_Participante=="KM0554"	

//replace Nome_participante_origin=Nome_participante if ID_Participante=="KM0553" | ID_Participante=="KM0554"
//drop Província
drop Facilitator
replace Nome_participante=upper(Nome_participante)
replace Nome_participante_origin=upper(Nome_participante_origin) 
gen comp=0 
replace comp=1 if  Nome_participante!=Nome_participante_origin & Nome_participante!=""
replace comp=2 if   Nome_participante==""
replace Nome_participante=Nome_participante_origin if comp==1


replace comp=1 if  Nome_participante!=Nome_participante_origin & Nome_participante!=""
replace comp=2 if   Nome_participante==""
replace comp=0 if  Nome_participante==Nome_participante_origin & Nome_participante!=""
replace Nome_participante=Nome_participante_origin if Nome_participante==""

 sort Nome_participante Nome_participante_origin
br Nome_participante Nome_participante_origin  ID_Participante if comp==1
drop _merge 
merge m:m ID_Participante using `Geral'
drop if _merge==2

order ID_Participante Nome_participante Sexo Provincia Data_nascimento Idade Distrito Posto_Administrativo Comunidade Facilitador Deslocado ///
 Estado_saúde Actividade Faz_venda Culturas_praticadas_técnica Culturas_técnica_Milho Culturas_técnica_Gergelim Culturas_técnica_Mandioca ///
 Mercado_frequentado Mercado_Insumos Mercado_Produtos Mercado_Ambos Nomeecontactodoanimador Contacto  
 sort _merge

 replace Facilitador=upper(Facilitador)
 replace Facilitator=upper(Facilitator)
 replace Facilitador=Facilitator if Nome_participante!="TANIA JULIO MUSSEQUERE" & comp==1 
 replace comp=0 if Facilitator==Facilitador
 replace comp=1 if Facilitator!=Facilitador
 replace comp=2 if Facilitator==""
  drop Facilitator Nome_participante_origin dup identificador comp  _merge
 br
 
 export excel using "C:\Users\MUVA\OneDrive\Projectos Rstudio\2023\dashboard_kufungula-versao1\Data\Lista Final Ribaue.xlsx", firstrow(variables) replace

save "C:\Users\MUVA\OneDrive\Projectos Rstudio\2023\dashboard_kufungula-versao1\Data\Lista_Final_Ribaue.dta", replace

 append using "C:\Users\MUVA\OneDrive\Projectos Rstudio\2023\dashboard_kufungula-versao1\Data\Lista_Final_Monapo.dta", replace 
  export excel using "C:\Users\MUVA\OneDrive\Projectos Rstudio\2023\dashboard_kufungula-versao1\Data\Produtores_Kunfugula.xlsx", firstrow(variables) replace

 save "C:\Users\MUVA\OneDrive\Projectos Rstudio\2023\dashboard_kufungula-versao1\Data\Produtores_Kunfugula.dta", replace

 
