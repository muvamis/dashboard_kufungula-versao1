clear all 
 
tempfile geral
 
 use "C:\Users\MUVA\OneDrive\Projectos Rstudio\2023\dashboard_kufungula-versao1\Data\Raw\Versao 3\Presencas.dta", clear 
 
 append using "C:\Users\MUVA\OneDrive\Projectos Rstudio\2023\dashboard_kufungula-versao1\Data\Raw\Versao 5\Presencas.dta" 
  append using "C:\Users\MUVA\OneDrive\Projectos Rstudio\2023\dashboard_kufungula-versao1\Data\Raw\Versao 6\Presencas.dta" 
 
  
 foreach i in Nome_Participante Provincia Nome_District Comunidade Facilitator Formation_PI Session_PI Formation_AG Session ID_Participante Turma Presenca Reposicao_sessao {
   decode `i' , generate(`i'_1) 
   drop `i'
   ren `i'_1 `i' 

}

drop interview__key interview__id Imagem sssys_irnd has__errors interview__status assignment__id

//drop if Nome_Participante=="" | Presenca==""
sort  Nome_Participante

/// Tratar duplicados duplicados e apagar
replace Facilitator="Marlene João Alfredo" if Nome_Participante=="Agira P. Pastola"
 
////
//bysort Nome_Participante ID_Participante Session_PI Session Presenca : gen duplicados_delete= cond(_n > 1, 1, 0)

  
//drop if duplicados_delete>0
//drop duplicados_delete
 
//tab duplicados_delete
//drop duplicados_delete


bysort Nome_Participante ID_Participante Session_PI Session: gen duplicados = cond(_N> 1, 1, 0)
tab duplicados

save `geral', replace

//// Imprimir tabela de duplicados
keep if duplicados==1

 

save "C:\Users\MUVA\OneDrive\Projectos Rstudio\2023\dashboard_kufungula-versao1\Data\duplicados.dta" , replace 



use `geral', clear 
///Tabela de dados ausentes
gen dado_ausente=0
replace dado_ausente=1 if   Nome_Participante=="" | ID_Participante=="" | Session_PI=="" | Session=="" | Presenca=="" 
save `geral', replace

keep if dado_ausente==1
save "C:\Users\MUVA\OneDrive\Projectos Rstudio\2023\dashboard_kufungula-versao1\Data\ausente_data.dta" , replace 


use `geral', clear

//drop if duplicados==1 
drop if dado_ausente==1
drop duplicados dado_ausente
bysort Nome_Participante ID_Participante Session_PI Session: gen duplicados = _n
tab duplicados
 
 
 bysort Nome_Participante: gen duplicados_name= _n
 tab duplicados_name
 
save `geral', replace 
 
import excel "C:\Users\MUVA\OneDrive\Projectos Rstudio\2023\dashboard_kufungula-versao1\Data\Lista_Selecionados_Kufungula.xlsx", sheet("Sheet 1") firstrow clear
merge m:m ID_Participante using  `geral'
drop _merge

save "C:\Users\MUVA\OneDrive\Projectos Rstudio\2023\dashboard_kufungula-versao1\Data\Presencas_clear.dta" , replace 

 ex
reshape wide presenca, i(ID_Participante) j(Session)
ex
   

br

 

 
