ui_aba1 <- fluidPage(
   
    # Aba 'Overview'
  #navbarPage(
    title = "Navegação", 
    id = "main_tabs",   
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
  #  )
))