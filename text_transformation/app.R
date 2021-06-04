# Shiny App -------------------------------------------------

library(shiny)
library(tidyverse)
library(ggthemes)
library(ggtext)


# ui
ui <- fluidPage(
  titlePanel("Reading Texts Visually"),
  
  helpText("Examine the following texts and their most frequently occurring words."),
  
  fluidRow(
    column(
      4,
      radioButtons(
        inputId = "text_name",
        label = "Select a text to interpret:",
        choices = list(
          "Algorithms of Oppression" = "algorithms",
          "Americanah" = "americanah",
          "Selection of Poems by Emily Dickinson" = "dickinson",
          "Stories of Your Life and Others" = "story",
          "Areopagitica" = "areopagitica"
        )
      )
    )
  ),
  hr(),
  plotOutput(outputId = "word_counts", height = "70vh")
)


# server
server <- function(input, output) {
  # load data
  algorithms_data <- read_csv("data/algorithms.csv")
  americanah_data <- read_csv("data/americanah.csv")
  dickinson_data <- read_csv("data/dickinson.csv")
  story_data <- read_csv("data/story.csv")
  areopagitica_data <- read_csv("data/areopagitica.csv")
  
  output$word_counts <- renderPlot({
    text_data <- switch(
      input$text_name,
      "algorithms" = algorithms_data,
      "americanah" = americanah_data,
      "dickinson" = dickinson_data,
      "story" = story_data,
      "areopagitica" = areopagitica_data
    )
    text_titles = list(
      "*Algorithms of Oppression*" = "algorithms",
      "*Americanah*" = "americanah",
      "Emily Dickinson's poetry" = "dickinson",
      "*Stories of Your Life and Others*" = "story",
      "*Areopagitica*" = "areopagitica"
    )
    # text_data <- algorithms_data
    text_data <- text_data %>% 
      arrange(desc(count)) %>% 
      slice(1:50)
    text_data %>% 
      ggplot(aes(count, word, fill = count)) +
        geom_bar(stat = "identity", width = 0.5, show.legend = FALSE) +
        scale_x_continuous(expand = c(0,0)) +
        scale_fill_distiller(palette = "Spectral") +
        theme_minimal() +
        labs(
          title = paste("Word Frequencies in", names(text_titles[text_titles == input$text_name]), sep = " "),
          x = "Frequency",
          y = "Word"
        ) +
        theme(
          axis.text.y = element_text(face = "bold"),
          panel.grid = element_blank(),
          plot.title = element_markdown(size = 20),
          axis.text = element_text(size = 12),
          axis.title = element_text(size = 14)
        )
  })
}

shinyApp(ui = ui, server = server)

