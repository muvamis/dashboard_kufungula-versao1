 
 
Kufungula <- read_excel("Data/Lista_Selecionados_Kufungula.xlsx")

 

###Limpeza

# Carregar arquivo .dta
Presencas_3 <- read_dta("Data/Raw/Versao 3/Presencas_clear.dta")
Presencas_5 <- read_dta("Data/Raw/Versao 5/Presencas_clear.dta")

##Unir as duas bases de dados 
Presencas <- rbind(Presencas_3, Presencas_5) %>%
  left_join(Presencas, Kufungula, by = "ID_Participante",all.x = TRUE) ## Merge com base geral 

# Selecione apenas as colunas desejadas em Presencas_atualizado
Presencas <- Presencas %>%
  select(
    Nome_Participante,
    Provincia,
    Nome_District,
    Comunidade,
    Facilitator,
    Formation_PI,
    Session_PI,
    Formation_AG,
    Session,
    ID_Participante,
    Presenca,
    Reposicao_sessao
  )


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
  mutate(sessao_AG = case_when(
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
presencas_PI<-filter(Presencas, Presencas$Formation_PI=="Sim")
presencas_AG<-filter(Presencas, Presencas$Formation_AG=="Sim")

# presencas_AG$Província
# presencas_AG$Distrito 
# presencas_AG$Nome
 
# Substituir "SIM" e "NÃO" por HTML para círculos coloridos
# Usar a função reshape para transformar os dados

# Exibir o resultado
# Transformar os dados
# presencas_AG$Sexo
# presencas_AG$Idade
# presencas_AG$
  
Data_presenca <-  Data_presenca %>%
  rename(presenca=Presenca,
         FormacaoPI=Session_PI,
         NomeSessao=Session)
 

################  Tabela ##################################################

# Seu código para criar tab_freq_PI
tab_freq_PI <- Data_presenca %>%
  filter(presenca == "Sim") %>%
  group_by(Distrito, FormacaoPI, Sexo) %>%
  summarise(n = n(), .groups = 'drop') %>%
  mutate(freq = n / sum(n) * 100, 
         Percentagem = round(freq, digits = 0)) %>%
  ungroup()

# Seu código para criar tab_freq_AG
tab_freq_AG<- Data_presenca %>%
  filter(presenca == "Sim") %>%
  group_by(Distrito, NomeSessao, Sexo) %>%
  summarise(n = n(), .groups = 'drop') %>%
  mutate(freq = n / sum(n) * 100, 
         Percentagem = round(freq, digits = 0)) %>%
  ungroup()


############################################################################

# Crie intervalos de idade desejados
intervalos_idade <- c(17, 24, 35)

# Use a função cut para criar fatores para intervalos de idade
Data_presenca <- Data_presenca %>%
  mutate(faixa_etaria = cut(Idade, breaks = intervalos_idade, labels = c("18-24", "25-35")))


resultado <- Data_presenca %>% filter(presenca=="Sim") %>%
  group_by(Nome_District, Sexo, faixa_etaria) %>%
  summarize(contagem = n()) %>%
  ungroup() %>% 
  group_by(Nome_District, Sexo) %>%
  mutate(totais = sum(contagem)) %>%
  spread(faixa_etaria, contagem) %>%
  rename("Faixa Etária 18-24" = "18-24", "Faixa Etária 25-35" = "25-35") %>%
  filter(!is.na(`Faixa Etária 18-24`) & !is.na(`Faixa Etária 25-35`))

# Calculate cumulative totals by district
resultado_totais <- resultado %>%
  group_by(Nome_District) %>%
  summarise(across(c(totais, `Faixa Etária 18-24`, `Faixa Etária 25-35`), sum)) %>%
  mutate(Sexo = "Total Acumulados")

# Combine resultado and resultado_totais
resultado_final <- bind_rows(resultado, resultado_totais)

# Create a separate row for cumulative totals
total_row <- resultado_final %>%
  group_by(Nome_District) %>%
  summarise(across(c(totais, `Faixa Etária 18-24`, `Faixa Etária 25-35`), sum)) %>%
  mutate(Sexo = "Total Acumulados")

# Add the total_row to the table
tabela_formatada <- resultado_final %>%
  bind_rows(total_row)

# Format the table using kable and kableExtra functions
tabela_formatada <- tabela_formatada %>%
  kable(format = "html", align = c("l", "l", "r", "r", "r"),
        caption = "Contagem de Pessoas por Distrito, Sexo e Faixa Etária",
        col.names = c("Distrito", "Sexo", "Totais", "Faixa Etária 18-24", "Faixa Etária 25-35")) %>%
  kable_styling(bootstrap_options = c("striped", "hover"),
                full_width = FALSE)

 
