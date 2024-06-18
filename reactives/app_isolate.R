library(palmerpenguins)
library(reactlog)

reactlog_enable()
choices <- unique(penguins$species)
islands <- unique(penguins$island)

ui <- page_sidebar(
  sidebar = sidebar(
    open="always",
    radioButtons("radio", "Select Species", 
                 choices=choices, selected = "Gentoo"),
    selectInput("island", "Select Islands", 
                choices=islands, selected="Biscoe")
  ),
  plotOutput("species_plot")
)

server <- function(input, output){
  
  my_data <- reactive({ 
    penguins |> dplyr::filter(species == input$radio) |>
      ## Use isolate() in this filter statement
      ## reactive won't update when input$island changes
      dplyr::filter(island %in% isolate(input$island))
  }) 
  
  output$species_plot <- renderPlot({
    ggplot(my_data(), aes(x=bill_depth_mm, 
                          y=bill_length_mm, 
                          color=island)) +
      geom_point()
  })
}

shinyApp(ui, server)