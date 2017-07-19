library(rvest)

url <- "https://www.rt.com/news/"

webpage <- read_html(url)

headline_data_html <- html_nodes(webpage, ".card__header_vertical_padding-to-low .link_hover")

headline_data <- html_text(headline_data_html)

headlines_RT <- as.data.frame(headline_data)

View(headlines_RT)

