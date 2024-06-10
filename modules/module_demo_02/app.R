#Example 2 - using multiple instances of a module

library(shiny)
library(ggplot2)
library(dplyr)
library(palmerpenguins)

data(mtcars)
mtcars <- data.frame(mtcars)
mtcars_var_choices = colnames(mtcars)

data(penguins)
penguins <- penguins %>%
    select(where(is.numeric))
penguin_var_choices <- colnames(penguins)

#load the module code
source("modules.R")

ui <- fluidPage(
    #select_hist_ui is how we initialize the ui module with id "mtcars"
    select_hist_ui(id = "mtcars_module", var_choices = mtcars_var_choices),
    #use select_hist_ui with penguin data
    select_hist_ui(id = "penguins_module", var_choices = penguin_var_choices)
)

# Define server logic required to draw a histogram
server <- function(input, output) {
    #callModule on select_hist_server with mtcars_id
    select_hist_server(id= "mtcars_module", data=mtcars)
    #callModule on select_hist_server with penguin_id
    select_hist_server(id= "penguins_module", data=penguins)
}

# Run the application 
shinyApp(ui = ui, server = server)
