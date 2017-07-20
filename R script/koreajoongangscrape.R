library(rvest) 

url <- "http://koreajoongangdaily.joins.com/"

webpage <- read_html(url)

headline_data_html <- html_nodes(webpage, ".new_news .title_cr , .contents .title_cr")

headline_data <- html_text(headline_data_html)

headlines_joongang <- as.data.frame(headline_data)

View(headlines_joongang)