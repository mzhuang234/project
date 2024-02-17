install.packages("shiny")
install.packages(c("mosaicData","ggplot2"))
library("shiny")
library("sourcetools")
library("later")
library("promises")
library("httpuv")
library("xtable")
library("commonmark")
library("mosaicData")
library("ggplot2")
CPS85
ggplot(data=CPS85,mapping=aes(x=exper,y=wage))
## Geoms are the geometric objects (points,lines,bars,and shaded regions) that
# can be placed on a graph. They are added using functions whose names begin
# with geom_.
## In ggplot2 graphs, functions are chained together using the + sign to build a final plot 
ggplot(data=CPS85,mapping=aes(x=exper,y=wage))+geom_point()
# delete an outlier to the exper-wage correlation
CPS85<-CPS85[CPS85$wage<40,]
ggplot(data=CPS85,mapping=aes(x=exper,y=wage))+geom_point()
# make the points larger, semitransparent, and blue
# change the gray bg to white using a theme
ggplot(data=CPS85,mapping=aes(x=exper,y=wage))+
  geom_point(color="cornflowerblue",alpha=.7,size=1.5)+
  theme_bw()
# add a line summarizing trend bt exper and wages
ggplot(data=CPS85,mapping=aes(x=exper,y=wage))+
  geom_point(color="cornflowerblue",alpha=.7,size=1.5)+
  geom_smooth(method="lm")+
  theme_bw()

## Part 2 Grouping
# allow groups of observations to be superimposed on a single graph (grouping)
ggplot(data=CPS85,
       mapping=aes(x=exper,y=wage,
                   color=sex,shape=sex,linetype=sex))+
  geom_point(alpha=.7,size=1.5)+
  geom_smooth(method="lm",se=FALSE,linewidth=1.5)+
  theme_bw()
# the color, shape, and linetype definitions were placed in the aes() function
# because we are mapping a variable to an aesthetic
# The geom_smooth option se=FALSE was added to suppress CI's, for readability
# the linewidth=1.5 option makes the line slightly thicker

## Part 3 Scales
# the aes() function is used to map variables to the visual characteristics of a plot
# Scales specify how each of these mappings occurs
ggplot(data=CPS85,
       mapping=aes(x=exper,y=wage,
                   color=sex,shape=sex,linetype=sex))+
  geom_point(alpha=.7,size=3)+
  geom_smooth(method="lm",se=FALSE,linewidth=1.5)+
  scale_x_continuous(breaks=seq(0,60,10))+
  scale_y_continuous(breaks=seq(0,30,5))+
  scale_color_manual(values=c("indianred3","cornflowerblue"))+
  theme_bw()
# breaks are defined by a vector of values. here the seq() function shortcuts
# e.g. seq(0,60,10) produces a vector starting with 0 and ups by 10 until 60
# the wages are in dollars, and we can format that
install.packages("scales")
ggplot(data=CPS85,
       mapping=aes(x=exper,y=wage,
                   color=sex,shape=sex,linetype=sex))+
  geom_point(alpha=.7,size=3)+
  geom_smooth(method="lm",se=FALSE,linewidth=1.5)+
  scale_x_continuous(breaks=seq(0,60,10))+
  scale_y_continuous(breaks=seq(0,30,5),
                     label=scales::dollar)+
  scale_color_manual(values=c("indianred3","cornflowerblue"))+
  theme_bw()

## Part 4 Facets
# when data is better analyzed side-by-side as opposed to superimposed
# facets produce graphs for each level of a variable (or combinations of variables)
ggplot(data=CPS85,
       mapping=aes(x=exper,y=wage,
                   color=sex,shape=sex,linetype=sex))+
  geom_point(alpha=.7)+
  geom_smooth(method="lm",se=FALSE)+
  scale_x_continuous(breaks=seq(0,60,10))+
  scale_y_continuous(breaks=seq(0,30,5),
                     label=scales::dollar)+
  scale_color_manual(values=c("indianred3","cornflowerblue"))+
  facet_wrap(~sector)+
  theme_bw()

## Part 5 Labels
# graphs should be easy to interpret, and informative labels are a key element in achieving this goal
# the labs() function provides customized labels for axes and legends
# additionally, titles, subtitles, and captions can be added
ggplot(data=CPS85,
       mapping=aes(x=exper,y=wage,
                   color=sex,shape=sex,linetype=sex))+
  geom_point(alpha=.7)+
  geom_smooth(method="lm",se=FALSE)+
  scale_x_continuous(breaks=seq(0,60,10))+
  scale_y_continuous(breaks=seq(0,30,5),
                     label=scales::dollar)+
  scale_color_manual(values=c("indianred3","cornflowerblue"))+
  facet_wrap(~sector)+
  labs(title="Relationship between wages and experience",
       subtitle="Current Population Survey",
       caption="source: http://mosaic-web.org/",
       x="Years of Experience",
       y="Hourly Wage",
       color="Gender",shape="Gender",linetype="Gender")+
  theme_bw()

# themes control bg colors, fonts, grid lines, legend placement, and other 
# non-data-related features of the graph
ggplot(data=CPS85,
       mapping=aes(x=exper,y=wage,
                   color=sex,shape=sex,linetype=sex))+
  geom_point(alpha=.7)+
  geom_smooth(method="lm",se=FALSE)+
  scale_x_continuous(breaks=seq(0,60,10))+
  scale_y_continuous(breaks=seq(0,30,5),
                     label=scales::dollar)+
  scale_color_manual(values=c("indianred3","cornflowerblue"))+
  facet_wrap(~sector)+
  labs(title="Relationship between wages and experience",
       subtitle="Current Population Survey",
       caption="source: http://mosaic-web.org/",
       x="Years of Experience",
       y="Hourly Wage",
       color="Gender",shape="Gender",linetype="Gender")+
  theme_minimal()

## Part 6
# placing the data and mapping options
  # previously we place data= and mapping= within ggplot() so they apply to each
  # geom function that follows
  # we can also place them directly within a geom, in which case they would only
  # apply to that specific geom
ggplot(CPS85, aes(x=exper, y=wage, color=sex))+
  geom_point(alpha=.7, size=1.5)+
  geom_smooth(method="lm", se=FALSE, linewidth=1)+
  scale_color_manual(values=c("lightblue","midnightblue"))+
  theme_bw()
# color=sex was placed in the ggplot() function so it applies to both geoms
ggplot(CPS85, aes(x=exper, y=wage))+
  geom_point(aes(color=sex),alpha=.7, size=1.5)+
  geom_smooth(method="lm", se=FALSE, linewidth=1)+
  scale_color_manual(values=c("lightblue","midnightblue"))+
  theme_bw()
# only the point geom was by sex, the line was combined
# data= and mapping= were omitted bc the first always refers to data and the
# second to mapping

# saving graphs
ggsave(file="mygraph.png",plot=myplot,width=5,height=4)
# graphs as objects
# a ggplot can be saved as a named R object (a list), manipulated further, and
# then printed or saved to disk
data(CPS85,package="mosaicData")
CPS85<-CPS85[CPS85$wage<40,] # prepare data
myplot<-ggplot(data=CPS85, aes(x=exper,y=wage))+
  geom_point() # create a scatterplot and save it as myplot
myplot

myplot2<-myplot+geom_point(size=3,color="blue") 
myplot2 # modify, save, display

myplot+geom_smooth(method="lm")+
  labs(title="Mildly interesting graph") # display with best-fit line and title

# saving graphs
ggsave(file="mygraph.png",plot=myplot,width=5,height=4)
# omitting the plot= option saves the most recently created graph
ggplot(data=mtcars,aes(x=mpg))+geom_histogram()
ggsave(file="mygraph.pdf")


## Part 7 Application
# 7a
ggplot(data=FakeDataFall2021,aes(x=Height, y=Handspan))+
  geom_point(color="blue")
# 7b
ggplot(data=FakeDataFall2021,aes(x=Height, y=Handspan))+
  geom_point(color="blue")+
  geom_smooth(method="lm")+
  labs(title="Relationship between handspans and heights",
       x="Height",
       y="Handspan")
# 7c
ggplot(data=FakeDataFall2021,aes(x=Pinkylen, y=Handspan))+
  geom_point(color="blue")
ggplot(data=FakeDataFall2021,aes(x=Pinkylen, y=Handspan))+
  geom_point(color="blue")+
  geom_smooth(method="lm")+
  labs(title="Relationship between Handspans and Pinky Lengths",
       x="Pinky Lengths",
       y="Handspan")
# 7d
ggplot(data=FakeDataFall2021,aes(x=Pinkylen, y=Handspan,color=Gender))+
  geom_point()

# 7e
ggplot(data=FakeDataFall2021,aes(x=Pinkylen, y=Handspan,color=Gender))+
  geom_point()+
  geom_smooth(method="lm",se=FALSE)+
  scale_color_manual(values=c("indianred3","cornflowerblue"))

# 7f
ggplot(data=FakeDataFall2021,aes(x=Pinkylen, y=Handspan, color=Gender))+
  geom_point()+
  geom_smooth(method="lm",se=FALSE)+
  scale_color_manual(values=c("indianred3","cornflowerblue"))+
  facet_wrap(~Breakfast)

# 7g
ggplot(data=FakeDataFall2021,aes(x=Pinkylen, y=Handspan, color=Gender))+
  geom_point()+
  geom_smooth(method="lm",se=FALSE)+
  scale_color_manual(values=c("indianred3","cornflowerblue"))+
  facet_wrap(~FavColor)
