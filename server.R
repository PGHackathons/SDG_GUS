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
})
