library(bslib)
library(shiny)
library(ggplot2)
library(palmerpenguins)

choices <- c("species", "island")

ui <- page_sidebar(
  theme= bs_theme(bootswatch="vapor"),
  sidebar = sidebar(
    selectInput("var", "Select Island", choices, selected = choices[1])
  ),
    layout_column_wrap(
      card(
      plotOutput("penguins")),
      card(
      plotOutput("penguins2"))
    )
)

server <- function(input, output) {
  bs_themer()
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

thematic::thematic_shiny()

shinyApp(ui, server)
