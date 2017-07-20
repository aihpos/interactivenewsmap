library(dplyr)
library(leaflet)
library(sp)
library(magrittr)
bigdfarticles2 <- bigdfarticles2 %>% mutate(location = locationtag)
a <- left_join(bigdfarticles2, latlongframe, by = location)

a <- inner_join(latlongframe, bigdfarticles2, by = location)

a <- bigdfarticles2 %>% left_join(latlongframe)

factpal<- colorFactor(topo.colors(30), a$location)

ui <- bootstrapPage(
  tags$style(type = "text/css", "html, body {width:100%;height:100%}"),
  leafletOutput("map", width = "100%", height = "100%"),
  absolutePanel(top = 10, right = 10,
                textInput("locationtag", label = h3("Landmark"), value = "Enter text..."),
                textInput("City", label = h3("City"), value = "Enter text..."),
                textInput("Country", label = h3("Country"), value = "Enter text..."),
                textInput("source", label = h3("Source"), value = "Enter text...") 
  )
)


server <- function(input, output, session) {
d <- leaflet() %>% addTiles() %>%
  #  addMarkers(data = a, lng = ~long, lat = ~lat, popup = ~(location)) %>%
  addCircleMarkers(
    data = a, lng = ~long, lat = ~lat, popup = ~(articles.title),
    color = ~factpal(location),
    stroke = FALSE, fillOpacity = 0.5,
    radius = runif(100, 4, 10)
  )

output$map <- renderLeaflet({
  leaflet() %>% 
  addTiles() %>% 
  addMarkers(data = a, lng = ~long, lat = ~lat, popup = ~(location))
  })
}

shinyApp(ui, server)
