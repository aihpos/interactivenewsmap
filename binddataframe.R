library(dplyr)
bigdfarticles2 <- bigdfarticles2 %>% mutate(location = locationtag)
a <- left_join(bigdfarticles2, latlongframe, by = location)

a <- inner_join(latlongframe, bigdfarticles2, by = location)

a <- bigdfarticles2 %>% left_join(latlongframe)
View(a)

server <- function(input, output, session){
  output$CountryMap <- renderLeaflet({
    leaflet() %>% addTiles() %>% addProviderTiles("Esri.WorldStreetMap") %>%
      setView(lng = 31.165580, lat = 48.379433, zoom = 6) %>%
      addCircles(lng = as.numeric(UkrStat$Longtitude), lat = as.numeric(UkrStat$Latitude), weight = 1, radius = sqrt(UkrStat$Pop)*30, popup = paste(UkrStat$Region, ": ", UkrStat$Pop), color = "#FFA500", fillOpacity = UkrStat$Opacity) %>%
      addLegend("bottomleft", pal = pal, values = UkrStat$Pop, title = "Population in Regions") %>%
      
      #Easy buttons code
      
      addEasyButton(easyButton(
        icon="fa-globe", title="Zoom to Level 1",
        onClick=JS("function(btn, map){ map.setZoom(1); }"))) %>%
      addEasyButton(easyButton(
        icon="fa-crosshairs", title="Locate Me",
        onClick=JS("function(btn, map){ map.locate({setView: true}); }")))
  })
  
  shinyApp(ui = ui, server = server)