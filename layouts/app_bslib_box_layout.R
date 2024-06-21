library(bslib)
library(shiny)

vbs <- list(
  value_box(
    title = "1st value",
    value = "123",
    showcase = bs_icon("bar-chart"),
    theme = "purple",
    p("The 1st detail")
  ),
  value_box(
    title = "2nd value",
    value = "456",
    showcase = bs_icon("graph-up"),
    theme = "teal",
    p("The 2nd detail"),
    p("The 3rd detail")
  )
)


ui <- page_fillable(
  layout_column_wrap(
    width = "250px",
    fill = FALSE,
    vbs[[1]], vbs[[2]]
  ),
  card(
    min_height = 200,
    plotly::plot_ly(x = rnorm(100))
  )
)

server <- function(input, output){}

shinyApp(ui, server)
