library(rvest) 

url <- "http://www.hindustantimes.com/world-news/"

webpage <- read_html(url)

headline_data_html <- html_nodes(webpage, "#scroll-container .headingfour , .col-lg-12 .headingfive , .top-heading-news .headingfour")

headline_data <- html_text(headline_data_html)

headlines_hindustan <- as.data.frame(headline_data)

View(headlines_hindustan)