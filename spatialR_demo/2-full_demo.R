# install packages 
install.packages("sf")
install.packages("ggplot2")
install.packages("mapview")
install.packages("dplyr")

# load packages 
library(sf)
library(mapview)
library(ggplot2)


# load data 
calfire = sf::st_read("spatialR_demo/calfire_2023-25/calfire_2023-25.shp")

# use any function that you would on a data frame 
# preview first six rows
head(calfire)

# see column names
names(calfire)

# summary 
summary(calfire)

# you can treat your simple features like a data frame! 

# plot 
hist(calfire$GIS_ACRES)
barplot(calfire$YEAR_)
# base R plots can be used in the same way as a data frame 

# plot all attributes 
plot(calfire)

# to plot a single attribute, don't use dollar signs, use single square bracket and ''  
plot(calfire['CAUSE'])

# let's create a ggplot 
ggplot(calfire) + 
  geom_col(aes(x=YEAR_, y=GIS_ACRES, fill=as.factor(CAUSE)))

# to create simple features ggplot we will use geom_sf()
ggplot(calfire) +
  geom_sf(aes(fill=GIS_ACRES))


# mapview create interactive plots 
mapview(calfire, zcol='CAUSE')

# let's look at all fires in Humboldt 
calfire_hum = st_read("spatialR_demo/calfire_HUU_SRF/calfire_HUU_SRF.shp")

# recreate our plots 
ggplot(calfire_hum) +
  geom_col(aes(x=YEAR_, y=GIS_ACRES), fill="red") +
  ggtitle("unit IDs HUU and SRF")

# ggplot simple feature 
ggplot(calfire_hum) +
  geom_sf(aes(alpha=YEAR_), fill="red")

mapview(calfire_hum, zcol='YEAR_')


# use any dplyr function - filter 
calfire_hum_20 = calfire_hum %>% dplyr::filter(YEAR_>=2020)

mapview(calfire_hum_20, zcol='CAUSE')  

