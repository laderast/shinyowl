library(shiny)
library(ggplot2)
library(bslib)
library(bsicons)
library(palmerpenguins)

thematic::thematic_shiny()

ui <- page(
  theme = bs_theme(brand=FALSE),
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