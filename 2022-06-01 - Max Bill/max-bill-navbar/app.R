#
# This is a Shiny web application. You can run the application by clicking
# the 'Run App' button above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

library(shiny)

# Define UI for application that draws a histogram
ui <- navbarPage(
  "#RecreationThursday max bill",
  
  # integer-only tick marks on sliders
  tags$style(type = "text/css", ".irs-grid-pol.small {height: 0px;}"),
  
  theme = bslib::bs_theme(
    #    bootswatch = "litera",
    #    #fg = "black",
    #    #bg = "white",
    primary = "#3945AA",
    base_font = bslib::font_google("Source Sans Pro"),
    #    "navbar-bg" = "#F4F2E9",
    #    "code-bg" = "red"
    
  ),
  
  tabPanel(
    "random",
    align = "center",
    br(),
    plotOutput("plotRandom", height = "500px"),
    #plotOutput("plotRandom"),
    br(),
    actionButton("rearrange",
                 "rearrange",
                 style =
                   "background-color: #F4F2E9;
          border-width: 0
      "),
  ),
  
  tabPanel("manual",
           sidebarLayout(
             sidebarPanel(
               sliderInput(
                 "hept",
                 "heptagon",
                 min = 1,
                 max = 8,
                 value = 6
               ),
               sliderInput(
                 "hex",
                 "hexagon",
                 min = 1,
                 max = 7,
                 value = 6
               ),
               sliderInput(
                 "pent",
                 "pentagon",
                 min = 1,
                 max = 6,
                 value = 5
               ),
               sliderInput(
                 "sq",
                 "square",
                 min = 1,
                 max = 5,
                 value = 4
               ),
               sliderInput(
                 "tri",
                 "triangle",
                 min = 1,
                 max = 4,
                 value = 3
               )
             ),
             
             # Show a plot of the generated distribution
             mainPanel(
               plotOutput("plotManual", height = "500px"), 
               )
           )),
  
  tabPanel("about",
           includeMarkdown("about.md")
           
           
           # Application title
           #titlePanel("Max Bill"),
           
           # Sidebar with a slider input for number of bins),
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
  