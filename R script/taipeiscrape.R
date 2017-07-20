library(rvest) 

url <- "http://www.taipeitimes.com/News/world"

webpage <- read_html(url)

headline_data_html <- html_nodes(webpage, "h2 , h1")

headline_data <- html_text(headline_data_html)

headlines_taipei <- as.data.frame(headline_data)

View(headlines_taipei)