 
 
Kufungula <- read_excel("Data/Lista_Selecionados_Kufungula.xlsx") 


Presencas_clear <- read_dta("Data/Presencas_clear.dta")




###Limpeza

##Unir as duas bases de dados
 
Presencas <- left_join(Presencas_clear, Kufungula, by = "ID_Participante") ## Merge com base geral 

# Selecione apenas as colunas desejadas em Presencas_atualizado

Presencas$Comunidade <- ifelse(is.na(Presencas$Comunidade.y), Presencas$Comunidade.x, Presencas$Comunidade.y)
Presencas$Distrito <- ifelse(is.na(Presencas$Distrito), Presencas$Distrito, Presencas$Distrito)

Presencas <- Presencas %>%
  select(
    Nome_Participante,
    Provincia,
    Idade,
    Distrito,
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

Presencas$Distrito <- sub("Ribaué", "Ribaue", Presencas$Distrito)
 
 
### Replace library(dplyr)

# Suponha que df é seu dataframe e sessao_PI é a variável a ser modificada
Presencas <- Presencas %>%
  mutate(Session_PI = case_when(
    Session_PI == "Introdução: Pontos-Chave  (Proatividade e Reatividade, Pensar no futuro, Superar obstáculos, Explorar iniciativas pessoais))" ~ "Sessao 1",
    Session_PI == "O processo  empreendedor (Identificando oportunidades de negócio,  Tu e a IP,  Recursos)" ~ "Sessao 2",
    Session_PI == "O Processo Empreendedor Identificando Oportunidades de  Negócio (Mercado,  Avaliação & Comentários)" ~ "Sessao 3",
    Session_PI == "O Processo  Empreendedor Definição de Metas,  Planejamento" ~ "Sessao 4",
    Session_PI == "O Processo Empreendedor (Planejamento: Arranjar financiamento,  Estabelecer ligações,  Monitorar o progresso,  Contabilidade &  Poupança)" ~ "Sessao 5",
    Session_PI == "O Processo  Empreendedor (Comentários:  Experimentar, Erros)" ~ "Sessao 6",
    Session_PI == "Iniciativa Pessoal (Superar Obstáculos - Ténicas de resolução de  problemas)" ~ "Sessao 7",
    Session_PI == "Iniciativa Pessoal (Superar obstáculos - Técnicas de resolução de  problemas)" ~ "Sessao 8",
    Session_PI == "Revisão" ~ "Sessao 9",
    TRUE ~ Session_PI # Mantém o valor original caso não corresponda a nenhum dos anteriores
  ))
 
############################################################################################
Presencas <- Presencas %>%
  mutate(Session = case_when(
    Session == "Abordagem sobre principios basicos de implementação de FFS" ~ "Sessao 1",
    Session == "Criterios de Identificação de areas para estabelecimento dos FFS (DRP)" ~ "Sessao 2",
    Session == "Demarcaçao de campos de(Parcelas para monocultura e culturas de consorciação)" ~ "Sessao 3",
    Session == "Sessões de demonstração de diversas técnicas de sementeira" ~ "Sessao 4",
    Session == "Sessões de Controlo de pragas e Infestantes (produção de pesticidas botanicos)" ~ "Sessao 5",
    Session == "Sessões de Monitoria de campos (estagio fenologico da cultura)Tecnica de AESA" ~ "Sessao 6",
    Session == "Tecnicas de cuidados pre colheita, colheita e pos colheita (PHM)" ~ "Sessao 7",
    Session == "Abordagem do Sistema de Desenvolvimento de Mercados (Ligação com o mercado)" ~ "Sessao 8",
    TRUE ~ Session # Mantém o valor original caso não corresponda a nenhum dos anteriores
  ))

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
Data_presenca <-  Presencas %>%
  rename(presenca=Presenca,
         FormacaoPI=Session_PI,
         NomeSessao=Session)


presencas_PI<-filter(Data_presenca, Data_presenca$Formation_PI=="SIM")
presencas_AG<-filter(Data_presenca, Data_presenca$Formation_AG=="SIM")



################  Tabela ##################################################

tab_freq_PI <- presencas_PI %>%
  group_by(Distrito, FormacaoPI, Sexo,presenca) %>%
  summarise(n = n()) %>%
  mutate(freq = n / sum(n) * 100, 
         Percentagem = round(freq, digits = 0)) %>%
  ungroup() 

##all
tab_freq_PI_all <- presencas_PI %>%
  group_by(FormacaoPI, Sexo,presenca) %>%
  summarise(n = n()) %>%
  mutate(freq = n / sum(n) * 100, 
         Percentagem = round(freq, digits = 0)) %>%
  ungroup() 

# Seu código para criar tab_freq_AG

tab_freq_AG <- presencas_AG %>%
  group_by(Distrito, NomeSessao, Sexo,presenca) %>%
  summarise(n = n()) %>%
  mutate(freq = n / sum(n) * 100, 
         Percentagem = round(freq, digits = 0)) %>%
  ungroup() 

###ALL
tab_freq_AG_all <- presencas_AG %>%
  group_by(NomeSessao,Sexo, presenca) %>%
  summarise(n = n()) %>%
  mutate(freq = n / sum(n) * 100, 
         Percentagem = round(freq, digits = 0)) %>%
  ungroup() 

 
# library(esquisse)
# esquisser(tab_freq_PI)

############################################################################

###########
presencas_PI <- presencas_PI %>%
  mutate(`Faixa Etária 18-24` = ifelse(Idade >= 18 & Idade <= 24, 1, 0),
         `Faixa Etária 25-35` = ifelse(Idade > 24 & Idade <= 35, 1, 0))

# Criação da tabela agregada
Tabela_PI<- presencas_PI %>%
  filter(presencas_PI$presenca == "SIM") %>%  # Filtrar apenas as presenças confirmadas
  group_by(Distrito, Sexo, NomeSessao) %>%
  summarise(
    totais = n(),  # Contagem total por grupo
    `Faixa Etária 18-24` = sum(`Faixa Etária 18-24`, na.rm = TRUE),
    `Faixa Etária 25-35` = sum(`Faixa Etária 25-35`, na.rm = TRUE)
  ) %>%
  ungroup()
############ 

presencas_AG <- presencas_AG %>%
  mutate(`Faixa Etária 18-24` = ifelse(Idade >= 18 & Idade <= 24, 1, 0),
         `Faixa Etária 25-35` = ifelse(Idade > 24 & Idade <= 35, 1, 0))

# Criação da tabela agregada
Tabela_AG <- presencas_AG %>%
  filter(presencas_AG$presenca == "SIM") %>%  # Filtrar apenas as presenças confirmadas
  group_by(Distrito, Sexo, NomeSessao) %>%
  summarise(
    totais = n(),  # Contagem total por grupo
    `Faixa Etária 18-24` = sum(`Faixa Etária 18-24`, na.rm = TRUE),
    `Faixa Etária 25-35` = sum(`Faixa Etária 25-35`, na.rm = TRUE)
  ) %>%
  ungroup()
 
 #######################################

 ##################Tabela para individual 

Data_Individual_PI <- presencas_PI %>%
  select(Nome_Participante, NomeSessao, presenca,Distrito, Comunidade) 

Data_Individual_AG$cor <- ifelse(Data_Individual_AG$presenca == 'SIM', 'green', 'red')
Data_Individual_AG <- presencas_AG %>%
  select(Nome_Participante, NomeSessao, presenca,Distrito, Comunidade) 

Data_Individual_AG$cor <- ifelse(Data_Individual_AG$presenca == 'SIM', 'green', 'red')

# data_united <- Data_Individual_AG %>%
# Gerar o gráfico de pontos
