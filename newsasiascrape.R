library(rvest) 

url <- "http://www.channelnewsasia.com/news/world"

webpage <- read_html(url)

headline_data_html <- html_nodes(webpage, ".grid__col-6 .teaser__title , .grid__col-3 .teaser__title , .is-top-stories .teaser__title , .is-background-dark-mix .teaser__title")

headline_data <- html_text(headline_data_html)

headlines_NEWSASIA <- as.data.frame(headline_data)

View(headlines_NEWSASIA)