library(bsicons)
library(bslib)
library(shiny)
ui <- page_fixed(
  value_box(
    title = "The current time",
    value = textOutput("time"),
    showcase = bs_icon("clock")
  )
)

server <- function(input, output) {
  output$time <- renderText({
    invalidateLater(1000)
    format(Sys.time())
  })
}

shinyApp(ui, server)
