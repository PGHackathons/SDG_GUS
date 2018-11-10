library(shiny)
library(plotly)
library(ggplot2)
library(rworldmap)

# Electricity data reading (for all areas)
el_data <- read.csv('data/el_data.csv')
el_data <- el_data[el_data$X.Location. == 'ALLAREA',]

# Homicides data reading (16.1.1 indicator)
hom_data <- read.csv('data/homicides_data.csv')
hom_data <- hom_data[hom_data$Units == 'NUMBER',]

map.world <- map_data(map="world")

#Add the data you want to map countries by to map.world
#In this example, I add lengths of country names plus some offset
map.world$name_len <- nchar(map.world$subregion) + sample(nrow(map.world))
fff<-subset(X16_1_1,X16_1_1$SeriesCode!="VC_IHR_PSRC")
fff<-subset(fff,fff$TimePeriod==2015)
a<-data.frame(fff$GeoAreaName,fff$Value)
names(a)<-c("region","value")
library(dplyr)
cacopa <- left_join(map.world, a, by = "region")
# Define server logic required to draw a histogram
shinyServer(function(input, output) {
   
  # Electricity reactive values and button reactions
  rv.el_data <- reactiveValues(
    y = el_data[el_data$GeoAreaName == 'Poland',]$Value,
    x = el_data[el_data$GeoAreaName == 'Poland',]$TimePeriod
  )
  observeEvent(input$el_poland, {
    rv.el_data$y = el_data[el_data$GeoAreaName == 'Poland',]$Value
    rv.el_data$x = el_data[el_data$GeoAreaName == 'Poland',]$TimePeriod
  })
  observeEvent(input$el_mali, {
    rv.el_data$y = el_data[el_data$GeoAreaName == 'Mali',]$Value
    rv.el_data$x = el_data[el_data$GeoAreaName == 'Mali',]$TimePeriod
  })
  observeEvent(input$el_afghanistan, {
    rv.el_data$y = el_data[el_data$GeoAreaName == 'Afghanistan',]$Value
    rv.el_data$x = el_data[el_data$GeoAreaName == 'Afghanistan',]$TimePeriod
  })
  
  rv.hom_data <- reactiveValues(
    y = hom_data$Value[hom_data$GeoAreaName == 'Poland'],
    x = hom_data$TimePeriod[hom_data$GeoAreaName == 'Poland']
  )
  observeEvent(input$hom_poland, {
    rv.hom_data$y = hom_data$Value[hom_data$GeoAreaName == 'Poland']
    rv.hom_data$x = hom_data$TimePeriod[hom_data$GeoAreaName == 'Poland']
  })
  observeEvent(input$hom_germany, {
    rv.hom_data$y = hom_data$Value[hom_data$GeoAreaName == 'Germany']
    rv.hom_data$x = hom_data$TimePeriod[hom_data$GeoAreaName == 'Germany']
  })
  observeEvent(input$hom_afghanistan, {
    rv.hom_data$y = hom_data$Value[hom_data$GeoAreaName == 'Afghanistan']
    rv.hom_data$x = hom_data$TimePeriod[hom_data$GeoAreaName == 'Afghanistan']
  })
  
  # Electricity plot
  output$elPlot <- renderPlot({
    temp <- data.frame(x = rv.el_data$x, y = rv.el_data$y)
    ggplot(data=temp, aes(x=x, y=y, group=1)) +
      geom_line()+
      geom_point()+
      ylim(0, 100)+
      ylab('%')+
      xlab('year')+
      geom_area(alpha=0.5, fill='red')+
      theme(plot.background = element_rect(fill="#F7F7EF"))
  })
  
  output$homPlot <- renderPlot({
    temp <- data.frame(x = rv.hom_data$x, y = rv.hom_data$y)
    ggplot(data=temp, aes(x=x, y=y, group=1)) +
      geom_line()+
      geom_point()
  })
  output$worldMap<-renderPlot({
    gg <- ggplot()
    gg <- gg + theme(legend.position="none")
    gg <- gg + geom_map(data=cacopa, map=cacopa, aes(map_id=region, x=long, y=lat, fill=value))
    #gg <- gg + geom_polygon(data=cacopa, aes(x=cacopa$lat, y=cacopa$long), colour='black', fill=NA)
    gg<- gg + borders("world",colour = "grey",fill=NA)
    gg <- gg + scale_fill_gradient(low = "green", high = "brown3", guide = "colourbar")
    gg <- gg + coord_equal()
    
    gg
  })
  output$info <- renderPrint({
    #paste0("x=", input$plot_click$x, "\ny=", input$plot_click$y)
    dd<-nearPoints(cacopa,input$plot_click,threshold = 10, maxpoints = 1,
               addDist = TRUE)
    dd$region
  })
})


