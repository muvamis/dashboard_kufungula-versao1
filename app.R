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
#   dadosFiltrados_PI <- reactive ({
#     if (input$ProvinciaInput== "Todos") {
#       Inscritos<- calcular_frequencias(Kufungula, Distrito, Sexo)
#     } else if (input$ProvinciaInput== "Nampula"){
#       Inscritos<- calcular_frequencias(Nampula, Distrito, Sexo)
#     } else if (input$ProvinciaInput== "Cabo Delgado"){ 
#       Inscritos <- calcular_frequencias(Cabo_Delgado, Distrito, Sexo)
#   }
#     return(Inscritos)
# })
  ##################################################
    dadosFiltrados <- reactive({
      if (input$ProvinciaInput == "Todos") {
        return(Kufungula)
      } else {
        return(subset(Kufungula, Provincia == input$ProvinciaInput))
      } 
    })
  
 ## RenderPlot para o gráfico ###formacao PI
  output$registradosPorProvincia <- renderPlot({
    ggplot(dadosFiltrados(), aes(x = Distrito, fill = Sexo)) +
      geom_bar(position = "dodge") +
      scale_fill_manual(values = c(Feminino = "#9942D4", Masculino = "#F77333")) +
      labs(title = "Total de Registrados por Distrito e Sexo",
           x = "Distrito",
           y = "Total de Registrados") +
      theme_stata() +
      geom_text(aes(label = ..count..), stat = "count", position = position_dodge(width = 0.9), vjust = -0.25)
  })
  
  output$deslocadosPorProvincia <- renderPlot({
        ggplot(subset(dadosFiltrados(), Deslocado == "Sim"), aes(x = Distrito, fill = Sexo)) +
          geom_bar(position = "dodge") +
          scale_fill_manual(values = c(Feminino = "#9942D4", Masculino = "#F77333")) +
          labs(title = "Número de Deslocados por Província e Sexo",
               x = "Província",
               y = "Número de Deslocados") +
          theme_stata() +
          geom_text(aes(label = ..count..), stat = "count", position = position_dodge(width = 0.9), vjust = -0.25)
      })



############## Nampula ########
###########   PI  ################
  dadosFiltrados_PI <- reactive({
    if (input$distritoInput_namp_pi== "TODOS") {
      
      return(calcular_frequencias(presencas_PI, FormacaoPI, Sexo,presenca))
    } else {
      return(calcular_frequencias(filter(presencas_PI, Distrito == input$distritoInput_namp_pi),Distrito, FormacaoPI, Sexo,presenca)
        )
    }
  })
  # RenderPlot para o gráfico ###formacao PI
  output$graficoParticipacaoGlobal <- renderPlot({
    # Seu código para criar tab_freq_PI

    dadosFiltrados_PI() %>%
      filter(!is.na(Sexo)) %>%
      filter(presenca %in% "SIM") %>%
      ggplot() +
      aes(x = FormacaoPI, y = Percentagem,  fill = as.factor(Sexo)) +
      geom_col(position = position_dodge()) +
      scale_color_manual(values = c("#9442D4", "#F77333"), name = "SEXO") +
      labs(y = "Produtores presentes nas sessões %", x = "Numero de Sessões") +
      theme_bw(
        base_size = 14,
        base_line_size = 11 / 22,
        base_rect_size = 11 / 22
      ) +
      geom_text(
        aes(label = sprintf("%d (%.0f%%)", n, Percentagem)),
        position = position_dodge(width = 0.9),
        vjust = 1.5,
        hjust = 0.5
      ) +
      scale_y_continuous(limits = c(0, 100))+
      expand_limits(y = 100)

  })
  
  ######################## input filtro#################################
  dadosFiltrados_AG <- reactive({
    if (input$distritoInput_namp_AG== "TODOS") {
      
      return(calcular_frequencias(presencas_AG, NomeSessao, Sexo,presenca))
    } else {
      return(calcular_frequencias(filter(presencas_AG, Distrito == input$distritoInput_namp_AG),Distrito, NomeSessao, Sexo,presenca)
      )
    }
  })
  # RenderPlot para o gráfico ###formacao PI
  output$graficoParticipacaoGlobal_AG <- renderPlot({
    # Seu código para criar tab_freq_PI
    
    dadosFiltrados_AG() %>%
      filter(!is.na(Sexo)) %>%
      filter(presenca %in% "SIM") %>%
      ggplot() +
      aes(x = NomeSessao, y = Percentagem,  fill = as.factor(Sexo)) +
      geom_col(position = position_dodge()) +
      scale_color_manual(values = c("#9442D4", "#F77333"), name = "SEXO") +
      labs(y = "Produtores presentes nas sessões %", x = "Numero de Sessões") +
      theme_bw(
        base_size = 14,
        base_line_size = 11 / 22,
        base_rect_size = 11 / 22
      ) +
      geom_text(
        aes(label = sprintf("%d (%.0f%%)", n, Percentagem)),
        position = position_dodge(width = 0.9),
        vjust = 1.5,
        hjust = 0.5
      ) +
      scale_y_continuous(limits = c(0, 100))+
      expand_limits(y = 100)
    
  }) 
  
  #########tabela individual ################################ 

  
  # Atualizar a seleção de comunidades baseada na escolha do distrito
  output$com_select_ui <- renderUI({
    distrito_escolhido <- input$ind_input_dist
    comunidades <- unique(Presencas[Presencas$Distrito == distrito_escolhido, "Comunidade"])
    selectInput("ind_input_com", "Escolha a Comunidade:", choices = comunidades)
  })
  
  # Renderizar a DataTable baseada na seleção do usuário
  output$Tabelaindividual <- renderDataTable({
    distrito_escolhido <- input$ind_input_dist
    comunidade_escolhida <- input$ind_input_com
    
    # Filtrar o DataFrame com base no distrito e na comunidade
    dados_filtrados <- indiv_PI[indiv_PI$Distrito == distrito_escolhido & indiv_PI$Comunidade == comunidade_escolhida, ]
    
    # Se não houver escolha de comunidade ou se a comunidade for "TODOS", mostrar todos os dados do distrito
    if(is.null(comunidade_escolhida) || comunidade_escolhida == "TODOS") {
      dados_filtrados <- indiv_PI[indiv_PI$Distrito == distrito_escolhido, ]
    } 
       
    # Renderizar a tabela
    datatable(dados_filtrados)
  })
  
########################### TABELA PI ##########################################
  
  output$Tabelasessao <- renderDataTable({
   if (input$tabela_sessao=="AG") {
     datatable(Tabela_AG)
   } else  {
     datatable(Tabela_PI) 
       }
    
  })   
}
# Executar o aplicativo
shinyApp(ui, server)
