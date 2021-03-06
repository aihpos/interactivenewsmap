news.all <- GET("https://newsapi.org/v1/sources?category=general&language=en")

news1 <- fromJSON(content(news.all, as = "text"))

news.all <- as.data.frame(news1)

news <- select(news.all, sources.id, sources.name, sources.url) %>%
  filter(!sources.name %in% c("ABC News (AU)","Google News", "Newsweek","New York Magazine","Reddit /r/all","USA Today"))

bigdfarticles <- NULL

for(x in 1:nrow(news)){
  news[x,1] -> news_id
  newsurl = sprintf("https://newsapi.org/v1/articles?source=%s&apiKey=%s", news_id, apikey )
  articles_new <- GET(newsurl)
  articles1_new <- fromJSON(content(articles_new, as = "text")) 
  
  articles1_new <- as.data.frame(articles1_new)
  articles1_new$source <- as.character(articles1_new$source)
  articles1_new$articles.title <- as.character(articles1_new$articles.title)
  articles1_new$articles.url <- as.character(articles1_new$articles.url)
  
  articles2_new <- articles1_new %>% subset(select = c("source", "articles.title", "articles.url"))
  bigdfarticles <- rbind(bigdfarticles, articles2_new)
}

news[x,1] -> news_id
newsurl = sprintf("https://newsapi.org/v1/articles?source=%s&apiKey=%s", news_id, apikey )
articles_new <- GET(newsurl)
articles1_new <- fromJSON(content(articles_new, as = "text")) 

articles1_new <- as.data.frame(articles1_new)
articles1_new$source <- as.character(articles1_new$source)
articles1_new$articles.title <- as.character(articles1_new$articles.title)
articles1_new$articles.url <- as.character(articles1_new$articles.url)

articles2_new <- articles1_new %>% subset(select = c("source", "articles.title", "articles.url"))
bigdfarticles <- rbind(bigdfarticles, articles2_new)

# bigdfarticles has the entire data frame of articles (size 167)
# want to filter out the ones where locationtag == NONE
bigdfarticles2 <- filter(bigdfarticles, !(bigdfarticles$locationtag == "NONE"))

# articles where locationtag == NONE are now filtered out
# now have 2 if conditionals to make sure that the get_lat and get_long API request pull smoothly
# (get rid of entries with more than 1 lat/long pair or no lat/long pair)

for (x in 1:nrow(bigdfarticles2)){
  # for every entry in the filtered article dataframe, go through and check:
  # if they return more than one result
  # OR if they return no result
  
  # variable to store the api request result
  test_lat <- get_lat(bigdfarticles2[x,4])
  
  if (length(test_lat) > 1){
    # there's more than one lat/long pair, get rid of the row
    bigdfarticles2 <- bigdfarticles2[-x,]
  }
  
  if (is.null(test_lat)){
    # latitude API request returned null, get rid of the row
    bigdfarticles2 <- bigdfarticles2[-x,]
  }
}

# bigdfarticles2 now stores filtered results that can be run through the API
# (hopefully without any problems this time)

# initialize data frame stored in the format:
#     location  |   latitude    |   longitude
latlongframe <- NULL

for (x in 1:nrow(bigdfarticles2)){
  # goes through every article in the data frame to pull location data
  locationname <- bigdfarticles2[x,4]
  latlongframe[x,1] <- locationname
  latlongframe[x,2] <- get_lat(locationname)
  latlongframe[x,3] <- get_long(locationname)
}

# all the location data with latitude + longitude stored in latlongframe

#get rid of duplicate location entries in latlongframe
latlongframe <- unique(latlongframe)