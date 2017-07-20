library(rvest) 

url <- "http://www.spiegel.de/international/"

webpage <- read_html(url)

headline_data_html <- html_nodes(webpage, ".headline")

headline_data <- html_text(headline_data_html)

headlines_spiegel <- as.data.frame(headline_data)

View(headlines_spiegel)