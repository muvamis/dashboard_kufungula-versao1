
# Define UI
ui <- fluidPage(
  
  # Define o tema
  theme = shinytheme("flatly"),
  #dercio
  # Define a barra de navegação
  navbarPage( 
    # Define o título da barra de navegação
    title = "Kufungula Muae" ,
    # header = "Meu Cabeçalho",
    tags$head(tags$style(HTML('.navbar-default {background-color: #a742f5;}'))),
    
    #VISAO GERAL
    navbarMenu("Overview",
               tabPanel("Visão Geral",
                        #uiOutput("rmd_page")
                        wellPanel(p("Introdução:
                                    O projeto Kufungula Muae - Fortalecimento dos sistemas alimentares para aumento das oportunidades de emprego nas cadeias de valor para os jovens em Moçambique, tem como objectivo aumentar o rendimento de cadeias de valor selecionadas (mandioca, milho e gergelim) e as oportunidades de emprego ligadas as mesmas, diminuíndo assim a insegurança alimentar das zonas e pessoas identificadas.")),
                              column(12, 
                               fluidRow(
                                 column(6,
                                        style = "height: 100%;",
                                        wellPanel(h4("O gráfico abaixo ilustra a  informação referente ao número total de produtores inscritos por região e sexo"),
                                                  style = "height: 100%;"),
                                        downloadButton("download_inscritos", "Baixar", icon = icon("download"))
                                 ),
                                 column(6,
                                        style = "height: 100%;",
                                        wellPanel(h4("Procurar saber sobre a necessidade do grafico desistentes e definir o número de faltas"),
                                                  style = "height: 100%;"),
                                        downloadButton("download_desistentes", "Baixar", icon = icon("download")) 
                                 )
                               ),
                               fluidRow(
                                 column(6,
                                        style = "height: 100%;",
                                        # wellPanel(h4("O gráfico abaixo mostra informação refere ao número total de produtores inscritos por região e sexo"),
                                        #           style = "height: 100%;"),
                                        wellPanel(withSpinner(plotlyOutput("produtores_inscritos", height = 500), color = "black"),
                                                  style = "height: 100%;")
                                 ),
                                 column(6,
                                        style = "height: 100%;",
                                        wellPanel(withSpinner(plotlyOutput("produtores_desistentes", height = 500), color = "black"),
                                                  style = "height: 100%;")
                                 )
                               )
                        )
               )),
    navbarMenu("Nampula", icon = icon("exchange-alt"),
               tabPanel("Presenças", tabname = "tab_presencas", icon = icon("chart-line"),
                        column(12,
                               fluidRow(
                                 column(6,
                                        fluidRow(
                                          column(6,
                                                 wellPanel(
                                                   h4("Filtro"),
                                                   radioButtons("regiaocheck", label = "Distrito", choices = c("All", unique(presenca_nampula$Comunidade)))
                                                 )
                                          ),
                                          column(6,
                                                 wellPanel(
                                                   h4("Filtro"),
                                                   radioButtons("deslocadocheck", label = "Deslocado", choices = c("Todos", "Deslocado", "Não deslocado"))
                                                 )
                                          )
                                        )
                                 ),
                                 fluidRow(
                                   column(12,
                                          wellPanel(h4("")),
                                          withSpinner(plotlyOutput("grafico_presenca_nampula", height = 500), color = "black"),
                                          conditionalPanel(
                                            condition = "input.regiaocheck == 'Monapo'",
                                            downloadButton("download_monapo", "Lista de Presenças Monapo")
                                          ),
                                          conditionalPanel(
                                            condition = "input.regiaocheck == 'Ribaue'",
                                            downloadButton("download_ribaue", "Lista de Presenças Ribaue")
                                          )
                                   )
                                 ),
                                 fluidRow(
                                   column(12,
                                          wellPanel(h4("")),
                                          withSpinner(plotlyOutput("grafico_presenca_nampula2", height = 500), color = "black"))
                                 )
                               )
                        )
               ),
               tabPanel(
                 "Resultados",
                 tags$head(
                   tags$style(HTML('.info-box-content {color: #000000 !important;}')),
                   tags$style(HTML('.infobox-default {background-color: #a742f5 !important;}'))
                 ),
                 fluidRow(
                   column(4,
                          infoBoxOutput("total_deslocados")
                   ),
                   column(4,
                          infoBoxOutput("total_masculino")
                   ),
                   column(4,
                          infoBoxOutput("total_feminino")
                   )
                 ),
                 column(12,
                        wellPanel(
                          h4("A tabela abaixo mostra o número de participantes por sexo que participaram nas sessões dos 18 anos - 24 anos e dos 25 anos - 35 anos.")
                        ),
                        fluidRow(
                          column(2,
                                 selectInput("REGIAOComunidadeinf", label = "Região", choices = unique(influentes$Regiao), multiple = TRUE, selected = "Nampula"),
                                 selectInput("SessaoComunidadeinf", label = "Selecione o número da sessão", choices = unique(influentes$NrSessao), multiple = TRUE, selected = 1)
                          )
                        ),
                        fluidRow(
                          column(10,
                                 withSpinner(dataTableOutput("tabela_sexo_idade", height = 500), color = "black")
                          )
                        )
                 )
               )
    ),
    
    navbarMenu("Cabo Delgado", icon=icon("exchange-alt"),
               tabPanel(
                 "Presenças", tabname="tab_presencas_cabo_delgado", icon=icon("chart-line"), 
                 column(12,
                        tabsetPanel(
                          type = "tab",
                          tabPanel(
                            "Presenças",
                            column(2, wellPanel(h4(""), radioButtons("filtro_deslocados_cabo_delgado", "Filtro de Deslocados:",
                                                                     choices = c("Todos", "Deslocados", "Não Deslocados"), selected = "Todos"))),
                            column(2, wellPanel(h4(""), selectInput("regiaocheck_cabo_delgado", "Filtrar por Distrito:",
                                                                    choices = c("ALL", unique(cabo_delgado_data$Comunidade)),
                                                                    selected = "ALL"))),
                            column(10,
                              cellWidths = c("50%", "50%"),
                              withSpinner(
                                plotlyOutput("grafico_presencas1_cabo_delgado", height = 500),
                                color = "black"
                              ),
                              withSpinner(
                                plotlyOutput("grafico_presencas2_cabo_delgado", height = 500),
                                color = "black"
                              )
                            ),
                            shinyjs::useShinyjs(),
                            downloadButton("download_button", "Baixar Dados"),
                            conditionalPanel(
                              condition = "input.regiaocheck_cabo_delgado == 'MONTEPUEZ'",
                              downloadButton("download_montepuez_cabo_delgado", "Lista de Presenças Montepuez")
                            ),
                            conditionalPanel(
                              condition = "input.regiaocheck_cabo_delgado == 'NAMUNO'",
                              downloadButton("download_namuno_cabo_delgado", "Lista de Presenças Namuno")
                            ),
                            conditionalPanel(
                              condition = "input.regiaocheck_cabo_delgado == 'BALAMA'",
                              downloadButton("download_balama_cabo_delgado", "Lista de Presenças Balama")
                            )
                          )
                        )
                 )
               ),
               tabPanel("Resultados",
                        column(12,
                               wellPanel(
                                 h4("A tabela abaixo mostra o número de participantes por sexo que participaram nas sessões com idades >= 24 anos")
                               )
                        ),
                        
                        column(10,
                               selectInput("SessaoComunidadeinf_cabo_delgado", "Selecione o número da sessão", choices = unique(comunidade$Nrsessao),  multiple = TRUE),
                               withSpinner(dataTableOutput("tabela_sexo_idade_cabo_delgado", height = 500), color = "black"))
                               
               )          )
                   )    
               )

server <- function(input, output) {
  output$total_deslocados <- renderInfoBox({
    infoBox(
      title = "Total deslocados",
      value = 8,
      icon = icon("users", lib = "font-awesome"),
      color = "purple",
      fill = TRUE
    )
  })
  
  # Função de saída para total_masculino
  output$total_masculino <- renderInfoBox({
    infoBox(
      title = "Deslocados M",
      value = 6,
      icon = icon("male", lib = "font-awesome"),
      color = "purple",
      fill = TRUE
    )
  })
  
  # Função de saída para total_feminino
  output$total_feminino <- renderInfoBox({
    infoBox(
      title = "Deslocados F",
      value = 2,
      icon = icon("female", lib = "font-awesome"),
      color = "purple",
      fill = TRUE
    )
  })
##### Botoes baixar 
  generateExcelFile <- function(data) {
    wb <- createWorkbook()
    addWorksheet(wb, "Dados")
    writeData(wb, "Dados", data)
    
    temp_file <- tempfile(fileext = ".xlsx")
    saveWorkbook(wb, temp_file, overwrite = TRUE)
    
    return(temp_file)
  }
  
  # Função de download para o distrito Monapo
  output$download_monapo <- downloadHandler(
    filename = function() {
      paste0("lista_presencas_monapo_", Sys.Date(), ".xlsx")
    },
    content = function(file) {
      data <- subset(presenca_nampula, Comunidade == "Monapo")
      temp_file <- generateExcelFile(data)
      file.copy(temp_file, file)
    }
  )
  
  # Função de download para o distrito Ribaue
  output$download_ribaue <- downloadHandler(
    filename = function() {
      paste0("lista_presencas_ribaue_", Sys.Date(), ".xlsx")
    },
    content = function(file) {
      data <- subset(presenca_nampula, Comunidade == "Ribaue")
      temp_file <- generateExcelFile(data)
      file.copy(temp_file, file)
    }
  )
  
### Graficos Visao Geral  
  output$produtores_inscritos <- renderPlotly({
    
    ggplot(inscritos_produtores) +
      aes(x = Regiao, y = Totalinscritos, fill = Sexo) +
      geom_col() +
      scale_fill_manual(
        values = c(FEMININO = "#9942D4",
                   MASCULINO = "#F77333")
      ) +
      geom_text(aes(label = Totalinscritos), position = position_stack(vjust = 0.5), color = "white") +
      theme_minimal() +
       ggtitle("Produtores Inscritos por Provincia")
  })
  
  
  output$produtores_desistentes <- renderPlotly({
    
    ggplot(desistentes_inscritos) +
      aes(x = Regiao, y = TotalDesistentes, fill = Sexo, label = TotalDesistentes) +
      geom_col() +
      geom_text(position = position_stack(vjust = 0.5), color = "white", size = 4) +
      scale_fill_manual(
        values = c(FEMININO = "#9942D4",
                   MASCULINO = "#F77333")
      ) +
      theme_minimal() +
      ggtitle("Produtores Desistentes por Provincia")
  })
  
    output$download_inscritos <- downloadHandler(
    filename = function() {
      "inscritos_produtores.xlsx"
    },
    content = function(file) {
      write.xlsx(inscritos_produtores, file)
    }
  )
  ####páginas Cabo delgado
    output$download_dados_cabo_delgado <- downloadHandler(
      filename = function() {
        paste("dados_cabo_delgado_", Sys.Date(), ".csv", sep = "")
      },
      content = function(file) {
        if (input$regiaocheck_cabo_delgado == "ALL") {
          filtered_data <- cabo_delgado_data
        } else {
          filtered_data <- cabo_delgado_data %>%
            filter(Comunidade == input$regiaocheck_cabo_delgado)
        }
        
        write.csv(filtered_data, file, row.names = FALSE)
      }
    )
#### Gráficos e tabelas para a página "Cabo Delgado"
    filtered_data <- reactive({
      data <- cabo_delgado_data
      
      # Filtrar por Deslocado
      if (input$filtro_deslocados_cabo_delgado == "Deslocados") {
        data <- subset(data, Deslocado == "SIM")
      } else if (input$filtro_deslocados_cabo_delgado == "Não Deslocados") {
        data <- subset(data, Deslocado == "NAO")
      }
      
      # Filtrar por Comunidade
      if (input$regiaocheck_cabo_delgado != "ALL") {
        data <- subset(data, Comunidade == input$regiaocheck_cabo_delgado)
      }
      
      data
    })
    
    # Renderização do gráfico 1
    output$grafico_presencas1_cabo_delgado <- renderPlotly({
      filtered_data <- filtered_data()
      
      # Código para o gráfico de NomeSessao
      filtered_data <- filtered_data %>%
        mutate(Comunidade = case_when(
          input$regiaocheck_cabo_delgado == "ALL" ~ "ALL",
          Comunidade %in% c("BALAMA", "MAMUNO", "MONTEPUEZ") ~ "BALAMA, MAMUNO, MONTEPUEZ",
          TRUE ~ Comunidade
        ))
      
      tab_freq_ag_cabo_delgado_nome_sessao <- filtered_data %>%
        group_by(NomeSessao, Comunidade, Sexo, presenca, Deslocado) %>%
        summarise(n = n()) %>%
        mutate(
          freq = n / sum(n) * 100,
          Percentagem = round(freq, digits = 0)
        ) %>%
        ungroup()
      
      g1 <- tab_freq_ag_cabo_delgado_nome_sessao %>%
        filter(presenca == "SIM") %>%
        mutate(media = round(mean(Percentagem), digits = 0)) %>%
        ggplot(aes(
          x = factor(NomeSessao),
          y = Percentagem,
          fill = as.factor(Sexo)
        )) +
        geom_bar(stat = "identity", position = "dodge") +
        scale_fill_manual(values = c("#9442D4", "#F77333"), name = "SEXO") +
        labs(y = "Produtores presentes nas sessões %", x = "") +
        theme_bw(
          base_size = 14,
          base_line_size = 11 / 22,
          base_rect_size = 11 / 22
        ) +
        geom_text(
          aes(label = paste0(Percentagem, "% (", n, ")"), y = Percentagem),
          position = position_dodge(width = 0.9),
          vjust = 1.5,
          hjust = 0.5
        ) +
        scale_y_continuous(limits = c(0, 100)) +
        expand_limits(x = c(0, 10)) +
        geom_hline(aes(yintercept = media)) +
        ggtitle("Formação de Agricultura")
      
      ggplotly(g1)
    })
    
    # Renderização do gráfico 2
    output$grafico_presencas2_cabo_delgado <- renderPlotly({
      filtered_data <- filtered_data()
      
      # Código para o gráfico de FormacaoPI
      filtered_data <- filtered_data %>%
        mutate(Comunidade = case_when(
          input$regiaocheck_cabo_delgado == "ALL" ~ "ALL",
          Comunidade %in% c("BALAMA", "MAMUNO", "MONTEPUEZ") ~ "BALAMA, MAMUNO, MONTEPUEZ",
          TRUE ~ Comunidade
        ))
      
      tab_freq_ag_cabo_delgado_formacaoPI <- filtered_data %>%
        group_by(FormacaoPI, Comunidade, Sexo, presenca, Deslocado) %>%
        summarise(n = n()) %>%
        mutate(
          freq = n / sum(n) * 100,
          Percentagem = round(freq, digits = 0)
        ) %>%
        ungroup() %>%
        filter(presenca == "SIM") %>%
        mutate(media = round(mean(Percentagem), digits = 0))
      
      g2 <- ggplot(tab_freq_ag_cabo_delgado_formacaoPI, aes(
        x = factor(FormacaoPI),
        y = Percentagem,
        fill = as.factor(Sexo)
      )) +
        geom_bar(stat = "identity", position = "dodge") +
        scale_fill_manual(values = c("#9442D4", "#F77333"), name = "SEXO") +
        labs(y = "Produtores presentes nas sessões %", x = "") +
        theme_bw(
          base_size = 14,
          base_line_size = 11 / 22,
          base_rect_size = 11 / 22
        ) +
        geom_text(
          aes(label = paste0(Percentagem, "% (", n, ")"), y = Percentagem),
          position = position_dodge(width = 0.9),
          vjust = -0.5,
          hjust = 0.5
        ) +
        scale_y_continuous(limits = c(0, 100)) +
        expand_limits(x = c(0, 10)) +
        geom_hline(aes(yintercept = media)) +
        ggtitle("Formação Iniciativa Pessoal")
      
      ggplotly(g2)
    })
    
    
    
    output$tabela_sexo_idade_cabo_delgado <- renderDataTable({
      datatable(comunidade %>%
                  filter(Nrsessao %in% input$SessaoComunidadeinf_cabo_delgado),
                extensions = 'Buttons',
                options = list(
                  pageLength = 10,
                  search = list(regex = TRUE, caseInsensitive = TRUE),
                  dom = 'lBfrtip',  # l para adicionar campos de filtro por variável
                  buttons = list(
                    list(
                      extend = 'collection',
                      text = 'BAIXAR',
                      buttons = list('excel', 'pdf')
                    )
                  ),
                  language = list(
                    search = 'Filtrar tabela:',
                    searchPlaceholder = 'Digite um termo para pesquisar',
                    lengthMenu = 'Mostrar _MENU_ entradas por página',
                    info = 'Mostrando página _PAGE_ de _PAGES_',
                    infoEmpty = 'Sem registros disponíveis',
                    paginate = list(
                      first = 'Primeira',
                      last = 'Última',
                      previous = 'Anterior'
                    )
                  )
                )
      ) %>%
        formatStyle(columns = c(1, 2, 3, 4, 5, 6))
    })
  
      
###Nampula
    output$tabela_sexo_idade <- renderDataTable({
      datatable(influentes %>%
                  filter(Regiao %in% input$REGIAOComunidadeinf, NrSessao %in% input$SessaoComunidadeinf),
                extensions = 'Buttons',
                options = list(
                  pageLength = 10,
                  search = list(regex = TRUE, caseInsensitive = TRUE),
                  dom = 'lBfrtip',  # l para adicionar campos de filtro por variável
                  buttons = list(
                    list(
                      extend = 'collection',
                      text = 'BAIXAR',
                      buttons = list('excel', 'pdf')
                    )
                  ),
                  language = list(
                    search = 'Filtrar tabela:',
                    searchPlaceholder = 'Digite um termo para pesquisar',
                    lengthMenu = 'Mostrar _MENU_ entradas por página',
                    info = 'Mostrando página _PAGE_ de _PAGES_',
                    infoEmpty = 'Sem registros disponíveis',
                    paginate = list(
                      first = 'Primeira',
                      last = 'Última',
                      #next = 'Próxima',
                      previous = 'Anterior'
                    )
                  )
                )
      ) %>%
        formatStyle(columns = c(1, 2, 3, 4, 5, 6))
    })

    
  ## PRESENÇAS Nampula
    output$grafico_presenca_nampula2 <- renderPlotly({
      if (input$regiaocheck == "All") {
        filtered_data <- presenca_nampula
      } else {
        filtered_data <- presenca_nampula %>%
          filter(Comunidade == input$regiaocheck)
      }
      
      if (input$deslocadocheck != "Todos") {
        filtered_data <- deslocado_Nampula %>%
          filter(deslocado == ifelse(input$deslocadocheck == "SIM", "SIM", "NAO"))
      }
      
      filtered_data <- filtered_data %>%
        mutate(Comunidade = case_when(
          input$regiaocheck == "All" ~ "All",
          Comunidade %in% c("Monapo", "Ribaue") ~ "Monapo, Ribaue",
          TRUE ~ Comunidade
        ))
      
      tab_freq_ag <- filtered_data %>%
        group_by(NomeSessao, Comunidade, Sexo, presenca) %>%
        summarise(n = n()) %>%
        mutate(
          freq = n / sum(n) * 100,
          Percentagem = round(freq, digits = 0)
        ) %>%
        ungroup()
      
      g <- tab_freq_ag %>%
        filter(presenca == "SIM") %>%
        mutate(media = round(mean(Percentagem), digits = 0)) %>%
        ggplot(aes(
          x = NomeSessao,
          y = Percentagem,
          fill = as.factor(Sexo),
          label = n  # Números de participantes
        )) +
        geom_bar(stat = "identity", position = "dodge") +
        scale_fill_manual(values = c("#9442D4", "#F77333"), name = "SEXO") +
        labs(y = "Produtores presentes nas sessões %", x = "Formação AG") +
        theme_bw(
          base_size = 14,
          base_line_size = 11 / 22,
          base_rect_size = 11 / 22
        ) +
        geom_text(
          position = position_dodge(width = 0.9),
          vjust = 0.5,     
          hjust = -0.5,     
          size = 3.5,       
          color = "white",
          aes(y = Percentagem + -20, label = paste0(Percentagem, "%"))  
        ) +
        geom_text(
          position = position_dodge(width = 0.9),
          vjust = 0.5,    
          hjust = -0.5,    
          size = 3.5,        
          color = "black",  
          aes(label = n)  
        ) +
        scale_y_continuous(limits = c(0, 100)) +
        expand_limits(x = c(0, 10)) +
        geom_hline(aes(yintercept = media)) +
        ggtitle("")
      
      plotly::ggplotly(g)
    })
    
    output$grafico_presenca_nampula <- renderPlotly({
      if (input$regiaocheck == "All") {
        filtered_data <- presenca_nampula
      } else {
        filtered_data <- presenca_nampula %>%
          filter(Comunidade == input$regiaocheck)
      }
      
      if (input$deslocadocheck != "Todos") {
        filtered_data <-  deslocado_Nampula %>%
          filter(deslocado == ifelse(input$deslocadocheck == "SIM", "SIM", "NAO"))
      }
      
      filtered_data <- filtered_data %>%
        mutate(Comunidade = case_when(
          input$regiaocheck == "All" ~ "All",
          Comunidade %in% c("Monapo", "Ribaue") ~ "Monapo, Ribaue",
          TRUE ~ Comunidade
        ))
      
      tab_freq_ag <- filtered_data %>%
        group_by(FormacaoPI, Comunidade, Sexo, presenca) %>%
        summarise(n = n()) %>%
        mutate(
          freq = n / sum(n) * 100,
          Percentagem = round(freq, digits = 0)  # Converter para numérico
        ) %>%
        ungroup()
      
      g <- tab_freq_ag %>%
        filter(presenca == "SIM") %>%
        mutate(media = round(mean(Percentagem), digits = 0)) %>%
        ggplot(aes(
          x = FormacaoPI,
          y = Percentagem,
          fill = as.factor(Sexo),
          label = n
        )) +
        geom_bar(stat = "identity", position = "dodge") +
        scale_fill_manual(values = c("#9442D4", "#F77333"), name ="SEXO") +
        labs(y = "Produtores presentes nas sessões %", x = "Formação PI") +
        theme_bw(
          base_size = 14,
          base_line_size = 11 / 22,
          base_rect_size = 11 / 22
        ) +
        geom_text(
          position = position_dodge(width = 0.9),
          vjust = 0.5,
          hjust = -0.5,
          color = "black",
          size = 3.5,
          fontface = "bold"
        ) +
        geom_text(
          aes(y = Percentagem + -20, label = paste0(Percentagem, "%")),  
          position = position_dodge(width = 1),
          vjust = 0.5,  
          hjust = -0.5,   
          color = "white",
          size = 3.5
        ) +
        scale_y_continuous(limits = c(0, 100)) +
        expand_limits(x = c(0, 10)) +
        geom_hline(aes(yintercept = media)) +
        ggtitle("")
      
      plotly::ggplotly(g)
    })
}



shinyApp(ui = ui, server = server)
