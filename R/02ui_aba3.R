ui_aba3 <- fluidPage(
   
  # Aba 'Overview'
  #navbarPage(
  title = "Navegação", 
  id = "main_tabs",   
  tabPanel("Visão Geral", 
           tabsetPanel( 
             tabPanel("Acompanhamento das Individual PI",
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
                 withSpinner(dataTableOutput("Tabelaindividual"))
               #plotOutput("Tabelaindividual")
               
              )
             )
  ), 
  tabPanel("Acompanhamento das Individual AG",
           sidebarLayout(
             sidebarPanel( 
               selectInput("ind_input_dist_ag", "Escolha o Distrito:",
                           choices = c("TODOS",unique(Presencas$Distrito)),
                           selected = "TODOS"),
               # selectInput("ind_input_com", "Escolha o Distrito:",
               #              choices = c("TODOS", unique(Presencas$Comunidade)),
               #              selected = "TODOS")
               uiOutput("com_select_ui_ag"),
               downloadButton("downloadDataINDIVIDUL_AG", "Baixar Tabela")
               # ... outros elementos UI para Sessões de PI
             ),
             mainPanel(
               withSpinner(dataTableOutput("Tabelaindividual_AG"))
               #plotOutput("Tabelaindividual")
               
             )
           )
  ),
  
  )
  ))
