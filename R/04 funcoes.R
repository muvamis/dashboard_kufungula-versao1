####Funcoes 
 
# Função para remover acentuação
remove_accents <- function(text) {
  text <- tolower(text)
  text <- str_replace_all(text, "[^a-z0-9 ]", "")
  return(text)
}

 