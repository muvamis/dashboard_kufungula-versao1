ui_aba5 <- fluidPage(
  tabsetPanel( 
    tabPanel("Visão Geral",
             column(12,
                    wellPanel(("DADOS DE REGISTO KUFUNGULA CABO DELGADO")),
                    (withSpinner(plotOutput("registradoscabodelgado"), color = "black"))
             ),
             column(6,
                    wellPanel((" ")),
                    (withSpinner(plotOutput("deslocadosCabodelgado"), color = "black"))
             ),
             column(6,
                    wellPanel((" ")),
                    (withSpinner(plotOutput("vendaCabodelgado"), color = "black"))
            )
    ),
    tabPanel("Lista Global",
             sidebarLayout(
               sidebarPanel(
                 # Dropdown para selecionar distrito
                 selectInput("distrito", "Selecione o Distrito:",
                             c("Todos", unique(lista_cabodelgado$DISTRITO))),
                 # Dropdown para selecionar comunidade
                 selectInput("comunidade", "Selecione a Comunidade:",
                             c("TODAS", unique(lista_cabodelgado$COMUNIDADE))),
                 # Botão para download
                 downloadButton("downloadData", "Baixar Tabela")
               ),
               mainPanel(
                 dataTableOutput("lista_cabodelgado")
               )
             )
    )
  )
)