
# Define UI
ui <- fluidPage(
  
  # Define o tema
  theme = shinytheme("flatly"),
  
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
                        wellPanel(p("")),
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
                                        wellPanel(h4("O gráfico abaixo ilustra o número total de desistentes que participaram de no mínimo 3 sessões da informação"),
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
    navbarMenu("Nampula", icon=icon("exchange-alt"),
               tabPanel("Presenças", tabname="tab_presencas", icon=icon("chart-line"),
                        
                        column(12,
                               tabsetPanel(type = "tab",
                                           tabPanel(
                                             "Presenças",
                                             column(2, 
                                                    wellPanel(
                                                      h4("Filtro"),
                                                      radioButtons("regiaocheck", label =("Distrito"), choices =unique(presenca_produtores$Comunidade))
                                                      
                                                    )
                                             ),
                                             column(10, 
                                                    wellPanel(h4("O gráfico abaixo mostra as percentagens dos produtores que participaram em cada sessão, no distrito selecionado")),
                                                    withSpinner(plotlyOutput("grafico_presenca", height = 500),color="black"),
                                                    
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
                                           tabPanel(
                                             "Resultados",
                                             column(12,
                                                    wellPanel(
                                                      h4("A tabela abaixo mostra o número de participantes por sexo que participaram nas sessões com idades <> que 24 anos")),
                                                    column(2,
                                                           selectInput("REGIAOComunidadeinf", label = "Região",
                                                                       choices = unique(influentes$Regiao), multiple = TRUE, selected = ("Nampula")),
                                                           selectInput("SessaoComunidadeinf", label = "Selecione o número da sessão",
                                                                       choices = unique(influentes$NrSessao), multiple = TRUE, selected = 1)),
                                             ),
                                             column(10,
                                                    withSpinner(dataTableOutput("tabela_sexo_idade", height = 500), color="black"))
                                           )
                                           ),
                                           
                                           
                               )
                        )
                        
               ),
             
    
    navbarMenu("Cabo Delgado", icon=icon("exchange-alt"),
               tabPanel(
                 "Presenças",tabname="tab_presencas_cabo_delgado", icon=icon("chart-line"), 
                        column(12,
                               tabsetPanel(type = "tab",
                                           tabPanel(
                                             "Presenças",
                                           column(2, wellPanel(h4("Filtro"), criarPainelFiltro("regiaocheck_cabo_delgado", "Distrito", unique(cabo_delgado_data$Comunidade)))),
                                        column(10,
                                                      wellPanel(h4("O gráfico abaixo mostra as percentagens dos produtores que participaram em cada sessão, no distrito selecionado")),
                                      withSpinner(plotlyOutput("grafico_presenca_cabo_delgado", height = 500),color="black"),
                                      conditionalPanel(
                                        condition = "input.regiaocheck_cabo_delgado == 'Montepuez'",
                                        downloadButton("download_montepuez_cabo_delgado", "Lista de Presenças Montepuez")
                                      ),
                                      conditionalPanel(
                                        condition = "input.regiaocheck_cabo_delgado == 'Balama'",
                                        downloadButton("download_balama_cabo_delgado", "Lista de Presenças balama")
                                      )
                        )),
               tabPanel("Resultados",
                        column(12,
                               wellPanel(
                                 h4("A tabela abaixo mostra o número de participantes por sexo que participaram nas sessões com idades <>= 24 anos"))),
                        criarPainelSelecao("REGIAOComunidadeinf_cabo_delgado", "Selecione a Região", unique(comunidade$regiao),
                                           "SessaoComunidadeinf_cabo_delgado", "Selecione o número da sessão", unique(comunidade$Nrsessao)),
                               column(10,
                                      withSpinner(dataTableOutput("tabela_sexo_idade_cabo_delgado", height = 500), color="black"))
                               
               )          )
                   )    
               )
    )
  )
)

server <- function(input, output) {
   
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
  ####páginas 

#### Gráficos e tabelas para a página "Cabo Delgado"
   
 output$grafico_presenca_cabo_delgado <- renderPlotly({
     tab_freq_ag_cabo_delgado <- cabo_delgado_data %>%
       group_by(nrSessao, Comunidade, Sexo, presenca) %>%
       summarise(n = n()) %>%
       mutate(
         freq = n / sum(n) * 100,
         Percentagem = round(freq, digits = 0)
       ) %>%
       ungroup()
     g = filter(tab_freq_ag_cabo_delgado, Comunidade == input$regiaocheck_cabo_delgado, presenca == "SIM") %>%
       mutate(media = round(mean(Percentagem), digits = 0)) %>%
       ggplot(aes(
         x = nrSessao,
         y = Percentagem,
         color = as.factor(Sexo)
       )) +
       geom_line() +
       scale_color_manual(values = c("#9442D4", "#F77333"), name = "SEXO") +
       labs(y = "Produtores presentes nas sessões %", x = "Numero de Sessões") +
       theme_bw(
         base_size = 14,
         base_line_size = 11 / 22,
         base_rect_size = 11 / 22
       ) +
       geom_point() +
       geom_text(
         aes(label = Percentagem, y = Percentagem),
         position = position_dodge(width = 0.9),
         vjust = 1.5,
         hjust = 0.5
       ) +
       scale_y_continuous(limits = c(0, 100)) +
       scale_x_continuous(limits = c(0, 10), breaks = seq(0, 10, 2)) +
       expand_limits(x = c(0, 10)) +
       geom_hline(aes(yintercept = media)) +
       ggtitle("Produtores presente nas sessões")
    })
    
    output$tabela_sexo_idade_cabo_delgado <- renderDataTable({
      datatable(comunidade %>%
                  filter(regiao %in% input$REGIAOComunidadeinf_cabo_delgado, Nrsessao %in%input$SessaoComunidadeinf_cabo_delgado),
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
  
  output$grafico_presenca <- renderPlotly({
    tab_freq_ag <- presenca_produtores %>%
      group_by(NUMERODASESSÃO, Comunidade, Sexo, presenca) %>%
      summarise(n = n()) %>%
      mutate(
        freq = n / sum(n) * 100,
        Percentagem = round(freq, digits = 0)
      ) %>%
      ungroup()
    
    g = filter(tab_freq_ag, Comunidade == input$regiaocheck, presenca == "SIM") %>%
      mutate(media = round(mean(Percentagem), digits = 0)) %>%
      ggplot(aes(
        x = NUMERODASESSÃO,
        y = Percentagem,
        color = as.factor(Sexo)
      )) +
      geom_line() +
      scale_color_manual(values = c("#9442D4", "#F77333"), name = "SEXO") +
      labs(y = "Produtores presentes nas sessões %", x = "Numero de Sessões") +
      theme_bw(
        base_size = 14,
        base_line_size = 11 / 22,
        base_rect_size = 11 / 22
      ) +
      geom_point() +
      geom_text(
        aes(label = Percentagem, y = Percentagem),
        position = position_dodge(width = 0.9),
        vjust = 1.5,
        hjust = 0.5
      ) +
      scale_y_continuous(limits = c(0, 100)) +
      scale_x_continuous(limits = c(0, 10), breaks = seq(0, 10, 2)) +
      expand_limits(x = c(0, 10)) +
      geom_hline(aes(yintercept = media)) +
      ggtitle("Produtores presente nas sessões")
  })
}



shinyApp(ui = ui, server = server)
