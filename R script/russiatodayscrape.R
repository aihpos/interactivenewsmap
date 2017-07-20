library(rvest)

# RussiaToday Scrape

url <- "https://www.rt.com/news/"

webpage <- read_html(url)

headline_data_html <- html_nodes(webpage, ".card__header_vertical_padding-to-low .link_hover")

headline_data <- html_text(headline_data_html)

headlines_RT <- as.data.frame(headline_data)

View(headlines_RT)

# MoscowTimes Scrape

url2 <- "https://themoscowtimes.com/world"

webpage2 <- read_html(url2)

headline_data_html2 <- html_nodes(webpage2, ".news-item-title")

headline_data2 <- html_text(headline_data_html2)

headlines_MT <- as.data.frame(headline_data2)

View(headlines_MT)

# Sowetan Scrape

url3 <- "http://www.sowetanlive.co.za/news/world-news/"
  
webpage3 <- read_html(url3)

headline_data_html3 <- html_nodes(webpage3, "h5 a")

headline_data3 <- html_text(headline_data_html3)

headlines_SW <- as.data.frame(headline_data3)

View(headlines_SW)

# ChinaDaily Scrape

url4 <- "http://www.chinadaily.com.cn/world/"
  
webpage4 <- read_html(url4)

headline_data_html4 <- html_nodes(webpage4, ".tw3_01_t a , .tw3_l_t a , .tBox3 a , .tw2_l_t a , .tBox2 a" )

headline_data4 <- html_text(headline_data_html4)

headlines_CD <- as.data.frame(headline_data4)

View(headlines_CD)

# FoxNews Scrape

url5 <- "http://www.foxnews.com/world.html"
  
webpage5 <- read_html(url5)

headline_data_html5 <- html_nodes(webpage5, "h2 a")

headline_data5 <- html_text(headline_data_html5)

headlines_FN <- as.data.frame(headline_data5)

View(headlines_FN)

#DailyMail Scrape

url6 <- "http://www.dailymail.co.uk/news/worldnews/index.html"
  
webpage6 <- read_html(url6)

headline_data_html6 <- html_nodes(webpage6, ".linkro-darkred a")

headline_data6 <- html_text(headline_data_html6)

headlines_DM <- as.data.frame(headline_data6)

View(headlines_DM)

