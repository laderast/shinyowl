library(querychat)
library(NHANES)

client <- ellmer::chat_anthropic("claude-sonnet-4-5")

qc <- querychat(
  data_source=NHANES,
  client = client,
  data_description = "data_description.md",
  tools=c("query", "update", "visualize"),
  greeting = "Welcome to the NHANES dataset."
)
qc$app()