library(rvest) 

url <- "http://www.zeit.de/english/index"

webpage <- read_html(url)

headline_data_html <- html_nodes(webpage, ".visually-hidden+ span")

headline_data <- html_text(headline_data_html)

headlines_zeit <- as.data.frame(headline_data)

View(headlines_zeit)