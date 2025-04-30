
library(shiny)
library(tidyverse)
library(ggplot2)

df <- read_csv("./final_data.csv")

regioes <- unique(df$regiao)


#UI
ui <- fluidPage(
  
  titlePanel("Comparação do R0"),
  sidebarLayout(
    
    sidebarPanel(

      selectInput("selec_regiao", "Região:", 
                  choices=regioes),
      hr(),
      helpText("R₀ nul: valor teórico do número básico de reprodução em uma população genérica.
R₀ China CDC: valor estimado a partir dos dados iniciais da epidemia na China.")
      
    ),
    

    mainPanel(
      plotOutput("colPlot")
    )
  )
)

#SERVER
server <- function(input, output) {
  
  output$colPlot <- renderPlot({
    
    df %>%
      filter(regiao == input$selec_regiao) %>%
      ggplot(aes(x=pais, y=r0, fill = tipo)) +
      theme_bw() +
      labs(title = "R0 Estimado com diferentes métodos", 
           caption = "PLOS COMPUTATIONAL BIOLOGY: Estimation of country-level basic reproductive
           ratios for novel Coronavirus (SARS-CoV-2/
           COVID-19) using synthetic contact matrices",
           x = "País", y = "R0",
           fill = "R0") +
      geom_col(width = 0.7, position = position_dodge()) +
      theme(axis.text.x = element_text(angle = 15, hjust = 0.5, size = 9)) +
      scale_fill_manual(values = c("r0_china_cdc" = "#9d3163", "r0_null" = "#4169e1"),
                        labels = c("R0 China CDC", "R0 Null"))  -> g
    
    g
  })
}

shinyApp(ui = ui, server = server)