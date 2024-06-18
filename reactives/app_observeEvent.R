ibrary(palmerpenguins)
choices <- unique(penguins$species)
library(reactlog)

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