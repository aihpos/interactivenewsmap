library(rvest) 

url <- "https://www.elnuevodia.com/english/"

webpage <- read_html(url)

headline_data_html <- html_nodes(webpage, ".story-tease-title a , #Leaderboard iframe")

headline_data <- html_text(headline_data_html)

headlines_ELNU <- as.data.frame(headline_data)

View(headlines_ELNU)