library(palmerpenguins)
choices <- unique(penguins$species)
islands <- unique(penguins$island)
library(reactlog)
library(ggplot2)
library(shiny)
library(bslib)
library(dplyr)

reactlog_enable()

ui <- page_sidebar(
  sidebar = sidebar(
    open="always",
    radioButtons("radio", "Select Species", choices=choices, selected = NULL),
    selectInput("island", "Select Islands", choices=islands,selected=NULL,multiple = TRUE)
  ),
  plotOutput("species_plot")
)

server <- function(input, output){
  
  my_data <- reactive({ 
    req(input$island)
    penguins |> dplyr::filter(species == input$radio) |>
      dplyr::filter(island %in% input$island)
  }) 
  
  output$species_plot <- renderPlot({
    ggplot(my_data(), aes(x=bill_depth_mm, 
                          y=bill_length_mm, 
                          color=island)) +
      geom_point()
  })
}

shinyApp(ui, server)
