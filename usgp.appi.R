install.packages(c("httr", "jsonlite", "lubridate"))
library("httr")
library("jsonlite")
library("lubridate")
library("dplyr")
NEWKEY = "233a215b20a141fcb3081beef8a9f10f"
baseurl = "https://newsapi.org/v1/articles"

paste0(baseurl, NEWKEY)

news.all <- GET("https://newsapi.org/v1/sources?category=general&language=en")
news1 <- fromJSON(content(news.all, as = "text"))
news.all <- as.data.frame(news1)
View(news.all)

news <- news.all[-c(1,6,10,11,12,14), ]
View(news)
news <- news.all[, -grep()(!sources.name %in% "ABC News (AU)",
                           
news <- select(news.all, sources.id, sources.name, sources.description, sources.url, sources.country) %>%
filter(!sources.name %in% c("ABC News (AU)","Google News", "Newsweek","New York Magazine","Reddit /r/all","USA Today"))
  