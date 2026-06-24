library(shiny)
library(bslib)
library(DT)
library(plotly)
library(palmerpenguins)
library(dplyr)
library(bsicons)
library(querychat)

client <- ellmer::chat_anthropic("claude-sonnet-4-5")
#client <- ellmer::chat_openai("")

qc <- QueryChat$new(penguins, greeting="Welcome to Penguins!", client=client)

ui <- page_sidebar(
  title = "Palmer Penguins Analysis",
  class = "bslib-page-dashboard",
  sidebar = qc$sidebar(),
  layout_column_wrap(
    width = 1 / 3,
    fill = FALSE,
    value_box(
      title = "Total Penguins",
      value = textOutput("count"),
      showcase = bs_icon("piggy-bank"),
      theme = "primary"
    ),
    value_box(
      title = "Species Count",
      value = textOutput("species_count"),
      showcase = bs_icon("bookmark-star"),
      theme = "success"
    ),
    value_box(
      title = "Avg Body Mass",
      value = textOutput("avg_mass"),
      showcase = bs_icon("speedometer"),
      theme = "info"
    )
  ),
  layout_columns(
    card(
      card_header(textOutput("table_title")),
      DT::dataTableOutput("data_table")
    ),
    card(
      card_header("Species Distribution"),
      plotlyOutput("species_plot")
    )
  ),
  layout_columns(
    card(
      card_header("Bill Length Distribution"),
      plotlyOutput("bill_length_dist")
    ),
    card(
      card_header("Body Mass by Species"),
      plotlyOutput("mass_by_species")
    )
  )
)

server <- function(input, output, session) {
  qc_vals <- qc$server()

  output$count <- renderText({
    nrow(qc_vals$df())
  })

  output$species_count <- renderText({
    length(unique(qc_vals$df()$species))
  })

  output$avg_mass <- renderText({
    avg <- mean(qc_vals$df()$body_mass_g, na.rm = TRUE)
    paste0(round(avg, 0), "g")
  })

  output$table_title <- renderText({
    qc_vals$title() %||% "All Penguins"
  })

  output$data_table <- DT::renderDataTable({
    DT::datatable(
      qc_vals$df(),
      fillContainer = TRUE,
      options = list(
        scrollX = TRUE,
        pageLength = 10,
        dom = "ti"
      )
    )
  })

  output$species_plot <- renderPlotly({
    plot_ly(
      count(qc_vals$df(), species),
      x = ~species,
      y = ~n,
      type = "bar",
      marker = list(color = c("#1f77b4", "#ff7f0e", "#2ca02c"))
    )
  })

  output$bill_length_dist <- renderPlotly({
    plot_ly(
      qc_vals$df(),
      x = ~bill_length_mm,
      type = "histogram",
      nbinsx = 30,
      marker = list(color = "#1f77b4", opacity = 0.7)
    )
  })

  output$mass_by_species <- renderPlotly({
    plot_ly(
      qc_vals$df(),
      x = ~species,
      y = ~body_mass_g,
      color = ~sex,
      type = "box",
      colors = c("#1f77b4", "#ff7f0e")
    )
  })
}

shinyApp(ui = ui, server = server)