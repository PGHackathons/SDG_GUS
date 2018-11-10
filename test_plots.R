empl_1.1.1<-subset(X1_1_1,X1_1_1$SeriesCode=="SI_POV_EMP1")

pop_1.1.1<-subset(X1_1_1,X1_1_1$SeriesCode!="SI_POV_EMP1")
pop_1.1.1<-pop_1.1.1[5:12]
pop_1.1.1_2015<-subset(pop_1.1.1,pop_1.1.1$TimePeriod==2015)
pop_1.1.1_2016<-subset(pop_1.1.1,pop_1.1.1$TimePeriod==2016)

empl_1.1.1<-empl_1.1.1[2:14]
empl_1.1.1_2015<-subset(empl_1.1.1,empl_1.1.1$TimePeriod==2015)
empl_1.1.1_2016<-subset(empl_1.1.1,empl_1.1.1$TimePeriod==2016)
library(ggplot2)
library(plotly)
df <- read.csv("https://raw.githubusercontent.com/plotly/datasets/master/2011_us_ag_exports.csv")
df$hover <- with(df, paste(state, '<br>', "Beef", beef, "Dairy", dairy, "<br>",
                           "Fruits", total.fruits, "Veggies", total.veggies,
                           "<br>", "Wheat", wheat, "Corn", corn))
# give state boundaries a white border
l <- list(color = toRGB("white"), width = 2)
# specify some map projection/options
g <- list(
  scope = 'usa',
  projection = list(type = 'albers usa'),
  showlakes = TRUE,
  lakecolor = toRGB('white')
)

p <- plot_geo(df, locationmode = 'USA-states') %>%
  add_trace(
    z = ~total.exports, text = ~hover, locations = ~code,
    color = ~total.exports, colors = 'Purples'
  ) %>%
  colorbar(title = "Millions USD") %>%
  layout(
    title = '2011 US Agriculture Exports by State<br>(Hover for breakdown)',
    geo = g
  )
p
