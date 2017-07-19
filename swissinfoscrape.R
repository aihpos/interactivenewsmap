library(rvest) 

url <- "http://www.swissinfo.ch/eng/foreign-affairs"

webpage <- read_html(url)

headline_data_html <- html_nodes(webpage, ".clickFinger~ .clickFinger+ .clickFinger h3 span , .show-for-sr+ .clickFinger h3 span")

headline_data <- html_text(headline_data_html)

headlines_swissinfo <- as.data.frame(headline_data)

View(headlines_swissinfo)