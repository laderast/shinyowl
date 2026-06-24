library(ggplot2)
library(palmerpenguins)
library(bslib)

choices <- c("species", "island")

current_theme <- bs_theme(brand=FALSE)

ui <-  page_sidebar(
  theme = current_theme,

  sidebar= sidebar(
    selectInput("variable", "Select Variable to color by", choices)),

  plotOutput("my_plot")
)

thematic::thematic_shiny()

server <- function(input, output){
 bs_themer()

  output$my_plot <- renderPlot({
    req(input$variable)

    ggplot(penguins) +
      aes(x=bill_length_mm,
        y=bill_depth_mm,
        color= .data[[input$variable]] ) +
    geom_point()
})
}


shinyApp(ui, server)
