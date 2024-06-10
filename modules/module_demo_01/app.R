library(shiny)
library(ggplot2)
library(dplyr)
data(mtcars)
mtcars <- data.frame(mtcars)
mtcars_var_choices = colnames(mtcars)

#load the module code
source("modules.R")

ui <- fluidPage(
    #select_hist_ui is how we initialize the ui module with id "mtcars"
    select_hist_ui(id = "mtcars_module", 
                   var_choices = mtcars_var_choices)
)

# Define server logic required to draw a histogram
server <- function(input, output) {
    #callModule on select_hist_server with id "mtcars"
    select_hist_server(id="mtcars_module", 
                       data=mtcars)
}

# Run the application 
shinyApp(ui = ui, server = server)
