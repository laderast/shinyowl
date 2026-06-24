library(shiny)
library(bslib)
library(querychat)
library(DT)
library(palmerpenguins)

# Step 1: Initialize QueryChat
# Use `usethis::edit_r_environ()` to add your API key
# Find your model name by using ellmer::models_openai() or
# ellmer::models_anthropic()
client <- ellmer::chat_anthropic("claude-sonnet-4-5")
#client <- ellmer::chat_openai("")

qc <- QueryChat$new(penguins, client=client)


# Step 2: Add UI component
ui <- page_sidebar(
  sidebar = qc$sidebar(),
  card(
    card_header("Data Table"),
    dataTableOutput("table")
  ),
  card(
    fill = FALSE,
    card_header("SQL Query"),
    verbatimTextOutput("sql")
  )
)

# Step 3: Use reactive values in server
server <- function(input, output, session) {
  qc_vals <- qc$server()
  
  output$table <- renderDataTable({
    datatable(qc_vals$df(), fillContainer = TRUE)
  })

  output$sql <- renderText({
    qc_vals$sql() %||% "SELECT * FROM penguins"
  })
}

shinyApp(ui, server)