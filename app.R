

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
                 radioButtons("distritoInput_namp", "Escolha o Distrito:", choices = c("Todos",unique(tab_freq_PI$Distrito)), selected = "Monapo")
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
             selectInput("DistritoInput", "Escolha o Distrito:", choices = c(unique(Kufungula$Distrito))),
             selectInput("ComunidadeInput", "Escolha a Comunidade:", choices = c(unique(Kufungula$Comunidade)))
             
           ),
           mainPanel(
             uiOutput("Tabelaindividual")
            # plotOutput("Tabelaindividual")
           )
         )
), #plotO
  ), 
  
))

# Lógica do servidor
server <- function(input, output) {

#######################APA GERAL ##########################################  
###GERAL
  
  # Filtrar dados baseado no distrito selecionado
  dadosFiltrados <- reactive({
    if (input$distritoInput == "Todos") {
      return(Kufungula)
    } else {
      return(subset(Kufungula, Província == input$distritoInput))
    }
  })
  
  # Gráfico de Registrados por Província
  output$registradosPorProvincia <- renderPlot({
    ggplot(dadosFiltrados(), aes(x = Distrito, fill = Sexo)) +
      geom_bar(position = "dodge") +
      scale_fill_manual(values = c(Feminino = "#9942D4", Masculino = "#F77333")) +
      labs(title = "Total de Registrados por Distrito e Sexo",
           x = "Distrito",
           y = "Total de Registrados") +
      theme_stata() +
      geom_text(aes(label = ..count..), stat = "count", position = position_dodge(width = 0.9), vjust = -0.25)
  })
   
  ###DESLOCADOS 
  
  output$deslocadosPorProvincia <- renderPlot({
    ggplot(subset(dadosFiltrados(), Deslocado == "Sim"), aes(x = Distrito, fill = Sexo)) +
      geom_bar(position = "dodge") +
      scale_fill_manual(values = c(Feminino = "#9942D4", Masculino = "#F77333")) +
      labs(title = "Número de Deslocados por Província e Sexo",
           x = "Província",
           y = "Número de Deslocados") +
      theme_stata() +
      geom_text(aes(label = ..count..), stat = "count", position = position_dodge(width = 0.9), vjust = -0.25)
  })
  
  output$download_inscritos <- downloadHandler(
    filename = function() {
      "Produtores_inscritos.xlsx"
    },
    content = function(file) {
      write.xlsx(Kufungula, file)
    }
  )
  
##########################################FIM DE APA GERAL##################### 
  
 
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
        DTOutput("tabelaind")
        )
    })
    
    
  })
  # ####FORMACAO PI NAMPULA
   

    
  # Função reativa para filtrar os dados
   
  # RenderPlot para o gráfico ###formacao PI
   output$plot1_1 <- renderPlot({
  data <- filter(tab_freq_PI, Distrito == input$distritoInput_namp) 
  ggplot(data, aes(x = FormacaoPI, y = Percentagem, color = Sexo, group = Sexo)) +
    geom_bar(stat = "identity", position = position_dodge()) +
    scale_color_manual(values = c(Feminino = "#9942D4", Masculino = "#F77333")) +
    geom_text(aes(label = paste(n, " (", Percentagem, "%)", sep = "")), 
              vjust = -0.5) +
    labs(title = "Percentagem de Presença por Formação PI e Sexo",
         x = "Formação PI",
         y = "Percentagem") +
    theme_stata()
})

  
 
  
 
  
  ###
  output$plot1_2 <- renderPlot({
     data<-filter(tab_freq_AG, Distrito==input$distritoInput_namp)
    ggplot(data,aes(x = NomeSessao, y = Percentagem, fill = Sexo)) +
      geom_bar() +
      scale_fill_manual(values = c(Feminino = "#9942D4", Masculino = "#F77333")) +
      geom_text(aes(label = paste(n, " (", Percentagem, "%)", sep = "")), 
                position = position_dodge(width = 0.9), 
                vjust = -0.5) +
      labs(title = "Percentagem de Presença por Formação PI e Sexo",
           x = "Formação PI",
           y = "Percentagem") +
      theme_stata()
    
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

# Executar o aplicativo
shinyApp(ui = ui, server = server)
