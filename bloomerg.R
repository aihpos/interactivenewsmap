
library(rvest)

url <- "https://www.bloomberg.com/"

webpage <- read_html(url)

headline_data_html <- html_nodes(webpage, ".highlights-v6-story__headline , .hero-v6-story__headline-link")

headline_data <- html_text(headline_data_html)

headlines_RT <- as.data.frame(headline_data)

View(headlines_RT)