library(dplyr)
library(shiny)
library(leaflet)
library(sp)
library(magrittr)
library(dplyr)

bigdfarticles2 <- bigdfarticles2 %>% mutate(location = locationtag)
print("bigdf")
print(head(bigdfarticles2))
print(head(latlongframe))
a <- left_join(bigdfarticles2, latlongframe)
print("a")
a <- inner_join(latlongframe, bigdfarticles2)
print("a")
a <- bigdfarticles2 %>% left_join(latlongframe)
print("a")
factpal<- colorFactor(topo.colors(30), a$location)

ui <- bootstrapPage(
  tags$style(type = "text/css", "html, body {width:100%;height:100%}"),
  leafletOutput("map", width = "100%", height = "100%"),
  absolutePanel(top = 10, right = 10,
                textInput("location", label = h3("Location"), value = "Enter text..."),
                selectInput(inputId = "source", label = h3("Select Sources"),
                            choices = c("Time" = "time", "The Washington Post" = "the-washington-post", "The Times of India" = "the-times-of-india",
                                        "The Telegraph" = "the-telegraph", "The New York Times" = "the-new-york-times", "The Huffington Post" = "the-huffington-post",
                                        "Hindustan times" = "the-hindu", "The Guardian" = "the-guardian-au", "Reuters" = "reuters",
                                        "Independent" = "independent", "BBC News" = "bbc-news", "CNN" = "cnn", "Al-jazeera" = "al-jazeera-english",
                                        "Associated-press" = "associated-press", "Metro" = "metro"),
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
     # filter(location %in% loc, source %in% news)
    filter(source == news)
    
    print(news) 
    print(site)

    leafletProxy("map") %>%
      addCircleMarkers(
        data = site, lng = ~long, lat = ~lat, popup = ~(articles.title),
        color = ~factpal(location),
        stroke = FALSE, fillOpacity = 0.5,
        radius = runif(100, 4, 10)  )
  })
  
}

shinyApp(ui, server) 