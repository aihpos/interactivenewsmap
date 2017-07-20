library(leaflet)
library(sp)

data <- read.csv("csv file here")
clean.data <- data[complete.cases(data),]

data$long <- as.numeric(data$long)
data$lat <- as.numeric(data$lat)

data.sp <- SpatialPointsDataFrame(data[,c(x,y)], data[, -c(x,y)])
#x and y are the column numbers that the lat and long are found in, giving the graph coordinate points

m <- leaflet() %>% 
  addTiles() %>% 
  addMarkers(data = data, lng = ~long, lat = ~lat, popup = "Whatever we want to popup")
m
