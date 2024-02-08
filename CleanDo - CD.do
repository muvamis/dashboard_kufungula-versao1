clear all
set more off
  
 global caminho  "C:\Users\MUVA\OneDrive - ASSOCIAÇÃO PARA O EMPODERAMENTO DA RAPARIGA-MUVA\DEPARTAMENTO MIS\DEPARTAMENTO MIS\PROJECTOS\SISTEMA DE MONITORIA\Kufungula\dashboard_kufungula-versao1"
 global CDelgado  "C:\Users\MUVA\OneDrive - ASSOCIAÇÃO PARA O EMPODERAMENTO DA RAPARIGA-MUVA\DEPARTAMENTO MIS\DEPARTAMENTO MIS\PROJECTOS\SISTEMA DE MONITORIA\Kufungula\dashboard_kufungula-versao1\Data\Raw\Cabo Delgado"

 
 tempfile 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16 17 18 19 20 21 22 23 24 25 cabodelgado mydata
 //local 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16 17 18 19 20 21 22 23 24 25 cabodelgado mydata
 

  import excel  "$CDelgado\lista_RAW_CABODELGADO.xlsx", sheet("Sheet1") firstrow clear
  
 
 replace Nome_Participante=upper(Nome_Participante)
 drop if Nome_Participante==""
 bysort Nome_Participante: gen dup=_n
 drop if dup>1
replace Distrito=upper(Distrito)
replace SEXO=upper(SEXO)
ren SEXO Sexo
 replace Sexo = "Masculino" if Nome_Participante == "ABALIQUINA MONAJA (MAIBEQUE CORNELIO)"
replace Sexo = "Masculino" if Nome_Participante == "AFAI LULA (JUMA MITO)"
replace Sexo = "Masculino" if Nome_Participante == "AFITO FERNANDO"
replace Sexo="Feminino" if Sexo=="F"
replace Sexo="Feminino" if Sexo=="FF"
replace Sexo="Feminino" if Sexo=="F (M)"
replace Sexo="MASCULINO" if Sexo=="M"
replace Sexo="MASCULINO" if Sexo=="M (F)"
replace Sexo="MASCULINO" if Sexo=="H"
replace Sexo="Feminino" if Sexo=="F(M)"
replace Sexo=upper(Sexo)

ren CONTACTO Contacto
ren CONTACTOALTERNATIVO Contacto_alternativo
drop  dup
* Supondo que sua variável de gênero seja chamada "Sexo"
* Substituir "Feminino" por "Masculino" para os nomes especificados
replace Comunidade=upper(Comunidade)
replace Comunidade="ANGALIA" if Comunidade=="AMGALIA" | Comunidade=="A GALAA"
replace Comunidade="UJAMA" if Comunidade=="UJAMA "


replace Posto_Administrativo=upper(Posto_Administrativo)
replace Posto_Administrativo="NAMANHUMBIRE" if Posto_Administrativo=="NAMAHUMBIRE "
replace Posto_Administrativo="NAMUNO-SEDE" if Posto_Administrativo=="NAMUNO -SEDE"
replace PRODUTORASIMNAO=upper(PRODUTORASIMNAO)


replace Actividade="COMPONES"
replace Faz_venda=upper(Faz_venda)
drop U V

export excel using "$caminho\Data\Lista_Cabo_Delgado_Kufugula.xlsx", firstrow(variables) replace

save "$CDelgado\Lista_Cabo_Delgado_Kufugula.dta", replace
ex 
