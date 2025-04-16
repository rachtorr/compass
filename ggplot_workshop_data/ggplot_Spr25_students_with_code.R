## Data visualization in Rstudio with ggplot 
## COMPASS workshop 4/15/25 

# read about data here:
# https://www.kaggle.com/datasets/nationalparkservice/park-biodiversity

#########################################
# Load packages 
#########################################

# ! run these lines first 
if(!require('tidyverse')) install.packages('tidyverse') 
library(tidyverse)
library(RColorBrewer)

if(!require('plotly')) install.packages('plotly') 
library(plotly) # may need to install 

install.packages("paletteer")
library(paletteer)

##############################################
# Intro 
##############################################

# this tutorial will involve the following: 

## walk through steps of plotting with ggplot 

## consider different data types - continuous v. discrete , factors - sequential, qualitative, divergent/diverging 

## edit themes and color palettes 

#### themes - https://ggplot2.tidyverse.org/reference/ggtheme.html

#### - importat colors represent data https://pmassicotte.github.io/paletteer_gallery/#discrete-palettes

#### - Rcolorbrewer https://r-graph-gallery.com/38-rcolorbrewers-palettes.html

# See Rcolorbrewer palettes 
par(mar=c(3,4,2,2)) # sets margins for graphical parameters 
display.brewer.all()

# - explore paletteer package https://emilhvitfeldt.github.io/paletteer/
#- simplifies packages into 1 
paletteer::palettes_d_names

##############################
# First step: load data 
##############################

url_parks = "https://hum.link/parks_data"
  
parks = read.csv(url_parks)


##############################
# ggplot steps
##############################

# follow along 
ggplot(parks, aes(x=Park.Name, y=Acres)) + 
  geom_col(fill="blue", col="green") +
  coord_flip() 


# you should have the below code
# try changing the color from blue to something else
# see list of colors here: chrome-extension://efaidnbmnnnibpcajpcglclefindmkaj/https://sites.stat.columbia.edu/tzheng/files/Rcolor.pdf

ggplot(parks, aes(x=Park.Name, y=Acres)) + 
  geom_col(fill="pink", col="grey") + 
  coord_flip() +
  theme_minimal() + 
  scale_y_continuous(labels = function(n)(n/1000000)) + 
  labs(x="Park Name", y="Acres 10^6", title="Area of National Parks", subtitle="this is a subtitle")


# What can we do to make this plot look nicer?

parks_col <- ggplot(parks, 
                    aes(x=reorder(Park.Name, Acres), 
                        y=Acres, 
                        fill=State)) + 
  geom_col() + 
  coord_flip() +
  theme_minimal() + 
  scale_y_continuous(labels = function(n)(n/1000000)) + 
  labs(x="Park Name", y="Acres 10^6", title="Area of National Parks", subtitle="this is a subtitle")

ggplotly(parks_col)


# fill the color by State 


# adjust axis 
ggplot(parks, aes(x=Park.Name, y=Acres, fill=State)) +
  geom_col() + 
  coord_flip() + 
  scale_y_continuous(labels = function(n)(n/1000000))

# add labels and theme 
# labs()
# theme: select from this list https://ggplot2.tidyverse.org/reference/ggtheme.html


# change order using reorder function, change colors  

# use plotly to explore 
all_parks_bar <- ggplot(parks, aes(x=reorder(Park.Name, Acres), y=Acres, fill=State)) + 
  geom_col() + 
  coord_flip() + 
  scale_y_continuous(labels = function(n)(n/1000000)) + 
  labs(x="Park Name", y="Acres 10^6", title="Area of National Parks") + 
  theme_bw()

# plotly loads your plot and makes it interactive 
plotly::ggplotly(all_parks_bar)

ggplot(parks, aes(y=Acres, 
                  x=State,
                  group=State)) +
  geom_violin()

# two discrete variables 
ggplot(parks, aes(x=State, y=Park.Name)) +
  geom_jitter()

# two continuous variables 
ggplot(parks, aes(x=Longitude, y=Latitude, fill=State, size=Acres)) +
  geom_point(shape=24)








# repeat for state of california and change colors 
ca_parks <- parks %>% 
  filter(str_detect(State, "CA"))

# create CA plot next 

ggplot(ca_parks, aes(x=Park.Name, y=Acres, fill=Park.Name)) +
  geom_col(show.legend=F) + 
  coord_flip() +
  scale_fill_paletteer_d("ggthemes::Green_Orange_Teal")


# what other plots could we make based on this data ? 

# how do we explore color palettes? 
# https://r-graph-gallery.com/color-palette-finder


########################################
# Species data by park 
#######################################

# load in species data and preview 
sp_url = "https://hum.link/species_data"
species = read.csv(sp_url)

# preview data frame 
ggplot(species, aes(y=Category)) +
  geom_bar()

# get only CA parks 
ca_species = species[species$Park.Name %in% ca_parks$Park.Name,]
# create table with count of each species category 
ca_table = as.data.frame(table(ca_species$Park.Name, ca_species$Category)) 
names(ca_table) = c("Park.Name", "category", "freq")
head(ca_table)

# what can we plot with this?
ca_table %>% 
  filter(Park.Name=="Redwood") %>% 
ggplot(aes(x=category, y=freq))+
  geom_col() + 
  coord_flip() + 
  facet_grid('Park.Name')

#**** note: this is when my computer died, sorry to those in attendance! The next step shows how to change color for quantitative values 
#* we have previously used variations on scale_fill_d() to color in for State name or Park name because they are discrete values 
#* although the count of species in the park are discrete, there are too many numbers to be represented as discrete colors, so instead we need to use a sequential continouos color palette and scale_fill_c() 

# note that when using color for quantitative values, like freq 
ggplot(ca_table, aes(x=Park.Name, y=category, fill=freq)) +
  geom_raster() +
  scale_fill_brewer(palette="YlOrRd")

# this gives an error: continous values supplied to a discrete scale 

# instead, we can represent frequency with a continuous scale 
ggplot(ca_table, aes(x=Park.Name, y=category, fill=freq)) +
  geom_raster() +
  scale_fill_paletteer_c(palette="grDevices::Plasma")

# another option is to use a sequential palette binned to ranges, but this can hide some of the patterns in your data 
ggplot(ca_table, aes(x=Park.Name, y=category, fill=freq)) +
  geom_raster() +
  scale_fill_paletteer_binned(palette="grDevices::Plasma")



# option to remove some categories or change labels 
levels(ca_table$Park.Name) = c("Channel Islands", "Death Valley", "Joshua Tree","Lassen Volcanic","Pinnacles","Redwood","Sequoia & Kings Canyon","Yosemite")

# this line filters out the non-animal species 
ca_animals = ca_table %>% filter(category!="Vascular Plant" & category != "Nonvascular Plant" & category != "Algae" & category != "Fungi")

# create scatter plot 
ca_animals %>% 
  pivot_wider(names_from=category, values_from=freq) %>% 
  ggplot(aes(x=Fish, y=Bird), size=2) +
  geom_point() 

# try changing the x and y axis to different animal categories 

# how can we make the points colored by location and add a label? 
