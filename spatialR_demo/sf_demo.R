# https://r-spatial.github.io/sf/
library(sf)
library(ggplot2)
# https://r-spatial.github.io/mapview/index.html
library(mapview)

setwd("../six_rivers/")

#https://www.fire.ca.gov/what-we-do/fire-resource-assessment-program/fire-perimeters

calfires = st_read("California_Historic_Fire_Perimeters_-247493000743518952/California_Fire_Perimeters_(1950+).shp")
# watning message that there are some messed up polygons 

calfires_2000 = calfires %>% 
  filter(YEAR_>=2023)

calfires = st_read("calfire_2023-25/calfire_2023-25.shp")

calfires = st_read("calfire_HUU_SRF/calfire_HUU_SRF.shp")

# preview it like a data frame 
View(calfires)

str(calfires)

summary(calfires_2000)

# plot the geometry only 
plot(st_geometry(calfires_2000))

system.time(plot(calfires_2000))

# plot as histogram
hist(calfires_2000$GIS_ACRES)

# plot as time series 
ggplot(calfires_2000, aes(x=YEAR_, y=GIS_ACRES)) + 
  geom_col()

# base plot one column 
plot(calfires_2000['YEAR_'])

# ggplot
ggplot(calfires_2000, aes(fill=as.factor(YEAR_))) +
  geom_sf() +
  scale_fill_viridis_d()

# interactive plot 
# zcol is the column color you want to see 
mapview(calfires_2000, zcol="YEAR_")

# filter by unit ID for location
# see options
unique(calfires$UNIT_ID)

ca_hum = calfires %>% dplyr::filter(UNIT_ID=="HUU" | UNIT_ID=="SRF")

ggplot(ca_hum, aes(x=YEAR_, y=GIS_ACRES)) + 
   geom_col()

mapview(ca_hum, zcol="YEAR_")


st_write(ca_hum, "calfire_HUU_SRF.shp")

st_write(calfires_2000, "calfire_2023-25.shp")
