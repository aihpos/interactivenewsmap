get_lat <- function(location){
  
  # utilizes google geocoding API
  # has a free daily limit usage of 2,500 requests
  
  # converts location string to no-spaces format
  location_nospace <- gsub(" ", "+", location)
  
  # sends request to API
  google_url <- "https://maps.googleapis.com/maps/api/geocode/json?address="
  req_url <- sprintf("%s%s&key=%s", google_url, location_nospace, apikey_google)
  
  latlong <- GET(req_url)
  latlong <- fromJSON(content(latlong, as = "text"))
  
  # need latitude and longitude
  latitude <- latlong$results$geometry$location$lat
  
  return(latitude)
  
  
}

