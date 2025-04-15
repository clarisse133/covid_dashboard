library(shiny)

ui <- fluidPage(
  mainPanel(
    sliderInput("obs",
                "Number of observations",
                min = 1,
                max = 5000,
                value = 100),
    plotOutput("distPlot")
  )
)

server <- function(input, output) {
  output$distPlot <- renderPlot({
    dist <- rnorm(input$obs)
    hist(dist,
         col="purple",
         xlab="Random values")
  })
}

shinyApp(ui = ui, server = server)