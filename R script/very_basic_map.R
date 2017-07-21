library(leaflet)
library(sp)
library(magrittr)

m <- leaflet() %>% 
  addTiles() %>% 
  addMarkers(data = a, lng = ~long, lat = ~lat, popup = ~(location))
m


