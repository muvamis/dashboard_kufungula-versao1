clear all 
 
 
 global caminho  "C:\Users\MUVA\OneDrive - ASSOCIAÇÃO PARA O EMPODERAMENTO DA RAPARIGA-MUVA\DEPARTAMENTO MIS\DEPARTAMENTO MIS\PROJECTOS\SISTEMA DE MONITORIA\Kufungula\dashboard_kufungula-versao1\Data"
tempfile geral
 
 use "$caminho\Raw\Versao 3\Presencas.dta", clear 
 
 append using "$caminho\Raw\Versao 5\Presencas.dta" 
  append using "$caminho\Raw\Versao 6\Presencas.dta" 

  
 foreach i in Nome_Participante Provincia Nome_District Comunidade Facilitator Formation_PI Session_PI Formation_AG Session ID_Participante Turma Presenca Reposicao_sessao {
   decode `i' , generate(`i'_1) 
   drop `i'
   ren `i'_1 `i' 

} 
 
drop Nome_District	Comunidade	Facilitator interview__key interview__id Imagem sssys_irnd has__errors interview__status assignment__id
sort  Nome_Participante
 ren Nome_Participante Nome_participante
 replace Nome_participante=upper(Nome_participante)
 
 merge m:m ID_Participante using "$caminho\Lista_Nampula_Kufugula.dta"
 drop if _merge==1
 replace Presenca="Nao" if _merge==2
  
//export excel using "$caminho\Desistentes.xls" if _merge==1, firstrow(variables) replace
save `geral', replace
 sort ID_Participante
br 
ex
 
bysort Nome_Participante ID_Participante Session_PI Session: gen duplicados = cond(_N> 1, 1, 0)
duplicates tag duplicados Nome_Participante ID_Participante Session_PI Session, gen(dup)
br if dup>0
save `geral', replace
ex
//// Imprimir tabela de duplicados
keep if duplicados==1

 

save "$caminho\duplicados.dta" , replace 



use `geral', clear 
///Tabela de dados ausentes
gen dado_ausente=0
replace dado_ausente=1 if   Nome_Participante=="" | ID_Participante=="" | Session_PI=="" | Session=="" | Presenca=="" 
save `geral', replace

keep if dado_ausente==1
save "$caminho\ausente_data.dta" , replace 


use `geral', clear

//drop if duplicados==1 
drop if dado_ausente==1
drop duplicados dado_ausente
bysort Nome_Participante ID_Participante Session_PI Session: gen duplicados = _n
tab duplicados
 
 
 bysort ID_Participante  : gen duplicados_id = _n
 
keep if duplicados_id==1
ren ID_Participante ID
merge m:m ID using "C:\Users\MUVA\OneDrive - ASSOCIAÇÃO PARA O EMPODERAMENTO DA RAPARIGA-MUVA\Desktop\ID.dta"
ex
 
save `geral', replace 
 
import excel "C:\Users\MUVA\OneDrive\Projectos Rstudio\2023\dashboard_kufungula-versao1\Data\Lista_Selecionados_Kufungula.xlsx", sheet("Sheet 1") firstrow clear
merge m:m ID_Participante using  `geral'
drop _merge

save "C:\Users\MUVA\OneDrive\Projectos Rstudio\2023\dashboard_kufungula-versao1\Data\Presencas_clear.dta" , replace 

 ex
 reshape wide presenca, i(ID_Participante) j(Session)
 ex
 br

 

 
