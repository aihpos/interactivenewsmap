library(dplyr)
library(shiny)
library(leaflet)
library(sp)
library(magrittr)
library(dplyr)
bigdfarticles2 <- bigdfarticles2 %>% mutate(location = locationtag)
a <- left_join(bigdfarticles2, latlongframe, by = location)

a <- inner_join(latlongframe, bigdfarticles2, by = location)

a <- bigdfarticles2 %>% left_join(latlongframe)

factpal<- colorFactor(topo.colors(30), a$location)

ui <- bootstrapPage(
  tags$style(type = "text/css", "html, body {width:100%;height:100%}"),
  leafletOutput("map", width = "100%", height = "100%"),
  absolutePanel(top = 10, right = 10,
                textInput("Location", label = h3("Location"), value = "Enter text..."),
                selectInput(inputId = "source", label = h3("Select Sources"),
                            choices = c("Time" = 1, "The Washington Post" = 2, "The Times of India" = 3,
                                        "The Telegraph" = 4, "The New York Times" = 5, "The Huffington Post" = 6,
                                        "Hindustan times" = 7, "The Guardian" = 8, "Reuters" = 9,
                                        "Independent" = 10, "BBC News" = 11, "CNN" = 12, "Al-jazeera" = 13,
                                        "Associated-press" = 14, "Metro" = 15),
                            selected = 1)
  )
)


server <- function(input, output, session) {
  
  output$map <- renderLeaflet({
    leaflet(a) %>% 
      addTiles() %>%
      addCircleMarkers(
        data = a, lng = ~long, lat = ~lat, popup = ~(articles.title),
        color = ~factpal(location),
        stroke = FALSE, fillOpacity = 0.5,
        radius = runif(100, 4, 10)  )
  })
  
  observe({
    news <- input$source
    loc<- input$location
    site <- a %>%
      filter(location %in% loc, source %in% news)
    
    leafletProxy("map") %>%
      addCircleMarkers(
        data = a, lng = ~long, lat = ~lat, popup = ~(articles.title),
        color = ~factpal(location),
        stroke = FALSE, fillOpacity = 0.5,
        radius = runif(100, 4, 10)  )
  })
  
}

shinyApp(ui, server) 