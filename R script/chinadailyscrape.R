
url <- "http://www.chinadaily.com.cn/world/"

webpage <- read_html(url)

urls <- html_nodes(webpage, ".tBox3 a , .tw3_01_t a , .tBox2 a") %>%
  html_attr("href")
links <- html_nodes(webpage, ".tBox3 a , .tw3_01_t a , .tBox2 a") %>%
  html_text()
china <- data.frame(links = links, urls = urls, stringsAsFactors = FALSE)
urls <- paste0("http://www.chinadaily.com.cn/world/",china$urls)
china <- data.frame(links = links, urls = urls, stringsAsFactors = FALSE)
head(china)
china <- as.data.frame(china)
View(china)

