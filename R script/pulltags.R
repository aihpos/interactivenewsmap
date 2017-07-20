# function to take string and pull location tags from it

apikey_textrazor <- "f9a1e365d6ed12cf4ac71a5c0c568c10fe10b581aa4ad2035c3f9602"

baseurl <- "http://api.textrazor.com"

newurl <- "https://www.nytimes.com/interactive/2017/07/19/climate/two-weeks-mcmurdo-antarctica.htm"

text <- "text=Two Weeks on Ice in McMurdo Station, Antarctica"

key <- "MY API KEY"
text <- "text=Spain's stricken Bankia expects to sell off its vast portfolio of industrial holdings that includes a stake in the parent company of British Airways and Iberia"

extractors <- "&extractors=entities"

doc <- POST("https://api.textrazor.com",
            add_headers("x-textrazor-key" = apikey_textrazor),
            body = paste0(text, extractors)
)
doc

doc <- fromJSON(content(doc, as = "text"))



# want to pull one specific location from this list

library(purrr)
library(tidyr)

doc2 <- doc
doc2 <- as.data.frame(doc2)

for (x in 1:nrow(doc2)){
  if (is.null(doc2$response.entities.type[[x]])){
    doc2$response.entities.type[[x]] <- c("none", "none")
  }
}

doc2$response.entities.type <- map(doc2$response.entities.type, 1)






# gets only place entities


locationtags <- keep(doc2, doc2$response.entities.type == "Place")


locationtags <- dplyr::filter(doc2, response$entities$type == "Place")

locationtags <- filter(doc2, doc2$response$entities$type == "Place")

locationtags <- subset(doc2, doc2$response$entities$type == "Place")

#
entitytype <- map(doc$response$entities$type, 1)
