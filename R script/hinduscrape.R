library(rvest) 

url <- "http://www.hindustantimes.com/world-news/"

webpage <- read_html(url)
shift <- function(x, n){
  c(x[-(seq(n))], rep(NA, n))
}
urls <- html_nodes(webpage, "#scroll-container a") %>%
  html_attr("href")
links <- html_nodes(webpage, "#scroll-container a") %>%
  html_text()
hindutimes <- data.frame(links = links, urls = urls, stringsAsFactors = FALSE)
hindutimes2 <- NULL

for (x in 1:nrow(hindutimes)){
  if (x%%2 == 0){
    hindutimes2 <- rbind(hindutimes2, hindutimes[x,])
  }
}

hindutimes <- hindutimes2

View(hindutimes)
