library(shiny)
library(ggplot2)
library(palmerpenguins)
library(shiny)
library(reactlog)

reactlog_enable()

choices <- c("flipper_length_mm", "bill_length_mm", "body_mass_g")

ui <- page_sidebar(
  sidebar = sidebar(
    radioButtons("variable", "Select Variable to Color", 
                 choices=c("species", "island"), 
                 selected="island"),
    selectInput("x_plot", "Select X Variable", 
                choices = choices, selected=choices[1])),
  plotOutput("direct_plot")
)

server <- function(input, output, session){
  
  output$direct_plot <- renderPlot({
    ggplot(penguins, aes(x=.data[[input$x_plot]], y=bill_depth_mm,
                         color=.data[[input$variable]])) +
      geom_point()
  })
  
}

shinyApp(ui, server)