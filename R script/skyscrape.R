library(rvest) 

url <- "http://news.sky.com/world"

urls <- html_nodes(webpage, "#component-top-stories .sdc-news-story-grid__headline") %>%
  html_attr("href")
links <- html_nodes(webpage, "#component-top-stories .sdc-news-story-grid__headline") %>%
  html_text()
sky <- data.frame(links = links, urls = urls, stringsAsFactors = FALSE)
urls <- paste0("https://www.elnuevodia.com",sky$urls)
sky <- data.frame(links = links, urls = urls, stringsAsFactors = FALSE)
head(sky)
sky <- as.data.frame(sky)
View(sky)
