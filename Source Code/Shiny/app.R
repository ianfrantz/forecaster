# Load packages
library(shiny)
library(ggplot2)
library(tidyverse)
library(DT)

# Load data
load("./dbresults.Rdata")

# Define UI for application that plots features of movies
ui <- fluidPage(
  
  br(),
  
  # Sidebar layout with a input and output definitions
  sidebarLayout(
    # Inputs
    sidebarPanel(
      # Select variable for y-axis
      selectInput(inputId = "y", label = "Y-axis:",
                  choices = c("Result", "Duration"),
                  selected = "Result"),
      # Select variable for x-axis
      selectInput(inputId = "x", label = "X-axis:",
                  choices = c("Date", "Time", "SimulationNumber"),
                  selected = "Date")
    ),
    
    # Output:
    mainPanel(
      # Show scatterplot
      plotOutput(outputId = "scatterplot", brush = "plot_brush"),
      # Show data table
      dataTableOutput(outputId = "dbresults_table"),
      br()
    )
  )
)

# Define server function required to create the scatterplot
server <- function(input, output) {
  
  # Create scatterplot object the plotOutput function is expecting
  output$scatterplot <- renderPlot({
    ggplot(data = dbresults, aes_string(x = input$x, y = input$y)) +
    geom_point()
  })
  
  # Print dbresults table based on brush selection
  output$dbresults_table <- DT::renderDataTable({
    brushedPoints(dbresults, brush = input$plot_brush, xvar = input$x, yvar = input$y) %>% 
      select(Date, SimulationNumber, Result)
  })
  
}

# Create a Shiny app object
shinyApp(ui = ui, server = server)
