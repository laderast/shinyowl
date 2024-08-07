library(reactlog)
library(shiny)

reactlog_enable()

ui <- fluidPage(
  actionButton("activate", "Click to Activate")
)

server <- function(input, output){
  
  observeEvent(input$activate, {
    print("Activated in the Console")
  })
}

shinyApp(ui, server)