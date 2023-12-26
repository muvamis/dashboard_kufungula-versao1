ui_aba2 <- fluidPage(
   
  tabPanel("Participação Global",
         tabsetPanel(
           tabPanel("Sessões de PI",
                    sidebarLayout(
                      sidebarPanel( 
                        radioButtons("distritoInput_namp_pi", "Escolha o Distrito:",
                                     choices = c("TODOS", unique(Presencas$Distrito)),
                                     selected = "TODOS")
                        # ... outros elementos UI para Sessões de PI
                      ),
                      mainPanel(
                        plotOutput("graficoParticipacaoGlobal")
                      )
                    )
           ),
           tabPanel("Sessões de AG",
                    sidebarLayout(
                      sidebarPanel(
                        radioButtons("distritoInput_namp_AG", "Escolha o Distrito:",
                                     choices = c("TODOS", unique(Presencas$Distrito)),
                                     selected = "TODOS")
                        
                      ),
                      mainPanel(
                        plotOutput("graficoParticipacaoGlobal_AG") 
                      )
                    )
           ),
           tabPanel("Tabela",
                    sidebarLayout(
                      sidebarPanel(
                        radioButtons("tabela_sessao", "Escolha o tipo de formacao:",
                                     choices = c("PI", "AG"),
                                     selected = "PI")
                      ),
                      mainPanel(
                        dataTableOutput("Tabelasessao")
                      )
                    )
           )
           # ... outras subabas se necessário
         )
)) 
