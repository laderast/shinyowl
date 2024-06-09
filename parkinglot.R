```{r}
library(leaflet)
choices <- c(`100%`=100,`200%`=200)
selectInput("zoom", "Select Zoom level", choices)

```

```{r}
#| context: server
output$map <- renderLeaflet({
  map <- leaflet() |>
    leaflet::addTiles() })

```
