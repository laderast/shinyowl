library(shiny)
library(ggplot2)
library(bslib)
library(bsicons)
library(palmerpenguins)

ui <- page(
  card({
    plotOutput("penguins")
  })
)

server <- function(input, output) {
  output$penguins <- renderPlot({
    ggplot(penguins, aes(x = bill_depth_mm, 
                         y = bill_length_mm, 
                         color = island)) +
      geom_point()
  })
}

shinyApp(ui, server)