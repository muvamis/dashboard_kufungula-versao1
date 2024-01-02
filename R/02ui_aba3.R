ui_aba3 <- fluidPage(
   
  # Aba 'Overview'
  #navbarPage(
  title = "Navegação", 
  id = "main_tabs",   
  tabPanel("Visão Geral", 
           
           sidebarLayout(
             sidebarPanel( 
               selectInput("ind_input_dist", "Escolha o Distrito:",
                            choices = c("TODOS",unique(Presencas$Distrito)),
                            selected = "TODOS"),
               # selectInput("ind_input_com", "Escolha o Distrito:",
               #              choices = c("TODOS", unique(Presencas$Comunidade)),
               #              selected = "TODOS")
               uiOutput("com_select_ui"),
               downloadButton("downloadDataINDIVIDUL", "Baixar Tabela")
                 # ... outros elementos UI para Sessões de PI
               ),
               mainPanel(
               dataTableOutput("Tabelaindividual")
               #plotOutput("Tabelaindividual")
               
              )
             )
  ))
