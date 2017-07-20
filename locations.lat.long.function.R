articletitle <- "Huge increase’ in female genital mutilation in Germany and Fargo"

locations <- get_locations(articletitle)

locations_unlisted <- unlist(locations)

locations2 <- data.frame(locations = locations_unlisted)

locations2$latitude <- NA

locations2$longitude <- NA

View(locations2)
