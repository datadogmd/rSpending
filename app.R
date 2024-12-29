#
# This is a Shiny web application. You can run the application by clicking
# the 'Run App' button above.
#
# Find out more about building applications with Shiny here:
#
#    https://shiny.posit.co/
#

library(bslib)
library(ggplot2)
library(lubridate)
library(shiny)


# Define UI for application that draws a histogram
ui <- page_fluid(
  page_sidebar(
  title = "Example dashboard",
  sidebar = sidebar(
    
    # choose file input
    
    fileInput("file1", "Choose a File"),
    verbatimTextOutput("file1_contents"),
    
    # select variable input
    
    varSelectInput("var", "Select variable", mtcars),
    
    # date range input
    
    dateRangeInput(inputId = "date", label = "Date Range"),
    hr(),
    verbatimTextOutput("date"),
    verbatimTextOutput("date1"),
    verbatimTextOutput("date2"),
    
    verbatimTextOutput("date1_class"),
    verbatimTextOutput("date1_year")
  ),
  card(
    full_screen = TRUE,
    card_header("My plot"),
    plotOutput("p")
  )
),
absolutePanel( 
  wellPanel(
    titlePanel("Draggable panel"),
    "Move this panel anywhere you want.",
  ),
  varSelectInput("panelVar", "Select variable", mtcars),
  width = "300px", 
  right = "50px", 
  top = "50px", 
  draggable = TRUE, 
), 
navset_tab( 
  nav_panel("A", "Page A content"), 
  nav_panel("B", "Page B content"), 
  nav_panel("C", "Page C content"), 
  nav_menu( 
    "Other links", 
    nav_panel("D", "Panel D content"), 
    "----", 
    "Description:", 
    nav_item( 
      a("Shiny", href = "https://shiny.posit.co", target = "_blank") 
    ), 
  ), 
), 
id = "tab" 
)


# Define server logic required to draw a histogram
server <- function(input, output) {
  
  # choose file output
  
  output$file1_contents <- renderPrint({print(input$file1)})
  
  # date range output
  
  # You can access the value of the widget with input$date
  output$date <- renderPrint({ input$date })
  output$date1 <- renderPrint({ input$date[[1]] })
  output$date2 <- renderPrint({ input$date[[2]] })
  
  output$date1_class <- renderPrint({ class(input$date[[1]]) })
  output$date1_year <- renderPrint({ year(input$date[[1]]) })

    output$distPlot <- renderPlot({
        # generate bins based on input$bins from ui.R
        x    <- faithful[, 2]
        bins <- seq(min(x), max(x), length.out = input$bins + 1)

        # draw the histogram with the specified number of bins
        hist(x, breaks = bins, col = 'darkgray', border = 'white',
             xlab = 'Waiting time to next eruption (in mins)',
             main = 'Histogram of waiting times')
    })
}

# Run the application 
shinyApp(ui = ui, server = server)
