#
# This is a Shiny web application. You can run the application by clicking
# the 'Run App' button above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

library(shiny)
library(sass)
source("max-bill.R")

# Define UI for application that draws a histogram
ui <- navbarPage(
  "",
  
  # integer-only tick marks on sliders
  tags$style(type = "text/css", ".irs-grid-pol.small {height: 0px;}"),
  
  theme = bslib::bs_theme(
    primary = "#3945AA",
    #base_font = sass::font_google("Source Sans Pro"),
    base_font = sass::font_face(family = 'LEMONMILKPro-Light',
                                src = "local('LEMONMILKPro-Light'), url('/LEMONMILKPro-Light.woff2') format('woff2'), url('/LEMONMILKPro-Light.woff') format('woff')"),
    "navbar-bg" = "#fff",
  ),
  
  tabPanel(
    "RANDOM",
    align = "center",
    plotOutput("plotRandom", height = "500px"),
    #plotOutput("plotRandom"),
    br(),
    actionButton(
      "rearrange",
      "REARRANGE",
      style =
        "background-color: #3945AA;
                 border-radius: 0;
                 color: #ffffff;
          border-width: 0
      "
    ),
  ),
  
  tabPanel("SLIDERS",
           sidebarLayout(
             sidebarPanel(
               style = "background: white; border-radius: 0",
               sliderInput(
                 "hept",
                 "HEPTAGON",
                 min = 1,
                 max = 8,
                 value = 6
               ),
               sliderInput(
                 "hex",
                 "HEXAGON",
                 min = 1,
                 max = 7,
                 value = 6
               ),
               sliderInput(
                 "pent",
                 "PENTAGON",
                 min = 1,
                 max = 6,
                 value = 5
               ),
               sliderInput(
                 "sq",
                 "SQUARE",
                 min = 1,
                 max = 5,
                 value = 4
               ),
               sliderInput(
                 "tri",
                 "TRIANGE",
                 min = 1,
                 max = 4,
                 value = 3
               )
             ),
             
             # Show a plot of the generated distribution
             mainPanel(plotOutput("plotManual", height = "500px"),)
           )),
  
  tabPanel("ABOUT",
           column(8, 
                  includeMarkdown("about.md"),                  
                  offset = 2)

           
           
           # Application title
           #titlePanel("Max Bill"),
           
           # Sidebar with a slider input for number of bins),),
  ),
  )
  
  # Define server logic required to draw a histogram
  server <- function(input, output) {
    v <- reactiveValues(k = c(6, 6, 5, 4, 3))
    
    observeEvent(input$rearrange, {
      v$k <- sample_k()
    })
    
    # observeEvent(input$original, {
    #    v$k <- c(6, 6, 5, 4, 3)
    #  })
    
    output$plotRandom <- renderPlot({
      #
      max_bill_rearrange(k = v$k)
    })
    
    output$plotManual <- renderPlot({
      max_bill_rearrange(k = c(input$hept, input$hex, input$pent, input$sq, input$tri))
    })
  }
  
  # Run the application
  shinyApp(ui = ui, server = server)
  