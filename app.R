library(shiny)
library(shinythemes)    
  
# Carregar UIs e Servers de abas individuais 
source("R/01ui_aba1.R")
# source("R/server_aba1.R")  
source("R/02ui_aba2.R")  
# source("R/server_aba2.R") 
# ... (outros sources conforme necessário)

# Interface do usuário principal
ui <- fluidPage(
  theme = shinytheme("flatly"),
  titlePanel("Dashboard Kufungula - Abrindo Oportunidades"),
  navbarPage("Navegação",
             tabPanel("Visão Geral", ui_aba1),
              navbarMenu("Nampula",
                 tabPanel("Participação Global", ui_aba2),
               tabPanel("Participação Individual", ui_aba3)
             #
             #
              ),
             navbarMenu("Cabo Delgado",
                        tabPanel("Participação Global", ui_aba5),
                        tabPanel("Participação Individual", ui_aba4)


             )
              
             # ... (outras abas) 
  ) 
) 

# Lógica do servidor principal
server <- function(input, output, session) {
  
  
    #######################APA GERAL ##########################################  
  #baixar dados 
 # https://dashboard.muvamoz.org/dashboard/2023/dashboard_kufungula-versao1
   
  ###########################baixar dados de inscritos####################################
  output$download_inscritos <- downloadHandler(
    filename = function() {
      "Kufungula.xlsx"
    },
    content = function(file) {
      write_xlsx(Kufungula, path = file) 
    }
  )
  # Atualizando 'distritoInputGeral' com base na província selecionada
  observeEvent(input$ProvinciaInput, {
    distritos <- if (input$ProvinciaInput == "Todos") {
      unique(Kufungula$Distrito)
    } else {
      unique(Kufungula$Distrito[Kufungula$Provincia == input$ProvinciaInput])
    }
    updateSelectInput(session, "distritoInputGeral", choices = c("Todos", distritos))
  })

  #################################
######################### Atualizando 'comunidadeInputGeral' com base no distrito selecionado
  
  observeEvent(input$distritoInputGeral, {
    comunidades <- if (input$distritoInputGeral == "Todos") {
      unique(Kufungula$Comunidade)
    } else {
      unique(Kufungula$Comunidade[Kufungula$Distrito == input$distritoInputGeral])
    }
    updateSelectInput(session, "comunidadeInputGeral", choices = c("Todos", comunidades))
  })

    # Função reativa para filtrar dados
    dadosFiltrados <- reactive({
      dados <- Kufungula
      # Defina os intervalos de idade
      dados$Etaria <- cut(
        dados$Idade,
        breaks = c(18, 24, 35),
        labels = c("18-24", "25-35"),
        include.lowest = TRUE
      )
      if (input$ProvinciaInput != "Todos") {
        dados <- dados[dados$Provincia == input$ProvinciaInput,]
      }
      if (input$distritoInputGeral != "Todos") {
        dados <- dados[dados$Distrito == input$distritoInputGeral,]
      }
      if (input$comunidadeInputGeral != "Todos") {
        dados <- dados[dados$Comunidade == input$comunidadeInputGeral,]
      }
      dados
    })
     
 
    # Gráfico de barras para 'registradosPorProvincia'
    output$registradosPorProvincia <- renderPlot({
      dados <- dadosFiltrados()
      eixo_x <- if (input$comunidadeInputGeral != "Todos") { 
        aes(x = Comunidade, fill = Sexo)
      } else {
        aes(x = Distrito, fill = Sexo)
      }
      ggplot(dados, eixo_x) +
        geom_bar(position = "dodge") +
        scale_fill_manual(values = c(FEMININO = "#9942D4", MASCULINO = "#F77333")) +
        labs(title = "Total de Registrados por Distrito/Comunidade e Sexo",
             x = ifelse(input$comunidadeInputGeral != "Todos", "Comunidade", "Distrito"),
             y = "Total de Registrados") +
        theme_stata() +
        geom_text(aes(label = ..count..), stat = "count", position = position_dodge(width = 0.9), vjust = -0.25)
    }) 
    
    # Gráfico de barras para 'deslocadosPorProvincia'
    output$deslocadosPorProvincia <- renderPlot({
      
      dados <- dadosFiltrados()
      ggplot(dados, aes(x = Etaria, fill = Sexo)) +
        geom_bar(position = "dodge", stat = "count") +
        scale_fill_manual(values = c(FEMININO = "#9942D4", MASCULINO = "#F77333")) +
        labs(title = "Distribuição de Idades por Sexo",
             x = "Faixa Etária",
             y = "Contagem") +theme_stata() +
        geom_text(stat = "count", aes(label = ..count..),
          position = position_dodge(width = 0.9), vjust = -0.5, size = 3)  
    }) 
    #   dados <- subset(dadosFiltrados(), Deslocado == "Sim")
    #   eixo_x <- if (input$comunidadeInputGeral != "Todos") {
    #     aes(x = Comunidade, fill = Sexo)
    #   } else {
    #     aes(x = Distrito, fill = Sexo)
    #   }
    #   ggplot(dados, eixo_x) +
    #     geom_bar(position = "dodge") +
    #     scale_fill_manual(values = c(FEMININO = "#9942D4", MASCULINO = "#F77333")) +
    #     labs(title = "Número de Deslocados por Distrito/Comunidade e Sexo",
    #          x = ifelse(input$comunidadeInputGeral != "Todos", "Comunidade", "Distrito"),
    #          y = "Número de Deslocados") +
    #     theme_stata() +
    #     geom_text(aes(label = ..count..), stat = "count", position = position_dodge(width = 0.9), vjust = -0.25)
    # })
####################FIM DE GERAL ##########################################################
    
############## Nampula ########
###########   PI  ################

    observeEvent(input$distritoInput_namp_pi, {
      # Filtrar as comunidades com base no distrito selecionado
      comunidades_filtradas <- if (input$distritoInput_namp_pi == "TODOS") {
        unique(Presencas$Comunidade)
      } else {
        unique(Presencas$Comunidade[Presencas$Distrito == input$distritoInput_namp_pi])
      }
      
      # Atualizar as opções de comunidade
      updateSelectInput(session, "comunidadeInput_namp_pi",
                        choices = c("TODAS", comunidades_filtradas))
    })
    dadosFiltrados_PI <- reactive({
  # Filtrar com base na seleção de distrito
  dados_filtrados <- if (input$distritoInput_namp_pi == "TODOS") {
    presencas_PI
  } else {
    filter(presencas_PI, Distrito == input$distritoInput_namp_pi)
  }

  # Filtrar com base na seleção de comunidade
  if (input$comunidadeInput_namp_pi != "TODAS") {
    dados_filtrados <- filter(dados_filtrados, Comunidade == input$comunidadeInput_namp_pi)
  }

  # Chamar a função calcular_frequencias com os dados filtrados
  calcular_frequencias(dados_filtrados, FormacaoPI, Sexo, Presenca_PI)
})

  # RenderPlot para o gráfico ###formacao PI
  output$graficoParticipacaoGlobal <- renderPlot({
    # Seu código para criar tab_freq_PI

    dadosFiltrados_PI() %>%
      filter(!is.na(Sexo)) %>%
      filter(Presenca_PI %in% "SIM") %>%
      ggplot() +
      aes(x = FormacaoPI, y = n,  fill = as.factor(Sexo)) +
      geom_col(position = position_dodge()) +
      scale_color_manual(values = c("#9442D4", "#F77333"), name = "SEXO") +
      labs(y = "Produtores presentes nas sessões %", x = "Numero de Sessões") +
      theme_bw(
        base_size = 14,
        base_line_size = 11 / 22,
        base_rect_size = 11 / 22
      ) +
      geom_text(
        #aes(label = sprintf("%d (%.0f%%)", n, Percentagem)),
        aes(label = n),
        position = position_dodge(width = 0.9),
        vjust = 1.5,
        hjust = 0.5
      ) +
      scale_y_continuous(limits = c(0, 300))+
      expand_limits(y = 300)

  })
  

######################## input filtro#################################
  observeEvent(input$distritoInput_namp_AG, {
    # Filtrar as comunidades com base no distrito selecionado
    comunidades_filtradas <- if (input$distritoInput_namp_AG == "TODOS") {
      unique(Presencas$Comunidade)
    } else {
      unique(Presencas$Comunidade[Presencas$Distrito == input$distritoInput_namp_AG])
    }
    
    # Atualizar as opções de comunidade
    updateSelectInput(session, "comunidadeInput_namp_AG",
                      choices = c("TODAS", comunidades_filtradas))
  })
  dadosFiltrados_AG <- reactive({
    # Filtrar com base na seleção de distrito
    dados_filtrados <- if (input$distritoInput_namp_AG == "TODOS") {
      presencas_AG
    } else {
      filter(presencas_AG, Distrito == input$distritoInput_namp_AG)
    }
    
    # Filtrar com base na seleção de comunidade
    if (input$comunidadeInput_namp_AG != "TODAS") {
      dados_filtrados <- filter(dados_filtrados, Comunidade == input$comunidadeInput_namp_AG)
    }
    
    # Chamar a função calcular_frequencias com os dados filtrados
    calcular_frequencias(dados_filtrados, NomeSessao, Sexo, Presenca_AG)
  })
  # RenderPlot para o gráfico ###formacao PI
  output$graficoParticipacaoGlobal_AG <- renderPlot({
    # Seu código para criar tab_freq_PI
    
    dadosFiltrados_AG() %>% 
      filter(!is.na(Sexo)) %>%
      filter(Presenca_AG %in% "SIM") %>%
      ggplot() +
      aes(x = NomeSessao, y = n,  fill = as.factor(Sexo)) +
      geom_col(position = position_dodge()) +
      scale_color_manual(values = c("#9442D4", "#F77333"), name = "SEXO") +
      labs(y = "Produtores presentes nas sessões %", x = "Numero de Sessões") +
      theme_bw(
        base_size = 14,
        base_line_size = 11 / 22,
        base_rect_size = 11 / 22
      ) +
      geom_text(
        #aes(label = sprintf("%d (%.0f%%)", n, Percentagem)),
        aes(label = n),
        position = position_dodge(width = 0.9),
        vjust = 1.5,
        hjust = 0.5
      ) +
      scale_y_continuous(limits = c(0, 300))+
      expand_limits(y = 300)
    
  }) 
  

#########tabela individual ################################ 
  output$com_select_ui <- renderUI({
    distrito_escolhido <- input$ind_input_dist
    comunidades <- unique(Presencas[Presencas$Distrito == distrito_escolhido, "Comunidade"])
    selectInput("ind_input_com", "Escolha a Comunidade:", choices = c("TODOS",comunidades))
  })
  
  #########
  output$com_select_ui_ag <- renderUI({
    distrito_escolhido <- input$ind_input_dist
    comunidades <- unique(Presencas[Presencas$Distrito == distrito_escolhido, "Comunidade"])
    selectInput("ind_input_com_ag", "Escolha a Comunidade:", choices = c("TODOS",comunidades))
  })
  
  ########
  # Renderizar a DataTable baseada na seleção do usuário
  dados_filtrados_INDIV_AG <- reactive({
    distrito_escolhido <- input$ind_input_dist_ag
    comunidade_escolhida <- input$ind_input_com_ag

    # Se 'TODOS' for selecionado no distrito, ignorar a filtragem por distrito
    if (distrito_escolhido == "TODOS") {
      dados <- indiv_AG
    } else {
      dados <- indiv_AG[indiv_AG$Distrito == distrito_escolhido, ]
    }

    # Aplicar filtragem adicional para a comunidade, se necessário
    if (!is.null(comunidade_escolhida) && comunidade_escolhida != "TODOS") {
      dados <- dados[dados$Comunidade == comunidade_escolhida, ]
    }

    dados
  })
  
  # Renderizar a DataTable baseada na seleção do usuário
  dados_filtrados_INDIV <- reactive({
    distrito_escolhido <- input$ind_input_dist
    comunidade_escolhida <- input$ind_input_com
    
    # Se 'TODOS' for selecionado no distrito, ignorar a filtragem por distrito
    if (distrito_escolhido == "TODOS") {
      dados <- indiv_PI
    } else {
      dados <- indiv_PI[indiv_PI$Distrito == distrito_escolhido, ]
    }
    
    # Aplicar filtragem adicional para a comunidade, se necessário
    if (!is.null(comunidade_escolhida) && comunidade_escolhida != "TODOS") {
      dados <- dados[dados$Comunidade == comunidade_escolhida, ]
    }
    
    dados
  })
  
  # Usar dados_filtrados_INDIV no renderDataTable
  output$Tabelaindividual <- renderDataTable({
    datatable(dados_filtrados_INDIV())
  })
   
  # Usar dados_filtrados_INDIV no renderDataTable
  output$Tabelaindividual_AG <- renderDataTable({
    datatable(dados_filtrados_INDIV_AG())
  })

  # Usar dados_filtrados_INDIV no downloadHandler 
  output$downloadDataINDIVIDUL <- downloadHandler(
    filename = function() {
      paste("Presencas_", input$ind_input_dist, "_", input$ind_input_com,"_",Sys.Date(), ".xlsx", sep = "")
    },
    content = function(file) {
      require(openxlsx)
      write.xlsx(dados_filtrados_INDIV(), file)
    }
  ) 
  
  # # Usar dados_filtrados_INDIV no downloadHandler
  # output$downloadDataINDIVIDUL_AG <- downloadHandler(
  #   filename = function() {
  #     paste("Presencas_", input$ind_input_dist, "_", input$ind_input_com,"_",Sys.Date(), ".xlsx", sep = "")
  #   },
  #   content = function(file) {
  #     require(openxlsx)
  #     write.xlsx(dados_filtrados_INDIV_AG(), file)
  #   }
  # )
  # output$Tabelasessao <- renderDataTable({
  #   datatable(dadosFiltrados_TABELA())
  # })
########################### TABELA PI ##########################################
  dadosFiltrados_TABELA <- reactive({
    # Escolher o dataframe com base na seleção do tipo de formação
    dados_selecionados <- if (input$tabela_sessao == "AG") {
      Tabela_AG
    } else {
      Tabela_PI
    }
    
    # Aplicar filtro adicional com base na seleção da comunidade
    if (input$comunidadeInput_tabela != "TODAS") {
      dados_selecionados <- filter(dados_selecionados, Comunidade == input$comunidadeInput_tabela)
    }
     
    dados_selecionados
  })
   
  # Renderizar a DataTable baseada na seleção do usuário e filtragem
  output$downloadDatatABELA <- downloadHandler(
    filename = function() { 
      paste("tabela_", input$tabela_sessao, "_", Sys.Date(), ".xlsx", sep = "")
    },
    content = function(file) {
      require(openxlsx)
      write.xlsx(dadosFiltrados_TABELA(), file)
    }
  ) 
  output$Tabelasessao <- renderDataTable({
    (datatable(dadosFiltrados_TABELA()))
  })
    
} 
# Executar o aplicativo
shinyApp(ui, server)
