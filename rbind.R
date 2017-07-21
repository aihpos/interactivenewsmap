library(dplyr)
library(leaflet)
library(sp)
library(magrittr)
bigdfarticles2 <- bigdfarticles2 %>% mutate(location = locationtag)
a <- left_join(bigdfarticles2, latlongframe, by = location)

a <- inner_join(latlongframe, bigdfarticles2, by = location)

a <- bigdfarticles2 %>% left_join(latlongframe)

factpal<- colorFactor(topo.colors(30), a$location)

d <- leaflet() %>% addTiles() %>%
#  addMarkers(data = a, lng = ~long, lat = ~lat, popup = ~(location)) %>%
  addCircleMarkers(
    data = a, lng = ~long, lat = ~lat, popup = ~(articles.title),
    color = ~factpal(location),
    stroke = FALSE, fillOpacity = 0.5,
    radius = runif(100, 4, 10)
  )


m <- leaflet() %>% 
  addTiles() %>% 
  addMarkers(data = a, lng = ~long, lat = ~lat, popup = ~(location))
