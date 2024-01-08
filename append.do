clear all 
  
tempfile 1 2 Geral geral Ribaue MonapoID Monapo

 use "C:\Users\MUVA\OneDrive\Projectos Rstudio\2023\dashboard_kufungula-versao1\Data\Lista_Final_Ribaue.dta", clear
 
 append using "C:\Users\MUVA\OneDrive\Projectos Rstudio\2023\dashboard_kufungula-versao1\Data\Lista_Final_Monapo.dta"
 replace Culturas_técnica_Milho=Milho_1 if Culturas_técnica_Milho==.
 drop Milho_1
 replace Culturas_técnica_Mandioca=Mandioca_1 if Culturas_técnica_Mandioca==.
 drop Mandioca_1
 replace Culturas_técnica_Gergelim=Gergelim_1 if Culturas_técnica_Gergelim==.
 drop Gergelim_1   _merge dup dup_tag Facilitator
  replace Nome_participante=upper(Nome_participante)
  replace Sexo=upper(Sexo)
  replace Sexo="FEMININO" if Sexo=="F"
    replace Sexo="MASCULINO" if Sexo=="M"
foreach i in Provincia Distrito Posto_Administrativo Comunidade Facilitador { 
replace `i'=upper(`i') 
} 
  
 save "C:\Users\MUVA\OneDrive\Projectos Rstudio\2023\dashboard_kufungula-versao1\Data\Lista_Nampula_Kufugula.dta", replace
export excel using "C:\Users\MUVA\OneDrive\Projectos Rstudio\2023\dashboard_kufungula-versao1\Data\Lista_Nampula_Kunfugula.xlsx",  firstrow(variables) replace
