# Load packages
library(shiny)
library(ggplot2)
library(tidyverse)
library(DT)
library(shinydashboard)
library(dplyr) #Use of dplyr package in ProductList function
#-----Load local data-----
load("./dbresults.Rdata")
#-----Load custom functions-----
source("./functions.R") #'Functions are in order: *Simulator*, *ProductList*, *return_tooltip*

#'-----*sidebar defined*-----
sidebar <- dashboardSidebar(
  sidebarMenu(
    menuItem("Sales Forecasting", tabName = "salesforecast", icon = icon("dashboard"), startExpanded = TRUE),
    menuSubItem("Retail Store", tabName = "subitem1"),
    menuSubItem("Plant Yields", tabName = "subitem2"),
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

#'-----*body Defined*-----
body <- dashboardBody(
  # Tabs
  tabItem("subitem1", "Sub-item 1 tab content"),
  tabItem("subitem2", "Sub-item 2 tab content"),
  # Scatterplot
  fluidRow(
    box(plotOutput(outputId = "scatterplot", brush = "plot_brush", hover = "plot_hover"), width = 8),
    uiOutput("hover_info"),
    br()
    ),
  
  # Place for css files in the body
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

#'-----*UI Defined*-----
ui <- dashboardPage(
  skin = "green",
  header = dashboardHeader(
    title = "Hierarchical Sales Forecasting",
    titleWidth = 400),
  sidebar = sidebar,
  textOutput("res"),
  body = body
)

#'-----*Server Defined*-----
server <- function(input, output) {
  # For Menu items and subitems
  output$res <- renderText({
    req(input$sidebarItemExpanded)
    paste("Expanded menuItem:", input$sidebarItemExpanded)
  })
  
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
 
  # Enable hover
  output$hover_info <- renderUI({
    hover <- input$plot_hover
    point <- nearPoints(df=dbresults, coordinfo=hover, 
                        maxpoints = 1, threshold = 3)
    #if nearPoints returns a data row, then show tooltip
    if(nrow(point)!=0){
      #return_tooltip resides in functions.R 
      #returns the text of tooltip (output_list$output_string),
      #where on plot to display it (output_list$style).
      output_list <- return_tooltip(hover, point)
      wellPanel(
        style = output_list$style,
        p(HTML(output_list$output_string))
      )
      }
  }) 

  
}

# Create a Shiny app object
shinyApp(ui = ui, server = server)
