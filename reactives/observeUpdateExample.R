## Observe update UI example
## https://www.appsilon.com/post/observe-function-r-shiny
library(shiny)
library(dplyr)
library(palmerpenguins)

dummy_data <- penguins

ui <- fluidPage(
  selectInput(inputId = "col_x", label = "X:", choices = dummy_data$x, selected = dummy_data$x[1]),
  selectInput(inputId = "col_y", label = "Y:", choices = dummy_data$y, selected = dummy_data$y[1])
)

server <- function(input, output, session) {
  observe({
    y_vals <- dummy_data %>% filter(x == input$col_x) %>% select(y)
    
    updateSelectInput(
      session = session, 
      inputId = "col_y",
      choices = y_vals,
      selected = head(y_vals, 1)
    )
  })
}

shinyApp(ui = ui, server = server)