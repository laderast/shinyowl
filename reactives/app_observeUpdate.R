## Observe update UI example
## https://www.appsilon.com/post/observe-function-r-shiny
library(shiny)
library(dplyr)

ui <- fluidPage(
  p("The checkbox group controls the select input"),
  checkboxGroupInput("inCheckboxGroup", "Input checkbox",
                     c("Item A", "Item B", "Item C")),
  selectInput("inSelect", "Select input",
              c("Item A", "Item B", "Item C"))
)

server <- function(input, output, session) {
  observe({
    x <- input$inCheckboxGroup
    
    # Can use character(0) to remove all choices
    if (is.null(x))
      x <- character(0)
    
    # Can also set the label and select items
    updateSelectInput(session, "inSelect",
                      label = paste("Select input label", length(x)),
                      choices = x,
                      selected = tail(x, 1)
    )
  }) |>
    bindEvent(input$inCheckboxGroup)
}

shinyApp(ui, server)
