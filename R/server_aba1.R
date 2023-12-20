server_aba1 <- function(input, output, session) {
  #######################APA GERAL ##########################################  
  ###GERAL
  
  # Filtrar dados baseado no distrito selecionado
  dadosFiltrados <- reactive({
    if (input$distritoInput == "Todos") {
      return(Kufungula)
    } else {
      return(subset(Kufungula, Província == input$distritoInput))
    }
  })
  
  # Gráfico de Registrados por Província
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
  
  ###DESLOCADOS 
  
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
  
  output$download_inscritos <- downloadHandler(
    filename = function() {
      "Produtores_inscritos.xlsx"
    },
    content = function(file) {
      write.xlsx(Kufungula, file)
    }
  )
  
  ##########################################FIM DE APA GERAL#####################
}
