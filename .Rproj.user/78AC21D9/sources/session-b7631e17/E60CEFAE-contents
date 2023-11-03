
carregar_dados <- function(){
  
  # Nome dos ficheiros
  caracteristicas_Monapo <- paste(getwd(), "01 Raw/produtores/Monapo/Lista_caracteristicas_Monapo.xlsx", sep = "/")
  caracteristicas_Ribaue <- paste(getwd(), "01 Raw/produtores/Ribaue/Lista_caracteristicas_Ribaue.xlsx", sep = "/")
  
  # Base de dados de caracteristicas
  db_monapo <- read_excel(caracteristicas_Monapo, sheet = 1) %>% 
    mutate(NOME = iconv(str_to_upper(gsub("\\s+", "",`Nome completo`)), to = "ASCII//TRANSLIT"))
  
  db_ribaue <- read_excel(caracteristicas_Ribaue, sheet = 1) %>% 
    mutate(NOME = iconv(str_to_upper(gsub("\\s+", "",`Nome completo`)), to = "ASCII//TRANSLIT"))
  
  
  # Ficheiros presencas monapo
  ma_xls_01 <-
    merge_worksheets(paste(getwd(), "01 Raw/produtores/Monapo/Lista_presenças_Monapo S01.xlsx", sep = "/")) %>% mutate(NOME = iconv(str_to_upper(gsub(
      "\\s+", "", `Nome Completo`
    )), to = "ASCII//TRANSLIT"))
  ma_xls_02 <-
    merge_worksheets(paste(getwd(), "01 Raw/produtores/Monapo/Lista_presenças_Monapo S02.xlsx", sep = "/")) %>% mutate(NOME = iconv(str_to_upper(gsub(
      "\\s+", "", `Nome Completo`
    )), to = "ASCII//TRANSLIT"))
  ma_xls_03 <-
    merge_worksheets(paste(getwd(), "01 Raw/produtores/Monapo/Lista_presenças_Monapo S03.xlsx", sep = "/")) %>% mutate(NOME = iconv(str_to_upper(gsub(
      "\\s+", "", `Nome Completo`
    )), to = "ASCII//TRANSLIT"))
  ma_xls_04 <-
    merge_worksheets(paste(getwd(), "01 Raw/produtores/Monapo/Lista_presenças_Monapo S04.xlsx", sep = "/")) %>% mutate(NOME = iconv(str_to_upper(gsub(
      "\\s+", "", `Nome Completo`
    )), to = "ASCII//TRANSLIT"))
  ma_xls_05 <-
    merge_worksheets(paste(getwd(), "01 Raw/produtores/Monapo/Lista_presenças_Monapo S05.xlsx", sep = "/")) %>% mutate(NOME = iconv(str_to_upper(gsub(
      "\\s+", "", `Nome Completo`
    )), to = "ASCII//TRANSLIT"))
  ma_xls_06 <-
    merge_worksheets(paste(getwd(), "01 Raw/produtores/Monapo/Lista_presenças_Monapo S06.xlsx", sep = "/")) %>% mutate(NOME = iconv(str_to_upper(gsub(
      "\\s+", "", `Nome Completo`
    )), to = "ASCII//TRANSLIT"))
  ma_xls_07 <-
    merge_worksheets(paste(getwd(), "01 Raw/produtores/Monapo/Lista_presenças_Monapo S07.xlsx", sep = "/")) %>% mutate(NOME = iconv(str_to_upper(gsub(
      "\\s+", "", `Nome Completo`
    )), to = "ASCII//TRANSLIT"))
  ma_xls_08 <-
    merge_worksheets(paste(getwd(), "01 Raw/produtores/Monapo/Lista_presenças_Monapo S08.xlsx", sep = "/")) %>% mutate(NOME = iconv(str_to_upper(gsub(
      "\\s+", "", `Nome Completo`
    )), to = "ASCII//TRANSLIT"))
  ma_xls_09 <-
    merge_worksheets(paste(getwd(), "01 Raw/produtores/Monapo/Lista_presenças_Monapo S09.xlsx", sep = "/")) %>% mutate(NOME = iconv(str_to_upper(gsub(
      "\\s+", "", `Nome Completo`
    )), to = "ASCII//TRANSLIT"))
  ma_xls_10 <-
    merge_worksheets(paste(getwd(), "01 Raw/produtores/Monapo/Lista_presenças_Monapo S10.xlsx", sep = "/")) %>% mutate(NOME = iconv(str_to_upper(gsub(
      "\\s+", "", `Nome Completo`
    )), to = "ASCII//TRANSLIT"))
  ma_xls_11 <-
    merge_worksheets(paste(getwd(), "01 Raw/produtores/Monapo/Lista_presenças_Monapo S11.xlsx", sep = "/")) %>% mutate(NOME = iconv(str_to_upper(gsub(
      "\\s+", "", `Nome Completo`
    )), to = "ASCII//TRANSLIT"))
  ma_xls_12 <-
    merge_worksheets(paste(getwd(), "01 Raw/produtores/Monapo/Lista_presenças_Monapo S12.xlsx", sep = "/")) %>% mutate(NOME = iconv(str_to_upper(gsub(
      "\\s+", "", `Nome Completo`
    )), to = "ASCII//TRANSLIT"))

  # Ficheiros presenca ribaue
  mo_xls_01 <-
    merge_worksheets(paste(getwd(), "01 Raw/produtores/Ribaue/Lista_presenças_Ribaue S01.xlsx", sep = "/")) %>% mutate(NOME = iconv(str_to_upper(gsub(
      "\\s+", "", `Nome Completo`
    )), to = "ASCII//TRANSLIT"))
  mo_xls_02 <-
    merge_worksheets(paste(getwd(), "01 Raw/produtores/Ribaue/Lista_presenças_Ribaue S02.xlsx", sep = "/")) %>% mutate(NOME = iconv(str_to_upper(gsub(
      "\\s+", "", `Nome Completo`
    )), to = "ASCII//TRANSLIT"))
  mo_xls_03 <-
    merge_worksheets(paste(getwd(), "01 Raw/produtores/Ribaue/Lista_presenças_Ribaue S03.xlsx", sep = "/")) %>% mutate(NOME = iconv(str_to_upper(gsub(
      "\\s+", "", `Nome Completo`
    )), to = "ASCII//TRANSLIT"))
  mo_xls_04 <-
    merge_worksheets(paste(getwd(), "01 Raw/produtores/Ribaue/Lista_presenças_Ribaue S04.xlsx", sep = "/")) %>% mutate(NOME = iconv(str_to_upper(gsub(
      "\\s+", "", `Nome Completo`
    )), to = "ASCII//TRANSLIT"))
  mo_xls_05 <-
    merge_worksheets(paste(getwd(), "01 Raw/produtores/Ribaue/Lista_presenças_Ribaue S05.xlsx", sep = "/")) %>% mutate(NOME = iconv(str_to_upper(gsub(
      "\\s+", "", `Nome Completo`
    )), to = "ASCII//TRANSLIT"))
  mo_xls_06 <-
    merge_worksheets(paste(getwd(), "01 Raw/produtores/Ribaue/Lista_presenças_Ribaue S06.xlsx", sep = "/")) %>% mutate(NOME = iconv(str_to_upper(gsub(
      "\\s+", "", `Nome Completo`
    )), to = "ASCII//TRANSLIT"))
  mo_xls_07 <-
    merge_worksheets(paste(getwd(), "01 Raw/produtores/Ribaue/Lista_presenças_Ribaue S07.xlsx", sep = "/")) %>% mutate(NOME = iconv(str_to_upper(gsub(
      "\\s+", "", `Nome Completo`
    )), to = "ASCII//TRANSLIT"))
  mo_xls_08 <-
    merge_worksheets(paste(getwd(), "01 Raw/produtores/Ribaue/Lista_presenças_Ribaue S08.xlsx", sep = "/")) %>% mutate(NOME = iconv(str_to_upper(gsub(
      "\\s+", "", `Nome Completo`
    )), to = "ASCII//TRANSLIT"))
  mo_xls_09 <-
    merge_worksheets(paste(getwd(), "01 Raw/produtores/Ribaue/Lista_presenças_Ribaue S09.xlsx", sep = "/")) %>% mutate(NOME = iconv(str_to_upper(gsub(
      "\\s+", "", `Nome Completo`
    )), to = "ASCII//TRANSLIT"))
  mo_xls_10 <-
    merge_worksheets(paste(getwd(), "01 Raw/produtores/Ribaue/Lista_presenças_Ribaue S10.xlsx", sep = "/")) %>% mutate(NOME = iconv(str_to_upper(gsub(
      "\\s+", "", `Nome Completo`
    )), to = "ASCII//TRANSLIT"))
  mo_xls_11 <-
    merge_worksheets(paste(getwd(), "01 Raw/produtores/Ribaue/Lista_presenças_Ribaue S11.xlsx", sep = "/")) %>% mutate(NOME = iconv(str_to_upper(gsub(
      "\\s+", "", `Nome Completo`
    )), to = "ASCII//TRANSLIT"))
  mo_xls_12 <-
    merge_worksheets(paste(getwd(), "01 Raw/produtores/Ribaue/Lista_presenças_Ribaue S12.xlsx", sep = "/")) %>% mutate(NOME = iconv(str_to_upper(gsub(
      "\\s+", "", `Nome Completo`
    )), to = "ASCII//TRANSLIT"))

  # Combinação das listas de todas as sessões
  listas_presencas_monapo <-
    list(ma_xls_01, ma_xls_02, ma_xls_03, ma_xls_04, ma_xls_05, ma_xls_06, ma_xls_07, ma_xls_08, ma_xls_09, ma_xls_10, ma_xls_11, ma_xls_12)
  db_presencas_monapo <- do.call(rbind, listas_presencas_monapo)

  listas_presencas_ribaue <-
    list(mo_xls_01, mo_xls_02, mo_xls_03, mo_xls_04, mo_xls_05, mo_xls_06, mo_xls_07, mo_xls_08, mo_xls_09, mo_xls_10, mo_xls_11, mo_xls_12)
  db_presencas_ribaue <- do.call(rbind, listas_presencas_ribaue)

  # Atribuição dos ID's correctos nas listas de presenças
  db_presencas_ribaue <- merge(db_ribaue, db_presencas_ribaue, by = "NOME", all = TRUE) %>%
    mutate(ID_CERTO = ID.x) %>%
    select(ID_CERTO, `Nome completo`, Sexo.x, Turma.x, `Presença (1- PRESENTE, 0 - AUSENTE, 2-DESISTENTE)`, `NUMERO DA SESSÃO`, Idade, Comunidade, Povoado) %>%
    rename(ID = ID_CERTO, Sexo = Sexo.x, Turma = Turma.x, `Nome Completo` = `Nome completo`) %>%
    filter(!is.na(ID) & !is.na(`NUMERO DA SESSÃO`))

  db_presencas_monapo <- merge(db_monapo, db_presencas_monapo, by = "NOME", all = TRUE) %>%
    mutate(ID_CERTO = ID.x, Obs = NA) %>%
    select(ID_CERTO, `Nome completo`, Sexo.x, Turma.x, `Presença (1- PRESENTE, 0 - AUSENTE, 2-DESISTENTE)`, `NUMERO DA SESSÃO`, Idade, Comunidade, Povoado) %>%
    rename(ID = ID_CERTO, Sexo = Sexo.x, Turma = Turma.x, `Nome Completo` = `Nome completo`) %>%
    filter(!is.na(ID) & !is.na(`NUMERO DA SESSÃO`))

  db_presencas_produtores <- rbind(db_presencas_ribaue, db_presencas_monapo) %>%
    rename(NomeCompleto = )

  return(db_presencas_produtores)
}

# Função para combinar folhas do excel
merge_worksheets <- function (file) {
  df <- data.frame()  # Dataframe vazio para armazenar os dados
  
  # Ler cada folha e combinar os dados no dataframe
  for (i in 1:2) {
    df_temp <- read_excel(file, sheet = i)  # Ler a folha atual
    df <-
      rbind(df, df_temp)  # Combinar os dados na folha atual com o dataframe principal
  }
  
  return(df)
}