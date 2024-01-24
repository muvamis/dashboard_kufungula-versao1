####Funcoes 
   
# Função para remover acentuação
remove_accents <- function(text) {
  text <- tolower(text)
  text <- str_replace_all(text, "[^a-z0-9 ]", "")
  return(text)
}
 
calcular_frequencias <- function(data, ...) {
  # Agrupa por variáveis especificadas e calcula a contagem
  data_grouped <- data %>%
    group_by(...) %>%
    summarise(n = n(), .groups = "drop")
  
  # Extrai os nomes das variáveis de agrupamento para reagrupar
  group_vars <- quos(...)
  
  # Reagrupa sem a última variável para calcular as porcentagens
  data_freq <- data_grouped %>%
    group_by(!!!group_vars[-length(group_vars)]) %>%
    mutate(freq = n / sum(n) * 100,
           Percentagem = round(freq, digits = 0))
  
  data_freq
}
 
library(DT)

renderizar_tabela_interativa <- function(dataframe, ...) {
  tabela_frequencias <- calcular_frequencias(dataframe, ...)
  datatable(tabela_frequencias, options = list(pageLength = 5, autoWidth = TRUE))
} 


###########
# Função para mapear valores para bolinhas coloridas ou X
map_values <- function(value) {
  if (is.na(value)) {
    return("X")
  } else if (value == "sim") {
    return('<span style="color:green;">•</span>') # Bolinha verde
  } else if (value == "nao") {
    return('<span style="color:red;">•</span>')   # Bolinha vermelha
  } else {
    return(value)
  }
}

