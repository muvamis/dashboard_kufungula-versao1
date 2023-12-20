ui_aba2 <- fluidPage(
  
  tabPanel("Participação Global",
         tabsetPanel(
           tabPanel("Sessões de PI",
                    sidebarLayout(
                      sidebarPanel(
                        radioButtons("distritoInput_namp_pi", "Escolha o Distrito:",
                                     choices = c("Todos", unique(Presencas$Distrito)),
                                     selected = "MONAPO")
                        # ... outros elementos UI para Sessões de PI
                      ),
                      mainPanel(
                        # ... conteúdo do painel principal para Sessões de PI
                      )
                    )
           ),
           tabPanel("Sessões de AG",
                    sidebarLayout(
                      sidebarPanel(
                        # ... elementos UI para Sessões de AG
                      ),
                      mainPanel(
                        # ... conteúdo do painel principal para Sessões de AG
                      )
                    )
           ),
           tabPanel("Tabela",
                    sidebarLayout(
                      sidebarPanel(
                        # ... elementos UI para Tabela
                      ),
                      mainPanel(
                        # ... conteúdo do painel principal para Tabela
                      )
                    )
           )
           # ... outras subabas se necessário
         )
)) 
