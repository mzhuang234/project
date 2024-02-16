install.packages("shiny")
install.packages(c("mosaicData","ggplot2"))
CPS85
ggplot(data=CPS85,mapping=aes(x=exper,y=wage))
## Geoms are the geometric objects (points,lines,bars,and shaded regioins) that
# can be placed on a graph. They are added using functions whose names begin
# with geom_.
## In ggplot2 graphs, functions are chained together using the + sign to build a final plot 
ggplot(data=CPS85,mapping=aes(x=exper,y=wage))+geom_point()
# delete an outlier to the exper-wage correlation
CPS85<-CPS85[CPS85$wage<40,]
ggplot(data=CPS85,mapping=aes(x=exper,y=wage))+geom_point()
mean(c(3,24,365,60))
