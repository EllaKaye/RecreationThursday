library(shiny)
library(bslib)
library(markdown)
source("max-bill.R")

#dir.create('~/.fonts')
#file.copy("www/LEMONMILKPro-Light.woff", "~/.fonts")
#system('fc-cache -f ~/.fonts')

ui <- navbarPage(
  "",
  
  # integer-only tick marks on sliders
  tags$style(type = "text/css", ".irs-grid-pol.small {height: 0px;}"),
  
  # theme = bs_theme(
  #   primary = "#3945AA",
  #   base_font = font_collection(font_face(family = 'LEMONMILKPro-Light',
  #                               src = "local('LEMONMILKPro-Light'), url('/www/LEMONMILKPro-Light.woff2') format('woff2'), url('/www/LEMONMILKPro-Light.woff') format('woff')"), "Helvetica Neue", "Helvetica", "Arial", "Sans Serif"),
  #   heading_font = font_collection(font_face(family = 'LEMONMILKPro-Regular',
  #                               src = "local('LEMONMILKPro-Regular'), url('/www/LEMONMILKPro-Regular.woff2') format('woff2'), url('/www/LEMONMILKPro-Regular.woff') format('woff')"), "Helvetica Neue", "Helvetica", "Arial", "Sans Serif"),
  #   "navbar-bg" = "#fff",
  # ),
  
  theme = bs_theme(
    primary = "#3945AA",
    #base_font = font_face(family = 'LEMONMILKPro-Light',
    #                                      src = "url('~/.fonts/LEMONMILKPro-Light.woff') format('woff'))"),
    base_font = font_google("Jost"),
    "navbar-bg" = "#3945AA",
    #"navbar-dark-color" = "#F45D1B"
    #"navbar-brand-font-size" = "4rem"
  ),
  
  tabPanel(
    "RANDOM",
    align = "center",
    br(),
    plotOutput("plotRandom", height = "500px"),
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
           br(),
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
                 "TRIANGLE",
                 min = 1,
                 max = 4,
                 value = 3
               )
             ),
             
             # Show a plot of the generated distribution
             mainPanel(plotOutput("plotManual", height = "500px"),)
           )),
  
  tabPanel("ABOUT",
           br(),
           column(8, 
                  includeMarkdown("about.md"),                  
                  offset = 2)
  ),
  )
  
# Define server logic 
server <- function(input, output) {
    v <- reactiveValues(k = c(6, 6, 5, 4, 3))
    
    observeEvent(input$rearrange, {
      v$k <- sample_k()
    })
    
    # observeEvent(input$original, {
    #    v$k <- c(6, 6, 5, 4, 3)
    #  })
    
    output$plotRandom <- renderPlot({
      max_bill_rearrange(k = v$k)
    })
    
    output$plotManual <- renderPlot({
      max_bill_rearrange(k = c(input$hept, input$hex, input$pent, input$sq, input$tri))
    })
  }
  
# Run the application
shinyApp(ui = ui, server = server)
  