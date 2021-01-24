#
#

# Define UI for application that draws a histogram

library(shiny)
library(leaflet)
library(dplyr)

ui <- fluidPage(

    
    
    # Application title
  
       titlePanel("Energy in Europen Countries"),

    # Sidebar with a slider input for the year
   sidebarLayout(
        sidebarPanel(
                   h2("Year"), 
                  sliderInput("slider1", "select the year",2009,2018,2009), 
                  fileInput("file1", "Choose CSV File",
                            multiple = FALSE,
                            accept = c("text/csv",
                                       "text/comma-separated-values,text/plain",
                                       ".csv")),
                  
                  # Horizontal line ----
                  tags$hr(),
                  
                  # Input: Checkbox if file has header ----
                  checkboxInput("header", "Header", TRUE),
                  
                  # Input: Select separator ----
                  radioButtons("sep", "Separator",
                               choices = c(Comma = ",",
                                           Semicolon = ";",
                                           Tab = "\t"),
                               selected = ","),
                  
                  # Input: Select quotes ----
                  radioButtons("quote", "Quote",
                               choices = c(None = "",
                                           "Double Quote" = '"',
                                           "Single Quote" = "'"),
                               selected = '"'),
                  
                  # Horizontal line ----
                  tags$hr(),
                  
                  # Input: Select number of rows to display ----
                  radioButtons("disp", "Display",
                               choices = c(Head = "head",
                                           All = "all"),
                               selected = "head")
                  ),
        
        
         
            mainPanel(
                h2( "Energy comsumption (Gigawatts)"),
                leafletOutput("mymap"),
                dataTableOutput("mytable"),
                tableOutput("contents")
                                )
        
             
             
             
            
        
   ) )
