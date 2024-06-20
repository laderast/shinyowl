library(shiny)
library(palmerpenguins)
library(bslib)
library(bsicons)
library(ggplot2)
library(cicerone)

choices <- c("species", "island")

guide <- Cicerone$new()$step(
    el = "var",
    title = "Island",
    description = "Select an island"
  )$step(
    el="penguins",
    title = "Penguin Plot",
    description = "This is where the scatterplot goes"
  )


ui <- page_sidebar(
  use_cicerone(),
  sidebar = sidebar(
    selectInput("var", "Select Island",
                choices,
                selected = choices[1]
    ),
    actionButton("start", "Start Tour")
    
#    actionButton("start", "Click for help")
  ),
  card({
    plotOutput("penguins")
  })
 
)

server <- function(input, output,session) {

    output$penguins <- renderPlot({
    ggplot(penguins, aes(
      x = bill_depth_mm,
      y = bill_length_mm,
      color = .data[[input$var]]
    )) +
      geom_point()
  })
  
  start_tour <- FALSE
  
  observe({
    guide$init()$start()
    start_tour <<- TRUE}) |> 
    bindEvent(input$start)
}


shinyApp(ui, server)