#
# This is the user-interface definition of a Shiny web application. You can
# run the application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
# 
#    http://shiny.rstudio.com/
#

library(shiny)
library(plotly)


htmlTemplate("index.html",
             button = actionButton("action", "Action"),
             slider = sliderInput("x", "X", 1, 100, 50),
             slider_input = sliderInput("bins", "Number of bins:", min = 1, max = 50, value = 30),
             web_plot = plotOutput("distPlot"),
             web_plotly = plotlyOutput("plot"),
             
             # Electricity plot and buttons
             el_plot = plotOutput("elPlot"),
             el_button.Poland = actionButton("el_poland", "Poland"),
             el_button.Brazil = actionButton("el_brazil", "Brazil"),
             el_button.Afghanistan = actionButton("el_afghanistan", "Afghanistan")
)

# Define UI for application that draws a histogram
#shinyUI(fluidPage(
  
  # Application title
#  titlePanel("Old Faithful Geyser Data"),
  
#  htmlTemplate("index.html", name = "component1"),
  # Sidebar with a slider input for number of bins 
#  sidebarLayout(
#    sidebarPanel(
#       sliderInput("bins",
#                   "Number of bins:",
#                   min = 1,
#                   max = 50,
#                   value = 30)
#    ),
    
    # Show a plot of the generated distribution
#    mainPanel(
#       plotOutput("distPlot")
#    )
#  )
#))
