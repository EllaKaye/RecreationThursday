#
# This is a Shiny web application. You can run the application by clicking
# the 'Run App' button above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

library(shiny)
library(ggplot2)

source("max-bill.R")

# Define UI for application that draws a histogram
ui <- fluidPage(align = "center",

    # Application title
    # titlePanel("#RecreationThursday"),

    # Main layout
    br(),
    plotOutput("plot"),
    br(),
    actionButton("rearrange", "Rearrange", 
                 style = 
                   "background-color: #F4F2E9; 
                    border-width: 0;
                    font-family: Times"),
    #br(),
    #actionButton("original", "Original")
  )

# Define server logic required to...
server <- function(input, output) {
  
    v <- reactiveValues(k = c(6, 6, 5, 4, 3))
  
    observeEvent(input$rearrange, {
      v$k <- sample_k()
    })
    
   # observeEvent(input$original, {
  #    v$k <- c(6, 6, 5, 4, 3)
  #  })

    output$plot <- renderPlot({
        # 
        max_bill_rearrange(k = v$k)
    })
}

# Run the application 
shinyApp(ui = ui, server = server)
