 
 
Kufungula <- read_dta("Data/Lista_Nampula_Kufugula.dta") 
 
 
Presencas <- read_dta("Data/Presencas_clear.dta")


Nampula<- Kufungula %>% filter(Provincia=="NAMPULA") 

Cabo_Delgado<- Kufungula %>% filter(Provincia=="Cabo Delgado") 
 
  
# Selecione apenas as colunas desejadas em Presencas_atualizado

# Presencas$Comunidade <- ifelse(is.na(Presencas$Comunidade.y), Presencas$Comunidade.x, Presencas$Comunidade.y)
# #Presencas$Distrito <- ifelse(is.na(Presencas$Distrito.y), Presencas$Distrito.x, Presencas$Distrito)
# Presencas$Provincia <-  Presencas$Provincia.y 
# Presencas$Facilitator <- ifelse(is.na(Presencas$Facilitator.y), Presencas$Facilitator.x, Presencas$Facilitator.y)
Presencas <- Presencas %>%
  select(
    Nome_Participante,
    Provincia,
    Idade,
    Nome_District,
    Deslocado,
    Comunidade,
    Sexo,
    Facilitator,
    Formation_PI,
    Session_PI,
    Formation_AG,
    Session,
    ID_Participante,
    Presenca,
    Reposicao_sessao
  )
 Presencas$Distrito <- Presencas$Nome_District
 
Presencas$Distrito <- sub("Ribaué", "Ribaue", Presencas$Distrito)
 
### Replace library(dplyr)

# Suponha que df é seu dataframe e sessao_PI é a variável a ser modificada
# Presencas <- Presencas %>%
#   mutate(Session_PI = case_when(
#     Session_PI == "Introdução: Pontos-Chave  (Proatividade e Reatividade, Pensar no futuro, Superar obstáculos, Explorar iniciativas pessoais))" ~ "Sessao 1",
#     Session_PI == "O processo  empreendedor (Identificando oportunidades de negócio,  Tu e a IP,  Recursos)" ~ "Sessao 2",
#     Session_PI == "O Processo Empreendedor Identificando Oportunidades de  Negócio (Mercado,  Avaliação &amp; Comentários)" ~ "Sessao 3",
#     Session_PI == "O Processo  Empreendedor Definição de Metas,  Planejamento" ~ "Sessao 4",
#     Session_PI == "O Processo Empreendedor (Planejamento: Arranjar financiamento,  Estabelecer ligações,  Monitorar o progresso,  Contabilidade &  Poupança)" ~ "Sessao 5",
#     Session_PI == "O Processo  Empreendedor (Comentários:  Experimentar, Erros)" ~ "Sessao 6",
#     Session_PI == "Iniciativa Pessoal (Superar Obstáculos - Ténicas de resolução de  problemas)" ~ "Sessao 7",
#     Session_PI == "Iniciativa Pessoal (Superar obstáculos - Técnicas de resolução de  problemas)" ~ "Sessao 8",
#     Session_PI == "Revisão" ~ "Sessao 9",
#     TRUE ~ Session_PI # Mantém o valor original caso não corresponda a nenhum dos anteriores
#   ))
# 
# 
# ############################################################################################
# Presencas <- Presencas %>%
#   mutate(Session = case_when( 
#     Session == "Abordagem sobre principios basicos de implementação de FFS" ~ "Sessao 1",
#     Session == "Criterios de Identificação de areas para estabelecimento dos FFS (DRP)" ~ "Sessao 2",
#     Session == "Demarcaçao de campos de(Parcelas para monocultura e culturas de consorciação)" ~ "Sessao 3",
#     Session == "Sessões de demonstração de diversas técnicas de sementeira" ~ "Sessao 4",
#     Session == "Sessões de Controlo de pragas e Infestantes (produção de pesticidas botanicos)" ~ "Sessao 5",
#     Session == "Sessões de Monitoria de campos (estagio fenologico da cultura)Tecnica de AESA" ~ "Sessao 6",
#     Session == "Tecnicas de cuidados pre colheita, colheita e pos colheita (PHM)" ~ "Sessao 7",
#     Session == "Abordagem do Sistema de Desenvolvimento de Mercados (Ligação com o mercado)" ~ "Sessao 8",
#     TRUE ~ Session # Mantém o valor original caso não corresponda a nenhum dos anteriores
#   ))

#######################################################################################################

# Aplicar a função às colunas do DataFrame
Presencas$Distrito <- remove_accents(Presencas$Distrito)
Presencas$Presenca <- remove_accents(Presencas$Presenca)
Presencas$Deslocado <- remove_accents(Presencas$Deslocado)
Presencas$Facilitator <- remove_accents(Presencas$Facilitator)
Presencas$Formation_AG <- remove_accents(Presencas$Formation_AG)
Presencas$Formation_PI <- remove_accents(Presencas$Formation_PI)

# Transformar as colunas em maiúsculas
Presencas$Distrito <- toupper(Presencas$Distrito)
Presencas$Presenca <- toupper(Presencas$Presenca)
Presencas$Deslocado <- toupper(Presencas$Deslocado)
Presencas$Facilitator <- toupper(Presencas$Facilitator)
Presencas$Formation_AG <- toupper(Presencas$Formation_AG)
Presencas$Formation_PI <- toupper(Presencas$Formation_PI)
 




###############################################################################
Presencas <-  Presencas %>%
  rename(presenca=Presenca,
         FormacaoPI=Session_PI,
         NomeSessao=Session)

Presencas<- Presencas  %>%
  mutate(`Faixa Etária 18-24` = ifelse(Idade >= 18 & Idade <= 24, 1, 0),
         `Faixa Etária 25-35` = ifelse(Idade > 24 & Idade <= 35, 1, 0))

presencas_PI<-filter(Presencas, Presencas$Formation_PI=="SIM")
presencas_AG<-filter(Presencas, Presencas$Formation_AG=="SIM")

# Substitua os valores vazios por "NOME_PADRAO" (ou qualquer outro valor não vazio desejado)
presencas_PI <- presencas_PI %>% 
  mutate(FormacaoPI = ifelse(FormacaoPI == "", "VAZIO", FormacaoPI))
presencas_AG <- presencas_AG %>% 
  mutate(NomeSessao = ifelse(NomeSessao == "", "VAZIO", NomeSessao))

indiv_PI<- presencas_PI %>% pivot_wider(names_from =FormacaoPI, values_from =presenca)

indiv_PI <- indiv_PI %>%
  group_by(Nome_Participante, Distrito, Comunidade) %>%
  summarize(
    `Sessao 1` = ifelse(all(is.na(`Sessao 1`)), NA, max(`Sessao 1`, na.rm = TRUE)),
    `Sessao 2` = ifelse(all(is.na(`Sessao 2`)), NA, max(`Sessao 2`, na.rm = TRUE)),
    `Sessao 3` = ifelse(all(is.na(`Sessao 3`)), NA, max(`Sessao 3`, na.rm = TRUE)),
    `Sessao 4` = ifelse(all(is.na(`Sessao 4`)), NA, max(`Sessao 4`, na.rm = TRUE)),
    `Sessao 5` = ifelse(all(is.na(`Sessao 5`)), NA, max(`Sessao 5`, na.rm = TRUE)),
    `Sessao 6` = ifelse(all(is.na(`Sessao 6`)), NA, max(`Sessao 6`, na.rm = TRUE)),
    #`Sessao 7` = ifelse(all(is.na(`Sessao 7`)), NA, max(`Sessao 7`, na.rm = TRUE)),
    #`Sessao 8` = ifelse(all(is.na(`Sessao 8`)), NA, max(`Sessao 8`, na.rm = TRUE)),
    #`Sessao 9` = ifelse(all(is.na(`Sessao 9`)), NA, max(`Sessao 9`, na.rm = TRUE))
  )
 
 
 
indiv_AG<- presencas_AG %>% pivot_wider(names_from =NomeSessao, values_from =presenca)

indiv_AG <- indiv_AG %>%
  group_by(Nome_Participante, Distrito, Comunidade) %>%
  summarize(
    `Sessao 1` = ifelse(all(is.na(`Sessao 1`)), NA, max(`Sessao 1`, na.rm = TRUE)),
    `Sessao 2` = ifelse(all(is.na(`Sessao 2`)), NA, max(`Sessao 2`, na.rm = TRUE)),
    `Sessao 3` = ifelse(all(is.na(`Sessao 3`)), NA, max(`Sessao 3`, na.rm = TRUE)),
    `Sessao 4` = ifelse(all(is.na(`Sessao 4`)), NA, max(`Sessao 4`, na.rm = TRUE)),
    `Sessao 5` = ifelse(all(is.na(`Sessao 5`)), NA, max(`Sessao 5`, na.rm = TRUE)),
    #`Sessao 6` = ifelse(all(is.na(`Sessao 6`)), NA, max(`Sessao 6`, na.rm = TRUE)),
    #`Sessao 7` = ifelse(all(is.na(`Sessao 7`)), NA, max(`Sessao 7`, na.rm = TRUE)),
    #`Sessao 8` = ifelse(all(is.na(`Sessao 8`)), NA, max(`Sessao 8`, na.rm = TRUE)),
   
  )


 
###########
presencas_PI <- presencas_PI %>%
  mutate(`Faixa Etária 18-24` = ifelse(Idade >= 18 & Idade <= 24, 1, 0),
         `Faixa Etária 25-35` = ifelse(Idade > 24 & Idade <= 35, 1, 0))

presencas_AG <- presencas_AG %>%
  mutate(`Faixa Etária 18-24` = ifelse(Idade >= 18 & Idade <= 24, 1, 0),
         `Faixa Etária 25-35` = ifelse(Idade > 24 & Idade <= 35, 1, 0))
 
# Criação da tabela agregada
Tabela_PI<- presencas_PI %>%
  filter(presencas_PI$presenca == "SIM") %>%  # Filtrar apenas as presenças confirmadas
  group_by(Distrito,Comunidade, Sexo, NomeSessao) %>%
  summarise(
    totais = n(),  # Contagem total por grupo
    `Faixa Etária 18-24` = sum(`Faixa Etária 18-24`, na.rm = TRUE),
    `Faixa Etária 25-35` = sum(`Faixa Etária 25-35`, na.rm = TRUE)
  ) %>%
  ungroup()

write_xlsx(indiv_AG, "Data/indiv_AG.xlsx")
write_xlsx(Tabela_PI, "Data/indiv_PI.xlsx")
############
#
# presencas_AG <- presencas_AG %>%
#   mutate(`Faixa Etária 18-24` = ifelse(Idade >= 18 & Idade <= 24, 1, 0),
#          `Faixa Etária 25-35` = ifelse(Idade > 24 & Idade <= 35, 1, 0))

# # Criação da tabela agregada
Tabela_AG <- presencas_AG %>%
  filter(presencas_AG$presenca == "SIM") %>%  # Filtrar apenas as presenças confirmadas
  group_by(Distrito,Comunidade, Sexo, NomeSessao) %>%
  summarise(
    totais = n(),  # Contagem total por grupo
    `Faixa Etária 18-24` = sum(`Faixa Etária 18-24`, na.rm = TRUE),
    `Faixa Etária 25-35` = sum(`Faixa Etária 25-35`, na.rm = TRUE)
  ) %>%
  ungroup()
 
 ####################################### 

 