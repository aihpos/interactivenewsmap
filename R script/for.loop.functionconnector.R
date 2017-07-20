articletitle <- "Huge increase’ in female genital mutilation in Germany and Fargo"

locations <- get_locations(articletitle)

locations_unlisted <- unlist(locations)

locations2 <- data.frame(locations = locations_unlisted, stringsAsFactors = FALSE)

locations2$latitude <- NA

locations2$longitude <- NA

View(locations2)

nrow(locations2)

for(x in 1:nrow(locations2)){
  locations2[x, 1]
  locations2[x, 1] -> place
  locations2[x, 2] = get_lat(place)
  locations2[x,3] = get_long(place)
}
