

# Interface do usuário com tema 'flatly'
ui <- fluidPage(
  theme = shinytheme("flatly"),
  
  # Título do Dashboard
  titlePanel("Dashboard Kufungula - Abrindo Oportunidades"),
  
  # Abas principais com navbarPage
  navbarPage(
    title = "Navegação", 
    id = "main_tabs",
    
    # Aba 'Overview'
    
    tabPanel("Visão Geral",
             sidebarLayout(
               sidebarPanel(
                 selectInput("distritoInput", "Escolha a Provincia:", choices = c("Todos",unique(Kufungula$Província)), selected = "Todos")),
               mainPanel(
                 downloadButton("download_inscritos", "Baixar Inscritos", icon = icon("download")),
                 plotOutput("registradosPorProvincia"),
                 plotOutput("deslocadosPorProvincia")
               )
             )
    ),   
    
    # Aba 'Nampula'
    navbarMenu("Nampula",
               tabPanel("Participação Global",
                        sidebarLayout(
                          sidebarPanel(
                            (actionButton("btn1_1", "Sessões de PI")),
                            (actionButton("btn1_2", "Sessões de AG")),
                            (actionButton("btn1_3", "Tabela")),
                            radioButtons("distritoInput_namp", "Escolha o Distrito:", choices = c("Todos",unique(Presencas$Distrito)), selected = "MONAPO")
                            #selectInput
                            
                            
                          ),
                          mainPanel(
                            uiOutput("tab1_content"),
                            uiOutput("tab1"),
                          )
                        )
               ),
               ##individual 
               tabPanel("Participação Individual",
                        sidebarLayout(
                          sidebarPanel(
                            actionButton("btn2_1", "Sessões de PI"),
                            actionButton("btn2_2", "Sessões de AG"),
                            radioButtons("DistritoInput_ind", "Escolha o Distrito:", choices = c(unique(Kufungula$Distrito))),
                            radioButtons("ComunidadeInput_ind", "Escolha a Comunidade:", choices = c(unique(Kufungula$Comunidade)))
                            
                          ),
                          mainPanel(
                            # uiOutput("Tabelaindividual")
                            plotOutput("Tabelaindividual")
                          )
                        )
               ), #plotO
    ), 
    
  ))

# Lógica do servidor
server <- function(input, output) {
  
 
  
  
  # Conteúdo dinâmico para a Aba 'Nampula'
  observeEvent(input$btn1_1, {
    output$tab1_content <- renderUI({
      wellPanel(
        plotOutput("plot1_1")
      )
    })
  })
  
  observeEvent(input$btn1_2, {
    output$tab1_content <- renderUI({
      wellPanel(
        plotOutput("plot1_2")
      )
    })
  })
  
  observeEvent(input$btn1_3, {
    output$tab1_content <- renderUI({
      wellPanel(
        DTOutput("table1_3"),
        DTOutput("table2")
      )
    })
    
    
  })
  
  observeEvent(input$btn2_1, {
    output$Tabelaindividual <- renderUI({
      wellPanel(
        plotOutput("Tabelaindividual")
      )
    })
    
    
  })
  # ####FORMACAO PI NAMPULA
  
  
  
  # Função reativa para filtrar os dados
  ####  
  dadosFiltrados_PI <- reactive({
    if (input$distritoInput_namp== "Todos") {
      return(tab_freq_PI_all)
    } else {
      return(filter(tab_freq_PI, Distrito == input$distritoInput_namp))
    }
  })
  # RenderPlot para o gráfico ###formacao PI
  output$plot1_1 <- renderPlot({
    # Seu código para criar tab_freq_PI
    
    dadosFiltrados_PI() %>%
      filter(!is.na(Sexo)) %>%
      filter(presenca %in% "SIM") %>%
      ggplot() +
      aes(x = FormacaoPI, y = Percentagem,  fill = as.factor(Sexo)) +
      geom_col(position = position_dodge()) +
      scale_color_manual(values = c("#9442D4", "#F77333"), name = "SEXO") +
      labs(y = "Produtores presentes nas sessões %", x = "Numero de Sessões") +
      theme_bw(
        base_size = 14,
        base_line_size = 11 / 22,
        base_rect_size = 11 / 22
      ) +
      geom_text(
        aes(label = sprintf("%d (%.0f%%)", n, Percentagem)),
        position = position_dodge(width = 0.9),
        vjust = 1.5,
        hjust = 0.5
      ) +
      scale_y_continuous(limits = c(0, 100))+
      expand_limits(y = 100)
    
  })
  
  
  
  # Função reativa para filtrar os dados
  ####  
  dadosFiltrados_AG<- reactive({
    if (input$distritoInput_namp == "Todos") {
      return(tab_freq_AG_all)
    } else {
      return(subset(tab_freq_AG, Distrito == input$distritoInput_namp))
    }
  })
  
  ###
  output$plot1_2 <- renderPlot({
    
    dadosFiltrados_AG() %>%
      filter(!is.na(Sexo)) %>%
      filter(presenca %in% "SIM") %>%
      ggplot() +
      aes(x = NomeSessao, y = Percentagem,  fill = as.factor(Sexo)) +
      geom_col(position = position_dodge()) +
      scale_color_manual(values = c("#9442D4", "#F77333"), name = "SEXO") +
      labs(y = "Produtores presentes nas sessões %", x = "Numero de Sessões") +
      theme_bw(
        base_size = 14,
        base_line_size = 11 / 22,
        base_rect_size = 11 / 22
      )  +
      geom_text( 
        aes(label = sprintf("%d (%.0f%%)", n, Percentagem)),
        position = position_dodge(width = 0.9),
        vjust = 1.5,
        hjust = 0.5
      ) +
      scale_y_continuous(limits = c(0, 100))+
      expand_limits(y = 100)
    
    
    
  }) 
  
  
  output$table1_3 <- renderDataTable({
    if (input$distritoInput_namp=="Todos") { 
      datatable(tabela, escape = FALSE) # O parâmetro escape = FALSE permite HTML
      
      {#       datatable(
        #         resultado,
        #         extensions = 'Buttons',
        #         options = list(
        #           pageLength = 10,
        #           search = list(regex = TRUE, caseInsensitive = TRUE),
        #           dom = 'lBfrtip',  # l para adicionar campos de filtro por variável
        #           buttons = list(
        #             list(
        #               extend = 'collection',
        #               text = 'BAIXAR',
        #               buttons = list('excel', 'pdf', 'print')
        #             )
        #           ),
        #           language = list(
        #             search = 'Filtro:',
        #             searchPlaceholder = 'Pesquisar',
        #             lengthMenu = 'Mostrar _MENU_ por página',
        #             info = 'Mostrando página _PAGE_ de _PAGES_',
        #             infoEmpty = 'Sem registros disponíveis',
        #             paginate = list(
        #               first = 'Primeira',
        #               last = 'Última',
        #               #next = 'Próxima',
        #               previous = 'Anterior'
        #             ))
        #         )
      }# )   #tabela_formatada
      
    }  
  }) 
  
  #output$tableind<- renderDT() 
  
  output$table2 <- renderDT(datatable(
    
    datatable(tabela, escape = FALSE) # O parâmetro escape = FALSE permite HTML
    
  ))
  # Implemente a lógica para outras abas e seus respectivos submenus
  # ...
} 

##########Individual #####################
# Dados reativos que mudam com base nos inputs do usuário
dados_filtrados_ind <- reactive({
  # Filtra o data.frame baseado na seleção do usuário
  Data_Individual_PI %>%
    filter(Distrito == input$DistritoInput, Comunidade == input$ComunidadeInput)
})

# Observe o evento para o botão que carrega o gráfico de participação individual
observeEvent(input$btn2_1, {
  output$Tabelaindividual <- renderPlot({
    # Certifique-se de que 'dados_filtrados_ind()' retorna um dataframe com as colunas corretas
    df <- dados_filtrados_ind()
    df$cor <- ifelse(df$presenca == 'SIM', 'green', 'red') # Adicione a coluna 'cor'
    
    ggplot(df, aes(x = NomeSessao, y = Nome_Participante, color = cor)) +
      geom_point(size = 4) +
      scale_color_identity() +
      labs(title = 'Presença dos Participantes por Sessão',
           x = 'Nome da Sessão',
           y = 'Nome do Participante') +
      theme_minimal() +
      theme(axis.text.x = element_text(angle = 90, hjust = 1),
            axis.title.x = element_blank(),
            axis.title.y = element_blank()) +
      scale_x_discrete(position = "top")
  })
})



# Executar o aplicativo
shinyApp(ui = ui, server = server)
