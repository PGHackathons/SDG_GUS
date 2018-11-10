#
# This is the server logic of a Shiny web application. You can run the 
# application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
# 
#    http://shiny.rstudio.com/
#

library(shiny)
library(plotly)
library(ggplot2)

# Electricity data reading (for all areas)
el_data <- read.csv('data/el_data.csv')
el_data <- el_data[el_data$X.Location. == 'ALLAREA',]

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
  observeEvent(input$el_brazil, {
    rv.el_data$y = el_data[el_data$GeoAreaName == 'Brazil',]$Value
    rv.el_data$x = el_data[el_data$GeoAreaName == 'Brazil',]$TimePeriod
  })
  observeEvent(input$el_afghanistan, {
    rv.el_data$y = el_data[el_data$GeoAreaName == 'Afghanistan',]$Value
    rv.el_data$x = el_data[el_data$GeoAreaName == 'Afghanistan',]$TimePeriod
  })
  
  output$distPlot <- renderPlot({
    
    # generate bins based on input$bins from ui.R
    x    <- faithful[, 2] 
    bins <- seq(min(x), max(x), length.out = input$bins + 1)
    
    # draw the histogram with the specified number of bins
    hist(x, breaks = bins, col = 'darkgray', border = 'white')
    
  }, bg="transparent")
  
  output$plot <- renderPlotly({
    # specify some map projection/options
    g <- list(
      scope = 'usa',
      projection = list(type = 'albers usa'),
      lakecolor = toRGB('white')
    )
    plot_ly(z = state.area, text = state.name, locations = state.abb,
            type = 'choropleth', locationmode = 'USA-states') %>%
      layout(geo = g)
  })
  
  # Electricity plot
  output$elPlot <- renderPlot({
    temp <- data.frame(x = rv.el_data$x, y = rv.el_data$y)
    ggplot(data=temp, aes(x=x, y=y, group=1)) +
      geom_line()+
      geom_point()+
      ylim(0, 100)+
      ggtitle('Proportion of population with access to electricity')+
      ylab('%')+
      xlab('year')
  })
})
