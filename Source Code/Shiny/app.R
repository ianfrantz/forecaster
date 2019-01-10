# Load packages
library(shiny)
library(ggplot2)
library(DT)
library(shinydashboard)
library(dplyr) #Use of dplyr package in ProductList function
#-----Load local data-----
load("./dbresults.Rdata")
load("./product.table.RData")

#-----Load custom functions-----
source("./functions.R") #'Functions are in order: *Simulator*, *ProductList*, *return_tooltip*

#'-----*sidebar built from reactive "menu"*-----
sidebar <- dashboardSidebar(sidebarMenu(id = "menu", sidebarMenuOutput("menu")))

#'-----*body Defined*-----
body <- dashboardBody(
  (tabItems
   (tabItem
     (tabName = "subitem1", h2("Dashboard plots"),
        fluidRow( 
        h4("Scatterplot"),
        box(plotOutput(outputId = "scatterplot", brush = "plot_brush", hover = "plot_hover"), width = 8),
        uiOutput("hover_info"),
        br(),
        #Begin placeholder for eventual css
        tags$head(
        type = "text/css",
        href = "xxx.css"),
        #End placeholder for css
        fluidRow(
        box(dataTableOutput(outputId = "dbresults_table"), width = 8)
        )
        )
      ),
  tabItem
     (tabName = "subitem2", h2("Create a Simulation"),
        fluidRow(
        h1("Input Results"), 
        box()
        )
        )
   )
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
server <- function(input, output, session) {
  
  # Numeric Input
  
  
  # ui TextOuput - For Menu items and subitems
  output$res <- renderText({
    req(input$sidebarItemExpanded)
    paste("Expanded menuItem:", input$sidebarItemExpanded)
  })
  
  # Reactive sidebarMenu named "menu"
  output$menu <- renderMenu({
    sidebarMenu(
      menuItem("Forecasting Results", tabName = "subitem1", icon = icon("bar-chart")),
      menuItem("Simulation", icon = icon("signal"),
              menuSubItem(
              "Dashboard", tabName = "subitem2", icon = icon("bar-chart")
              ),
              # Simulation Parameter Names
              textInput(inputId = "simname", label = "Simulation Name"),
              selectInput(inputId = "productname", label = "Product Name", choices = product.table$ProductName),
              selectInput(inputId = "tiername", label = "Tier Name", choices = product.table$TierName),
              # Submit Results
              submitButton(text = "Run Simulation")
              ),
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
                           selected = "Date"),
               textInput(inputId = "plottext", label = "plottext")
              )
      )
  })
  
#-----Start output values-----
  #Output for Simulator Input
  # output$simulationresults <- ({
  #   input$simname <- ProductList(product.table, input$productname, input$tiername)
  # })

  #Create scatterplot object the plotOutput function is expecting
  output$scatterplot <- renderPlot({
    ggplot(data = dbresults, aes_string(x = input$x, y = input$y)) +
    geom_point()
  })
  
  #Print dbresults table based on brush selection
  output$dbresults_table <- DT::renderDataTable({
    brushedPoints(dbresults, brush = input$plot_brush, xvar = input$x, yvar = input$y) %>% 
    select(Date, SimulationNumber, Result)
  })
 
  #Enable hover
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

#Create a Shiny app object
shinyApp(ui = ui, server = server)
