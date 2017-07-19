library(rvest) 

url <- "https://www.welt.de/english-news/"

webpage <- read_html(url)

headline_data_html <- html_nodes(webpage, ".c-teaser-default__headline--has-compact-view")

headline_data <- html_text(headline_data_html)

headlines_welt <- as.data.frame(headline_data)

View(headlines_welt)