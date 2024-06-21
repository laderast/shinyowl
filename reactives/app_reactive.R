library(palmerpenguins)
library(reactlog)
library(ggplot2)
library(shiny)
library(bslib)
library(dplyr)

reactlog_enable()

library(palmerpenguins)
choices <- unique(penguins$species)

ui <- page_sidebar(
  sidebar = sidebar(
    open="always",
    radioButtons("radio", "Select Species", 
                 choices=choices, selected = "Gentoo")),
  plotOutput("species_plot")
)

server <- function(input, output){
  
  my_data <- reactive({ 
    penguins |> dplyr::filter(species == input$radio)
  }) 
  
  output$species_plot <- renderPlot({
    ggplot(my_data(), aes(x=bill_depth_mm, 
                          y=bill_length_mm, 
                          color=island)) +
      geom_point()
  })
}

shinyApp(ui, server)
