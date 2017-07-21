#Necessary packages
library(shiny)
library(sp)
library(magrittr)
library(leaflet)
library(httr)
library(jsonlite)
library(lubridate)
library(purrr)
library(tidyr)
library(dplyr)
library(reshape2)
library(rvest)
library(stringr)

# gather API keys
apikey_google <- "AIzaSyCp7aDbT6-HsvliwprutvPGy2Gkmh9Z0W8"
apikey_textrazor <- "0407e844333473eaf89156b68b244c7173bce93b1cea0fd39e90c900"
apikey_news <- "233a215b20a141fcb3081beef8a9f10f"

#Use newsapi to gather news sources 

news.all <- GET("https://newsapi.org/v1/sources?category=general&language=en")

#Convert the JSON file to a text file

news1 <- fromJSON(content(news.all, as = "text"))

#Convert the text file to a data frame
news.all <- as.data.frame(news1)

#Refine the data frame for only the sources and columns that we are interested in

news <- select(news.all, sources.id, sources.name, sources.url) %>%
  filter(!sources.name %in% c("ABC News (AU)","Google News", "Newsweek","New York Magazine","Reddit /r/all","USA Today"))

#This data frame is empty and is where all our articles headlines will be added (on a daily basis)

bigdfarticles <- NULL

#For loop that runs through our list of sources and grabs the headlines for each of them (daily?) and binds into the data frame

for(x in 1:nrow(news)){
  news[x,1] -> news_id
  newsurl = sprintf("https://newsapi.org/v1/articles?source=%s&apiKey=%s", news_id, "233a215b20a141fcb3081beef8a9f10f" )
  articles_new <- GET(newsurl)
  articles1_new <- fromJSON(content(articles_new, as = "text")) 
  
  articles1_new <- as.data.frame(articles1_new)
  articles1_new$source <- as.character(articles1_new$source)
  articles1_new$articles.title <- as.character(articles1_new$articles.title)
  articles1_new$articles.url <- as.character(articles1_new$articles.url)
  
  articles2_new <- articles1_new %>% subset(select = c("source", "articles.title", "articles.url"))
  bigdfarticles <- rbind(bigdfarticles, articles2_new)
}

# add location column to bigdfarticles
bigdfarticles$locationtag <- "NONE"

for (x in 1:nrow(bigdfarticles)){
  # for every article entry in bigdfarticles, run through textrazor API to pull first location
  
  bigdfarticles[x,4] <- get_locations(bigdfarticles[x,2])
  
}

# bigdfarticles has the entire data frame of articles (size 167)
# want to filter out the ones where locationtag == NONE
bigdfarticles2 <- filter(bigdfarticles, !(bigdfarticles$locationtag == "NONE"))

# articles where locationtag == NONE are now filtered out
# now have 2 if conditionals to make sure that the get_lat and get_long API request pull smoothly
# (get rid of entries with more than 1 lat/long pair or no lat/long pair)
View(bigdfarticles2)
for (x in 1:nrow(bigdfarticles2)){
  # for every entry in the filtered article dataframe, go through and check:
  # if they return more than one result
  # OR if they return no result
  
  # variable to store the api request result
  test_long <- get_long(bigdfarticles2[x,4])
  
  print(bigdfarticles[x,4])
  print(x)
  print(test_long)
  
  if (length(test_long) > 1 || length(test_long) == 0){
    # there's more than one lat/long pair, set to null
    bigdfarticles2[x,4] <- "NONE"
  }
  # if (is.null(test_long)){
  #   # latitude API request returned null, get rid of the row
  #   bigdfarticles2[x,4] <- "NONE"
  #   print("is.null")
  # }
}

bigdfarticles3 <- filter(bigdfarticles2, !(bigdfarticles2$locationtag == "NONE"))

# bigdfarticles2 now stores filtered results that can be run through the API
# (hopefully without any problems this time)

# initialize data frame stored in the format:
#     location  |   latitude    |   longitude
latlongframe <- data.frame(location = "empty", lat = 0, long = 0, stringsAsFactors = FALSE)

for (x in 1:nrow(bigdfarticles3)){
  # goes through every article in the data frame to pull location data
  print(x)
  print(bigdfarticles3[x,4])
  locationname <- bigdfarticles3[x,4]
  latlongframe[x,1] <- locationname
  latlongframe[x,2] <- get_lat(locationname)
  latlongframe[x,3] <- get_long(locationname)
}

# all the location data with latitude + longitude stored in latlongframe

#get rid of duplicate location entries in latlongframe

latlongframe <- unique(latlongframe)

#Shiny app with leaflet using data from above

bigdfarticles2 <- bigdfarticles2 %>% mutate(location = locationtag)

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