library(rvest) 

url <- "http://news.sky.com/world"

webpage <- read_html(url)

headline_data_html <- html_nodes(webpage, "#component-top-stories .sdc-news-story-grid__headline")

headline_data <- html_text(headline_data_html)

headlines_skynews <- as.data.frame(headline_data)

View(headlines_skynews)