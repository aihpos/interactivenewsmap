get_locations <- function(text){
  
  
  
  # function to take string and pull location tags from it
  
  
  
  apikey_textrazor <- "f9a1e365d6ed12cf4ac71a5c0c568c10fe10b581aa4ad2035c3f9602"
  
  
  
  text <- sprintf("text=%s", text)
  
  extractors <- "&extractors=entities"
  
  
  
  doc <- POST("https://api.textrazor.com",
              
              add_headers("x-textrazor-key" = apikey_textrazor),
              
              body = paste0(text, extractors)
              
  )
  
  
  
  doc <- fromJSON(content(doc, as = "text"))
  
  
  
  # want to pull one specific location from this list
  
  
  
  doc2 <- doc
  
  doc2 <- as.data.frame(doc2)
  
  
  
  for (x in 1:nrow(doc2)){
    
    if (is.null(doc2$response.entities.type[[x]])){
      
      doc2$response.entities.type[[x]] <- c("none", "none")
      
    }
    
  }
  
  
  
  doc2$response.entities.type <- map(doc2$response.entities.type, 1)
  
  
  
  doc3 <- subset(doc2, response.entities.type %in% "Place")
  
  
  
  places <- as.list(doc3$response.entities.entityId)
  
  if (is_empty(places)){
    places = "NONE"
  }
  
  
  return(places)
  
  
  
}
