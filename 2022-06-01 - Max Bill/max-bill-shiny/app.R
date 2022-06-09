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
ui <- fluidPage(

    # Application title
    titlePanel("#RecreationThursday"),

    # Main layout
    plotOutput("plot"),
    actionButton("rearrange", "Rearrange")
)

# Define server logic required to...
server <- function(input, output) {
  
    v <- reactiveValues(k = c(6, 6, 5, 4, 3))
  
    observeEvent(input$rearrange, {
      v$k <- sample_k()
    })

    output$plot <- renderPlot({
        # 
        max_bill_rearrange(k = v$k)
    })
}

# Run the application 
shinyApp(ui = ui, server = server)
