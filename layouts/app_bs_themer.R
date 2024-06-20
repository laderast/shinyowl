library(ggplot2)
library(palmerpenguins)
library(bslib)

choices <- c("species", "island") 
theme_shiny <- bs_theme(preset = "darkly")
thematic::thematic_shiny()

ui <-  page_sidebar(sidebar=
  sidebar(selectInput("variable", "Select Variable to color by", choices)),
  plotOutput("my_plot"), theme = theme_shiny
)

server <- function(input, output){

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