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
world<-map_data("world")
vic_per_100<-subset(X16_1_1,X16_1_1$SeriesCode=="VC_IHR_PSRC")
data<-world.cities
install.packages("ggmap")
library(ggmap)
install.packages("maptools")
library(maptools)
library(maps)

zz <-"ISO3V10   Country No.of.Documents Lat  Lon
ARG Argentina   41  -64 -34
AUS Australia   224 133 -27
CAN Canada  426 -95 60
IRL Ireland 68  -8  53
ITA Italy   583 12.8333 42.8333
NLD Netherlands 327 5.75    52.5
NZL 'New Zealand' 26  174 -41
ESP Spain   325 -4  40
GBR 'United Kingdom'  2849    -2  54
USA 'United States'   3162    -97 38
"

dF2 <- read.table(textConnection(zz), header = TRUE)
mdat <- map_data('world')

str(mdat)
ggplot() + 
  geom_polygon(dat=mdat, aes(long, lat, group=group), fill="grey50") +
  geom_point(data=dat, 
             aes(x=Lat, y=Lon, map_id=Country, size=`No.of.Documents`), col="red")
mapBubbles(dF=dF2, nameZSize="No.of.Documents",
           nameZColour="Country",oceanCol="lightblue", landCol="wheat",
           addLegend=FALSE, nameX = "longitude", nameY = "latitude",addColourLegend = FALSE)
install.packages("rworldmap")
library(rworldmap)
attach(homicideXpoverty)
ggplot(homicideXpoverty, aes(x=poverty, y=homicide, size=3)) +
  geom_point(alpha=0.2)
