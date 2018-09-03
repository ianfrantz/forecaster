# Load packages
library(shiny)
library(ggplot2)
library(tidyverse)
library(DT)

# Load data
load("./dbresults.Rdata")
movies <- dbresults

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
      dataTableOutput(outputId = "movies"),
      br()
    )
  )
)

# Define server function required to create the scatterplot
server <- function(input, output) {
  
  # Create scatterplot object the plotOutput function is expecting
  output$scatterplot <- renderPlot({
    ggplot(data = movies, aes_string(x = input$x, y = input$y)) +
      geom_point()
  })
  
  # Print data table
  output$moviestable <- DT::renderDataTable({
    nearPoints(movies, coordinfo = input$plot_brush) %>% 
      select(dbresults, Date, Result)
  })
  
}

# Create a Shiny app object
shinyApp(ui = ui, server = server)

