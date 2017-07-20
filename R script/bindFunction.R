library(rvest)

#newsSource <- data.frame(matrix(0, ncol = 2, nrow = 10))
newsSource <- NULL
combineNews <- function(url, nodes, newsSource, url1){
  urls <- url
  webpage <- read_html(urls)
  urls <- html_nodes(webpage, nodes) %>%
    html_attr("href")
  # Get link text
  links <- html_nodes(webpage, nodes) %>% # get the CSS nodes
    html_text() # extract the link text
  # Combine `links` and `urls` into a data.frame
  sotu <- data.frame(links = links, urls = urls, stringsAsFactors = FALSE)
  urls <- paste0(url1,sotu$urls)
  dataframenews <- data.frame(links = links, urls = urls, stringsAsFactors = FALSE)
  dataframe <- as.data.frame(dataframenews)
  dataframenews <- data.frame(dataframe[1:10,])
  newsSource = rbind(newsSource, dataframenews)
}

newsSource <- combineNews("https://www.rt.com/news/", ".card__header_vertical_padding-to-low .link_hover", newsSource, "https://www.rt.com")
newsSource <- combineNews("http://www.iol.co.za/news/world", "h3 a", newsSource, "http://www.iol.co.za")
newsSource <- combineNews("http://www.taipeitimes.com/News/world", "h2 a", newsSource, "www.taipeitimes.com/")
newsSource <- combineNews("https://www.elnuevodia.com/english/", ".category-listing .story-tease-title a", newsSource, "https://www.elnuevodia.com")
newsSource <- combineNews("http://www.chinadaily.com.cn/world/", ".tBox3 a , .tw3_01_t a , .tBox2 a", newsSource, "http://www.chinadaily.com.cn/world/")
newsSource <- combineNews("http://www.taipeitimes.com/News/world", "h2 a", newsSource, "www.taipeitimes.com/")
newsSource <- combineNews("http://www.iol.co.za/news/world", "h3 a", newsSource, "http://www.iol.co.za")






