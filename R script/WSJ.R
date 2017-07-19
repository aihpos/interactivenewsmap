library(rvest)

url <- "https://www.wsj.com/news/world"

webpage <- read_html(url)

headline_data_html <- html_nodes(webpage, ".featured-slider-menu__item__link__title")

headline_data <- html_text(headline_data_html)

headlines_RT <- as.data.frame(headline_data)

View(headlines_RT)