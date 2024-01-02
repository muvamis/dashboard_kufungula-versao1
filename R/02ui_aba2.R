ui_aba2 <- fluidPage(
  tabPanel("Participação Global",
           tabsetPanel( 
             tabPanel("Sessões de PI",
                      sidebarLayout(
                        sidebarPanel(
                          radioButtons("distritoInput_namp_pi", "Escolha o Distrito:",
                                       choices = c("TODOS", unique(Presencas$Distrito)),
                                       selected = "TODOS"),
                          selectInput("comunidadeInput_namp_pi", "Escolha a Comunidade:",
                                      choices = c("TODAS", unique(Presencas$Comunidade)),
                                      selected = "TODAS")
                          # ... outros elementos UI para Sessões de PI
                        ),
                        mainPanel(
                          withSpinner(plotOutput("graficoParticipacaoGlobal"))
                        )
                      )
             ),
             tabPanel("Sessões de AG",
                      sidebarLayout(
                        sidebarPanel(
                          radioButtons("distritoInput_namp_AG", "Escolha o Distrito:",
                                       choices = c("TODOS", unique(Presencas$Distrito)),
                                       selected = "TODOS"),
                          selectInput("comunidadeInput_namp_AG", "Escolha a Comunidade:",
                                      choices = c("TODAS", unique(Presencas$Comunidade)),
                                      selected = "TODAS")
                          # ... outros elementos UI para Sessões de AG
                        ),
                        mainPanel(
                          withSpinner(plotOutput("graficoParticipacaoGlobal_AG"))
                        )
                      )
             ),
             tabPanel("Tabela",
                      sidebarLayout(
                        sidebarPanel(
                          radioButtons("tabela_sessao", "Escolha o tipo de formacao:",
                                       choices = c("PI", "AG"),
                                       selected = "PI"),
                          selectInput("comunidadeInput_tabela", "Escolha a Comunidade:",
                                      choices = c("TODAS", unique(Presencas$Comunidade)),
                                      selected = "TODAS"),
                          downloadButton("downloadDatatABELA", "Baixar Tabela")
                        ),
                        mainPanel(
                          withSpinner(dataTableOutput("Tabelasessao"))
                        )
                      )
             )
             # ... outras subabas se necessário
           )
  )
)
