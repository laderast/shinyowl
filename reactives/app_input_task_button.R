library(shiny)
library(reactlog)
library(bslib)

reactlog_enable()

ui <- page_sidebar(
  sidebar = sidebar(
    open = "always",
    input_task_button("resample", "Resample"),
  ),
  verbatimTextOutput("summary")
)

server <- function(input, output, session) {
  sample <- eventReactive(input$resample, ignoreNULL=FALSE, {
    Sys.sleep(2)  # Make this artificially slow
    rnorm(100)
  })
  
  output$summary <- renderPrint({
    summary(sample())
  })
}

shinyApp(ui, server)