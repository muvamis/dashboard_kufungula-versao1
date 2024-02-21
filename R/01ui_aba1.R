ui_aba1 <- fluidPage(
    
    # Aba 'Overview'
  #navbarPage(
    title = "Navegação", 
    id = "main_tabs",   
    tabPanel("Visão Geral", 
             sidebarLayout(
               sidebarPanel(
                 selectInput("ProvinciaInput", "Escolha a Provincia:", choices = c("Todos",unique(Kufungula$Provincia)), selected = "Todos"),
                 selectInput("distritoInputGeral", "Escolha o Distrito:", choices = c("Todos",unique(Kufungula$Distrito)), selected = "Todos"),
                 selectInput("comunidadeInputGeral", "Escolha a Comunidade:", choices = c("Todos",unique(Kufungula$Comunidade)), selected = "Todos")),
               mainPanel(
                 downloadButton("download_inscritos", "Baixar Inscritos", icon = icon("download")),
                 plotOutput("registradosPorProvincia"),
                 plotOutput("deslocadosPorProvincia"),
                 plotOutput("desistentesInput")
               )
             )
  #  )
))