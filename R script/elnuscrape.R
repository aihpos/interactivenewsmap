library(rvest) 
library(magrittr)

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
