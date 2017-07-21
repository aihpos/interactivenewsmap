install.packages(c("httr", "jsonlite", "lubridate"))

library("httr")
library("jsonlite")
library("lubridate")
library("dplyr")

apikey = "233a215b20a141fcb3081beef8a9f10f"

# Retrieving source names and info

news.all <- GET("https://newsapi.org/v1/sources?category=general&language=en")

news1 <- fromJSON(content(news.all, as = "text"))

news.all <- as.data.frame(news1)

news <- select(news.all, sources.id, sources.name, sources.description, sources.url, sources.country) %>%
filter(!sources.name %in% c("ABC News (AU)","Google News", "Newsweek","New York Magazine","Reddit /r/all","USA Today"))

View(news)

# Retreieving article headlines 

articles <- GET("https://newsapi.org/v1/articles?source=cnn&apiKey=233a215b20a141fcb3081beef8a9f10f")

articles1 <- fromJSON(content(articles, as = "text"))

articles <- as.data.frame(articles1)

articles.clean <- select(articles, source, articles.title, articles.description, articles.url)

View(articles.clean)

# German news headlines

articles.de <- GET("https://newsapi.org/v1/articles?source=spiegel-online&apiKey=233a215b20a141fcb3081beef8a9f10f")

articles.de.1 <- fromJSON(content(articles.de, as = "text"))

articles.de <- as.data.frame(articles.de.1)

articles.de.clean <- select(articles.de, source, articles.title, articles.description, articles.url)

View(articles.de.clean)

