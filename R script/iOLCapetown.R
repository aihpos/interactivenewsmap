
library(rvest) 
url <- "http://www.iol.co.za/news/world"
webpage <- read_html(url)
urls <- html_nodes(webpage, "h3 a") %>%
  html_attr("href")
# Get link text
links <- html_nodes(webpage, "h3 a") %>% # get the CSS nodes
  html_text() # extract the link text
# Combine `links` and `urls` into a data.frame
sotu <- data.frame(links = links, urls = urls, stringsAsFactors = FALSE)
urls <- paste0("http://www.iol.co.za",sotu$urls)
sotu <- data.frame(links = links, urls = urls, stringsAsFactors = FALSE)
head(sotu)
sotu <- as.data.frame(sotu)
View(sotu)
