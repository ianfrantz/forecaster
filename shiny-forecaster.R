# Needed libraries for forecaster
library(shiny)
library(ggplot2)

#Load data from sqlite-connection.R script
load("./Data/product.table.RData")

# Define UI for forecaster
ui <- fluidPage(
  titlePanel("Forecasting Hierarchical Sales"),
  # Sidebar layout with a input and output definitions
  sidebarLayout(
    
#INPUT
    sidebarPanel(
      
      # Select variable for y-axis
      selectInput(inputId = "y", 
                  label = "Y-axis:",
                  choices = c(""), 
                  selected = ""),
      
      # Select variable for x-axis
      selectInput(inputId = "x", 
                  label = "X-axis:",
                  choices = c(""), 
                  selected = ""),
      
      # Download button
      downloadButton("downloadoutput1", 'Download Data')
    ),
    
#OUTPUT
    mainPanel(
      plotOutput(outputId = "Histogram", height = 500)
    )
  )
)

#SERVER
# Define server function required to create the scatterplot
server <- function(input, output) {
  
  # Create scatterplot object the plotOutput function is expecting
  output$Historgram <- renderPlot({
    ggplot(data = product.table, aes_string(x = input$x, y = input$y)) +
      geom_point(alpha = input$alpha)
  })
  
  output$downloadoutput1 <- downloadHandler(
    filename = function() {
      paste("File Name", Sys.Date(),".csv", sep='') },
      content = function(file) {write.csv(Output1, file, row.names = TRUE)
  })
  
}

# Create the Shiny app object
shinyApp(ui = ui, server = server)