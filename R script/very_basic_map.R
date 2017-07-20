library(leaflet)
library(sp)
library(magrittr)

m <- leaflet() %>% 
  addTiles() %>% 
  addMarkers(data = latlongframe, lng = ~long, lat = ~lat, popup = ~(location))
m


