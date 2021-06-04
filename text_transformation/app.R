# Shiny App -------------------------------------------------

library(shiny)
library(tidyverse)
library(ggthemes)



# ui
ui <- fluidPage(
  titlePanel("Text Transformation")
)


# server
server <- function(input, output) {

}

shinyApp(ui = ui, server = server)

