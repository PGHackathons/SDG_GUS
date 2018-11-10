<<<<<<< HEAD
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
             plotly_plot = plotlyOutput("plott"),
             web_plotly = plotlyOutput("plot")
             
         
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
=======
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
             # Electricity plot and buttons
             el_plot = plotOutput("elPlot"),
             el_button.Poland = actionButton("el_poland", "Poland"),
             el_button.Brazil = actionButton("el_brazil", "Brazil"),
             el_button.Afghanistan = actionButton("el_afghanistan", "Afghanistan"),
             
             hom_plot = plotOutput("homPlot"),
             hom_button.Poland = actionButton("hom_poland", "Poland"),
             hom_button.Germany = actionButton("hom_germany", "Germany"),
             hom_button.Afghanistan = actionButton("hom_afghanistan", "Afghanistan")
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
>>>>>>> cdbd8b65391a6d3de18950a606e5b45445a32bad
