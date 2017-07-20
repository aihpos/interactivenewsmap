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



