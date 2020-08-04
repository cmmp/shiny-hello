#
# This is a Shiny web application. You can run the application by clicking
# the 'Run App' button above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

library(shiny)
library(tidyverse)
library(babynames)
library(Cairo)

options(shiny.usecairo=T)

# Define UI for application that draws a histogram
ui <- fluidPage(
    titlePanel('Baby Name Explorer'),
    sidebarLayout(
        sidebarPanel(
            textInput('name', 'Please, enter a name:', 'David'),
        ),
        mainPanel(
            plotOutput("trend")
        )
    )
)

# Define server logic required to draw a histogram
server <- function(input, output, session) {
    output$trend <- renderPlot({
        babynames %>%
            filter(name == input$name) %>%
            ggplot(aes(year, prop, color = sex)) +
            geom_line() +
            theme_bw()
    })
}

# Run the application
shinyApp(ui = ui, server = server)
