library(palmerpenguins)
library(reactlog)
library(ggplot2)
library(shiny)
<<<<<<< HEAD
library(dplyr)
library(bslib)
=======
library(bslib)
library(dplyr)
>>>>>>> 3454c46a358523be36c44f7f6b4b2a3b55fad3fd

reactlog_enable()
choices <- unique(penguins$species)

ui <- page_sidebar(
  sidebar = sidebar(
    open="always",
    radioButtons("radio", "Select Species", choices=choices, selected = "Gentoo"),
    actionButton("activate", "Click to Filter")
  ),
  plotOutput("species_plot")
)

server <- function(input, output){
  
  my_data <- eventReactive( input$activate,
                            { penguins |> dplyr::filter(species == input$radio)}) 
  
  output$species_plot <- renderPlot({
    ggplot(my_data(), aes(x=bill_depth_mm, y=bill_length_mm, color=species)) +
      geom_point()
  })
}

shinyApp(ui, server)