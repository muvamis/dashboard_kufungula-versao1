# # Dentro da função server
# server_aba2 <- function(input, output, session) {
#   # ... outras lógicas do servidor para a aba2 ...
#   
#   # Função reativa para filtrar os dados
#   ####  
#   dadosFiltrados_PI <- reactive({
#     if (input$distritoInput_namp== "Todos") {
#       return(tab_freq_PI_all)
#     } else {
#       return(filter(tab_freq_PI, Distrito == input$distritoInput_namp))
#     }
#   })
#   # RenderPlot para o gráfico ###formacao PI
#   output$graficoParticipacaoGlobal <- renderPlot({
#     # Seu código para criar tab_freq_PI
#     
#     dadosFiltrados_PI() %>%
#       filter(!is.na(Sexo)) %>%
#       filter(presenca %in% "SIM") %>%
#       ggplot() +
#       aes(x = FormacaoPI, y = Percentagem,  fill = as.factor(Sexo)) +
#       geom_col(position = position_dodge()) +
#       scale_color_manual(values = c("#9442D4", "#F77333"), name = "SEXO") +
#       labs(y = "Produtores presentes nas sessões %", x = "Numero de Sessões") +
#       theme_bw(
#         base_size = 14,
#         base_line_size = 11 / 22,
#         base_rect_size = 11 / 22
#       ) +
#       geom_text(
#         aes(label = sprintf("%d (%.0f%%)", n, Percentagem)),
#         position = position_dodge(width = 0.9),
#         vjust = 1.5,
#         hjust = 0.5
#       ) +
#       scale_y_continuous(limits = c(0, 100))+
#       expand_limits(y = 100)
#     
#   })
#   
#   
# }
