#
# This is a Shiny web application. You can run the application by clicking
# the 'Run App' button above.
#
# Find out more about building applications with Shiny here:
#
#    https://shiny.posit.co/
#

library(shiny)
library(tidyverse)
library(ggplot2)


df <- read_csv("./final_data.csv")

regioes <- unique(df$regiao)


# Define UI for application that draws a histogram
ui <- fluidPage(

    # Application title
    titlePanel("R0 Comparison"),

    # Sidebar with a slider input for number of bins 
    sidebarLayout(
      
#      sidebarPanel(
#        selectInput("region", "Region:", 
#                    choices=colnames(WorldPhones)),
#        hr(),
#        helpText("Data from AT&T (1961) The World's Telephones.")
#      ),
      
        sidebarPanel(
         #   sliderInput("bins",
         #               "Number of bins:",
         #               min = 1,
        #                max = 50,
        #                value = 30),
            selectInput("selected_region", "Region:", 
                        choices=regioes),
            hr(),
            helpText("R0 estimated with different methods.")
            
        ),

        # Show a plot of the generated distribution
        mainPanel(
           plotOutput("colPlot")
        )
    )
)

# Define server logic required to draw a histogram
server <- function(input, output) {
    
    output$colPlot <- renderPlot({
        # generate bins based on input$bins from ui.R
      #  x    <- faithful[, 2]
      #  bins <- seq(min(x), max(x), length.out = input$bins + 1)

        # draw the histogram with the specified number of bins
       # hist(x, breaks = bins, col = 'darkgray', border = 'white',
      #       xlab = 'Waiting time to next eruption (in mins)',
      #       main = 'Histogram of waiting times')
      
      df %>%
        filter(regiao == input$selected_region) %>%
        ggplot(aes(x=pais, y=r0, fill = tipo)) + 
        geom_col(position = position_dodge()) + 
        theme_bw() -> g
      
      g
    })
}

# Run the application 
shinyApp(ui = ui, server = server)
