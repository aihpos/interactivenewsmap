library(shiny)
library(leaflet)
library(RColorBrewer)

ui <- bootstrapPage(
  tags$style(type = "text/css", "html, body {width:100%;height:100%}"),
  leafletOutput("map", width = "100%", height = "100%"),
  absolutePanel(top = 10, right = 10,
                textInput("locationtag", label = h3("Landmark"), value = "Enter text..."),
                textInput("City", label = h3("City"), value = "Enter text..."),
                textInput("Country", label = h3("Country"), value = "Enter text..."),
                textInput("source", label = h3("Source"), value = "Enter text...")
  )
)

server <- function(input, output, session) {
  
  # Reactive expression for the data subsetted to what the user selected
  filteredData <- reactive({
    a[a$location >= input$range[1] & a$source <= input$range[2],]
  })
  filteredData <- reactive({
    a[a$source >= input$range[1] & a$source <= input$range[2],]
  })
  # This reactive expression represents the palette function,
  # which changes as the user makes selections in UI.
  colorpal <- reactive({
    colorFactorinput$colors, a$location)
  })
  
  output$map <- renderLeaflet({
    # Use leaflet() here, and only include aspects of the map that
    # won't need to change dynamically (at least, not unless the
    # entire map is being torn down and recreated).
    leaflet(a) %>% addTiles() %>%
      fitBounds(~min(long), ~min(lat), ~max(long), ~max(lat))
  })
  
  # Incremental changes to the map (in this case, replacing the
  # circles when a new color is chosen) should be performed in
  # an observer. Each independent set of things that can change
  # should be managed in its own observer.
  observe({
    pal <- colorpal()
    
    leafletProxy("map", data = filteredData()) %>%
      clearShapes() #%>%
      #addCircles(radius = ~10^nrow(location)/10, weight = 1, color = "#777777",
                 #fillColor = ~pal(mag), fillOpacity = 0.7, popup = ~paste(mag)
     #)
  })
}

shinyApp(ui, server)