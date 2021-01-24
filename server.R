#
# This is the server logic of a Shiny web application. You can run the
# application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

# loading the data

    wd.datapath = getwd()
    wd.init = getwd()
    setwd(wd.datapath)
    energy <- read.csv("energy.csv", header = TRUE)
    naam  <-  gsub("X", "", names(energy))
    names(energy) <- naam
    setwd(wd.init)

# Define server logic required to draw the graph

  server <- function(input, output) {
          
  
          year <- reactive({
          as.character(input$slider1)
          })
          
          energy_sub<- reactive({
          energy[,c("Country",year(),"lat", "lng")]
          })
          
            
            output$mymap <- renderLeaflet({
            energy_sub()%>%
            leaflet() %>% 
            addTiles %>%
            addCircles(weight = 1, radius = energy_sub()[,2]/2)
            })
            
            output$mytable <- renderDataTable({energy_sub()[,1:2]})
            output$contents <- renderTable({
              req(input$file1)
              
              tryCatch(
                {
                  df <- read.csv(input$file1$datapath,
                                 header = input$header,
                                 sep = input$sep,
                                 quote = input$quote)
                },
                error = function(e) {
                  stop(safeError(e))
                }
              )
              
              if(input$disp == "head") {
                return(head(df))
              }
              else {
                return(df)
              }
              
            })
            
}


            
            


