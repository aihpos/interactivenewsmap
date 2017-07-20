library(rvest)

newsSource <- data.frame(matrix(0, ncol = 1, nrow = 10))

combineNews <- function(url, nodes, newsSource){
  url1 <- url
  webpage <- read_html(url1)
  headline_data_html <- html_nodes(webpage, nodes)
  headline_data <- html_text(headline_data_html)
  dataframe <- as.data.frame(headline_data)
  dataframenews <- data.frame(dataframe[1:10,])
  newsSource = cbind(newsSource, dataframenews)
}

newsSource <- combineNews("https://www.bloomberg.com/", ".highlights-v6-story__headline , .hero-v6-story__headline-link", newsSource)
newsSource <- combineNews("https://www.elnuevodia.com/english/", ".story-tease-title a , #Leaderboard iframe", newsSource)
newsSourcr <- combineNews("https://www.bloomberg.com/", ".highlights-v6-story__headline , .hero-v6-story__headline-link", newsSource)

