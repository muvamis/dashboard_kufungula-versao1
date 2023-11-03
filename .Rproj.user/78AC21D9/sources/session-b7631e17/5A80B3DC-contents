
sessao_atual <- 1

presenca_produtores <- carregar_dados()


# RENOMEAR VARIAVEIS DA DATAFRAME db_presencas
presenca_produtores <- presenca_produtores %>%
  rename(
    ID = ID,
    Nome = `Nome Completo`,
    Sexo = Sexo,
    Turma = Turma,
    presenca = `Presença (1- PRESENTE, 0 - AUSENTE, 2-DESISTENTE)`,
    NUMERODASESSÃO = `NUMERO DA SESSÃO`,
    Idade = Idade,
    Comunidade = Comunidade,
    Povoado = Povoado,
  ) %>%
  mutate(
    Sexo = ifelse(Sexo == "F", "FEMININO", "MASCULINO"),
    presenca = case_when(
      presenca == 1 ~ "SIM",
      presenca == 0 ~ "NAO",
      presenca == 2 ~ "Desistente",
      TRUE ~ as.character(presenca)
    ),
   
  )



# FILTRO DOS PRESENTES NAS SESSOES
tab_freq_ag <- presenca_produtores %>%
  filter(presenca %in% c("SIM","NAO"))  %>%
  group_by(Comunidade,NUMERODASESSÃO,Sexo,presenca) %>%
  summarise(n = n()) %>%
  mutate(freq = n / sum(n) * 100, Percentagem = round(freq, digits = 0)) %>%
  ungroup()


tab_freq_ag <- tab_freq_ag %>% filter(presenca %in% "SIM")


# DADOS Ribaue E Monapo
dados_monapo <- presenca_produtores %>%
  filter(Comunidade == "Monapo") %>%
  group_by(ID, Nome, Comunidade, NUMERODASESSÃO, Sexo, presenca) %>%
  filter(presenca %in% c("SIM", "NAO")) %>%
  summarise(TotalPresentes = n())

# Remover a coluna2 do dataframe
dados_monapo <- subset(dados_monapo, select = -TotalPresentes)


dados_ribaue <- presenca_produtores %>%
  filter(Comunidade == "Ribaue") %>%
  group_by(ID, Nome, Comunidade, NUMERODASESSÃO, Sexo, presenca) %>%
  filter(presenca %in% c("SIM", "NAO")) %>%
  summarise(TotalPresentes = n())

# Remover a coluna2 do dataframe
dados_ribaue <- subset(dados_ribaue, select = -TotalPresentes)

comunidadelista <- read_excel(paste(getwd(), "dados/comunidadelista.xlsx", sep = "/"))
#### tabela Nampula
influentes <- read_excel("01 Raw/comunidade/Raw/Lista_influentes.xlsx")

###DADOS CABO DELGADO
comunidade <- read_excel(paste(getwd(), "dados 01/presencas_tabela.xlsx", sep = "/"))
presencas_tabela <- read_excel("dados 01/presencas_tabela.xlsx")


cabo_delgado_data <- read_excel("dados 01/produtores_delgado.xlsx")




# ABA VISAO GERAL 
produtores_Consider <- read_excel(paste(getwd(), "dados 01/produtores_Kufungula.xlsx", sep = "/"))

dados = produtores_Consider %>% 
  filter((produtores_Consider$presenca=="SIM" | produtores_Consider$presenca=="NAO")) 

inscritos_produtores <- dados %>%
  distinct(ID, Sexo, Turma, Regiao, Comunidade, .keep_all = TRUE) %>%
  group_by(Regiao, Sexo) %>%
  summarise(Totalinscritos=n())


desistentes_inscritos <- dados %>%
  group_by(Sexo, Regiao) %>%
  filter(nrSessao >= 2 & nrSessao <= 5) %>%
  group_by(Sexo, Regiao, Nome) %>%
  summarise(TotalSim = sum(presenca == "SIM")) %>%
  filter(TotalSim <= 2) %>%
  summarise(TotalDesistentes = n())

# Dados do botao baixar com caracteristicas

inscritos <- presenca_produtores %>%
  distinct(ID, Sexo, Turma, Comunidade, Povoado, .keep_all = TRUE) %>%
  group_by(ID, Nome, Sexo, Turma, Idade, Comunidade, Povoado) %>%
  summarise(Totalinscritos=n())

inscritos <- subset(inscritos, select = -Totalinscritos)

# funcoes.R para Evitar conflitos nas paginas
criarPainelFiltro <- function(id, label, choices) {
  radioButtons(id, label = label, choices = choices)
}

criarPainelSelecao <- function(id1, label1, choices1, id2, label2, choices2) {
  column(2,
         selectInput(id1, label = label1, choices = choices1, multiple = TRUE, selected = ""),
         selectInput(id2, label = label2, choices = choices2, multiple = TRUE, selected = 1))
}

criarGraficoPresenca <- function(data, regiao) {
  # Lógica para criar o gráfico de presença com base nos dados e na região
  # ...
  # Retorna o objeto do gráfico plotly
}




