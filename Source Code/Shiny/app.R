# Load packages
library(shiny)
library(ggplot2)
library(tidyverse)
library(DT)
library(shinydashboard)
library (dplyr) #Use of dplyr package in ProductList function

#-----Functions "Simulator" and "ProductList"------

#The "Simulator" function takes four variables. 
#'*weeks*: the number of weeks
#'*price*: product hierarchical pricing
#'*samplesize*: the number in the sampling distribution
#'*probability*: probability density function
Simulator <- function(weeks, price, samplesize, probability) {
  output <- c ()
  for (i in 1:weeks)
  {
    simulation <- purrr::pmap(list(x = price, size = samplesize, replace = TRUE,  prob = probability), sample)
    output <- append(output, sum(simulation$Price))
  }
  return(output)
}


#The "ProductList" function is used to create lists based on "Product X" and "Tier X" data.frame
ProductList <- function(product.table, product_name, tier_name) {
  dplyr::filter (product.table, product_name == ProductName, 
                 tier_name == TierName) %>% as.list() }

#-----Load data-----
load("./dbresults.Rdata")


#-----dashboardSidebar-----
sidebar <- dashboardSidebar(
  sidebarMenu(
    menuItem("Sales Forecasting", tabName = "salesforecast", icon = icon("dashboard")),
    menuItem("Result Filters", tabName = "resultsfilters", icon = icon("th"), startExpanded = FALSE,
             # Date Input
             dateRangeInput(inputId = "daterange", label = "Date Range"
             ),
             # Select y-axis
             selectInput(inputId = "y", label = "Y-axis:",
                         choices = c("Result", "Duration"),
                         selected = "Result"),
             # Select x-axis
             selectInput(inputId = "x", label = "X-axis:",
                         choices = c("Date", "Time", "SimulationNumber"),
                         selected = "Date")
    )
  )
)

#-----dashboardBody-----
body <- dashboardBody(
  # Scatterplot
  fluidRow(
    box(plotOutput(outputId = "scatterplot", brush = "plot_brush"), width = 8),
    br()
    ),
  
  tags$head(
    type = "text/css",
    href = "xxx.css"
  ),
  
  # Data Table
  fluidRow(
    box(dataTableOutput(outputId = "dbresults_table")),
    br()  
    )
)

#-----UI-----
ui <- dashboardPage(
  skin = "green",
  header = dashboardHeader(
    title = "Hierarchical Sales Forecasting",
    titleWidth = 400),
  sidebar = sidebar,
  body = body
)

#-----Server-----
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
