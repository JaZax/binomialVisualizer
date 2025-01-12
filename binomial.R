library(shiny)
library(ggplot2)

# Define the UI
ui <- fluidPage(
  titlePanel("Binomial Distribution Visualizer"),
  sidebarLayout(
    sidebarPanel(
      sliderInput("size", "Number of Trials (size):", 
                  min = 1, max = 50, value = 12),
      sliderInput("prob", "Probability of Success (prob):", 
                  min = 0.01, max = 1, value = 0.2, step = 0.01)
    ),
    mainPanel(
      plotOutput("distPlot")
    )
  )
)

# Define the server logic
server <- function(input, output) {
  output$distPlot <- renderPlot({
    x <- 0:input$size  # Adjust range based on size
    df <- data.frame(x = x, px = dbinom(x, input$size, input$prob))
    
    ggplot(df, aes(x, px)) +
      geom_col(fill = "blue") +
      xlab("x, number of successes") +
      ylab("p(x)") +
      labs(title = paste("Binomial Distribution",
                         "(size =", input$size, 
                         ", prob =", input$prob, ")")) +
      theme_minimal()
  })
}

# Run the application
shinyApp(ui = ui, server = server)
