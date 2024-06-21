#taken from the ExtendedTask Documnetation
library(shiny)
library(bslib)
library(future)
library(promises)
library(palmerpenguins)
library(reactlog)
library(ggplot2)
library(shiny)
library(bslib)
library(dplyr)

future::plan(multisession)

library(reactlog)
reactlog_enable()

ui <- page_fluid(
  numericInput("x", "x", value = 1),
  numericInput("y", "y", value = 2),
  input_task_button("btn", "Add numbers"),
   textOutput("sum")
)

server <- function(input, output, session) {
  output$current_time <- renderText({
    invalidateLater(1000)
    format(Sys.time(), "%H:%M:%S %p")
  })
  
  sum_values <- ExtendedTask$new(function(x, y) {
    future_promise({
      Sys.sleep(3)
      x + y
    })
  }) |> bind_task_button("btn")
  
  observeEvent(input$btn, {
    sum_values$invoke(input$x, input$y)
  })
  
  output$sum <- renderText({
    sum_values$result()
  })
}

shinyApp(ui, server)