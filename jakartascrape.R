library(rvest) 

url <- "http://jakartaglobe.id/international/"

webpage <- read_html(url)

headline_data_html <- html_nodes(webpage, ".titlerightalign")

headline_data <- html_text(headline_data_html)

headlines_jakarta <- as.data.frame(headline_data)

View(headlines_jakarta)