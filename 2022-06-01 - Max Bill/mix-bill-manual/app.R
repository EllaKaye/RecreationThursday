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
ui <- fluidPage(

    # Application title
    #titlePanel("Old Faithful Geyser Data"),

    # Sidebar with a slider input for number of bins 
    sidebarLayout(
        sidebarPanel(
            sliderInput("hept",
                        "heptagon",
                        min = 1,
                        max = 8,
                        value = 6),
            sliderInput("hex",
                        "hexagon",
                        min = 1,
                        max = 7,
                        value = 6),
            sliderInput("pent",
                        "pentagon",
                        min = 1,
                        max = 6,
                        value = 5),
            sliderInput("sq",
                        "square",
                        min = 1,
                        max = 5,
                        value = 4),
            sliderInput("tri",
                        "triange",
                        min = 1,
                        max = 4,
                        value = 3)
        ),

        # Show a plot of the generated distribution
        mainPanel(
           plotOutput("plot")
        )
    )
)

# Define server logic required to draw a histogram
server <- function(input, output) {

  output$plot <- renderPlot({
    max_bill_rearrange(k = c(input$hept, input$hex, input$pent, input$sq, input$tri))
    })
}

# Run the application 
shinyApp(ui = ui, server = server)