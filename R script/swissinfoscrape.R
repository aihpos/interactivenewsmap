library(rvest) 

url <- "http://www.swissinfo.ch/eng/foreign-affairs"

webpage <- read_html(url)

headline_data_html <- html_nodes(webpage, ".clickFinger~ .clickFinger+ .clickFinger h3 span , .show-for-sr+ .clickFinger h3 span")

headline_data <- html_text(headline_data_html)

headlines_swissinfo <- as.data.frame(headline_data)

View(headlines_swissinfo)

url <- "https://www.elnuevodia.com/english/"

webpage <- read_html(url)

urls <- html_nodes(webpage, ".category-listing .story-tease-title a") %>%
  html_attr("href")
links <- html_nodes(webpage, ".category-listing .story-tease-title a") %>%
  html_text()
elnu <- data.frame(links = links, urls = urls, stringsAsFactors = FALSE)
urls <- paste0("https://www.elnuevodia.com",elnu$urls)
elnu <- data.frame(links = links, urls = urls, stringsAsFactors = FALSE)
head(elnu)
elnu <- as.data.frame(elnu)
View(elnu)