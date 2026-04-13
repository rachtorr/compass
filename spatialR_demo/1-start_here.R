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
calfire = st_read("spatialR_demo/calfire_2023-25/calfire_2023-25.shp")