library(bslib)
library(bsicons)
library(shiny)
library(palmerpenguins)


beak_min <- min(penguins$bill_length_mm, na.rm = TRUE)
beak_max <- max(penguins$bill_length_mm, na.rm = TRUE)
beak_mean <- mean(penguins$bill_length_mm, na.rm = TRUE)
g_max <- max(penguins$body_mass_g, na.rm=TRUE)

vbs <- list(
  value_box(
    title = "Total Penguins",
    value = nrow(penguins),
    showcase = bs_icon("bar-chart"),
    theme = "purple",
    p("The 1st detail")
  ),
  value_box(
    title = "Heaviest Penguin (g)",
    value = g_max,
    showcase = bs_icon("graph-up"),
    theme = "teal"
  ),
  value_box(
    title="Longest Beak (mm)",
    value=beak_max,
    theme="orange"
  )
)


ui <- page_sidebar(
  theme=bs_theme(),
  sidebar = sidebar(
    selectInput(inputId = "species", label="Select Species", choices = c("Adelie", "Chinstrap", "Gentoo") ),
    sliderInput(inputId = "beak_length", 
                label="Select Maximum Beak Length", 
                min=beak_min, 
                max=beak_max, 
                value=beak_mean
                )
  ),
  
  layout_column_wrap(
    width = "200px",
    fill = FALSE,
    vbs[[1]], vbs[[2]], vbs[[3]]
  ),
  card(
    card_header("Penguin Beak Length"),
    min_height = 200,
    plotly::plot_ly(x = penguins$bill_length_mm)
  )
)

server <- function(input, output){}

shinyApp(ui, server)
