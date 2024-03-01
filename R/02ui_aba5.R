ui_aba5 <- fluidPage(
  
  # Aba 'Overview' 
  #navbarPage(
  title = "Navegação", 
  id = "main_tabs",      
  tabPanel("Visão Geral", 
           sidebarLayout(
             sidebarPanel(
               radioButtons("ProvinciaInputCD", "DADOS DA PROVINCIA DE:", choices = "Cabo Delgado"),
               selectInput("distritoInputGeralCD", "Escolha o Distrito:", choices = c("Todos",unique(lista_cabodelgado$DISTRITO)), selected = "Todos"),
               selectInput("comunidadeInputGeralCD", "Escolha a Comunidade:", choices = c("Todos",unique(lista_cabodelgado$COMUNIDADE)), selected = "Todos")),
             mainPanel(
               plotOutput("registradoscabodelgado"),
               plotOutput("IdadeCabodelgado")
             )
           )
           #  )
  ))