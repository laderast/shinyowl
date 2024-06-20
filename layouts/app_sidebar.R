library(shiny)
library(palmerpenguins)
library(bslib)
library(bsicons)
library(ggplot2)

choices <- c("species", "island")

ui <- page_sidebar(
  sidebar = sidebar(
    selectInput("var", "Select Island",
                choices,
                selected = choices[1]
    )
  ),
  card({
    plotOutput("penguins")
  })
)

server <- function(input, output) {
  output$penguins <- renderPlot({
    req(input$var)
    ggplot(penguins, aes(
      x = bill_depth_mm,
      y = bill_length_mm,
      color = .data[[input$var]]
    )) +
      geom_point()
  })
}

shinyApp(ui, server)