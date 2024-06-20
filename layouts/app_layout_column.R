library(bslib)
library(shiny)
library(ggplot2)
library(palmerpenguins)

choices <- c("species", "island")

ui <- page_sidebar(
  sidebar = sidebar(
    selectInput("var", "Select Island", choices, selected = choices[1])
  ),
  card(
    layout_column_wrap(
      plotOutput("penguins"),
      plotOutput("penguins2")
    )
  )
)

server <- function(input, output) {
  output$penguins <- renderPlot({
    ggplot(penguins, aes(
      x = bill_depth_mm,
      y = bill_length_mm,
      color = .data[[input$var]]
    )) +
      geom_point()
  })
  
  output$penguins2 <- renderPlot({
    ggplot(penguins, aes(
      x = body_mass_g,
      y = bill_length_mm,
      color = .data[[input$var]]
    )) +
      geom_point()
  })
}

shinyApp(ui, server)
