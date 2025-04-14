## Data visualization in Rstudio with ggplot 
## COMPASS workshop 4/15/25 

library(tidyverse)
## walk through steps of ggplot 

## data types - continuous v. discrete , factors 
# - sequential, qualitative, divergent/diverging 


## color palettes 
# - importat colors represent data https://pmassicotte.github.io/paletteer_gallery/#discrete-palettes
# - Rcolorbrewer https://r-graph-gallery.com/38-rcolorbrewers-palettes.html
library(RColorBrewer)
par(mar=c(3,4,2,2)) # sets margins for graphical parameters 
display.brewer.all()
# - paletteer https://emilhvitfeldt.github.io/paletteer/
library(paletteer) #- simplifies packages into 1 
paletteer::palettes_d_names
# - wesaderson: https://github.com/karthik/wesanderson
paletteer_d("wesanderson::Zissou1")
# - vangogh: https://github.com/cherylisabella/vangogh
paletteer_d("vangogh::StarryNight")

## themes - https://ggplot2.tidyverse.org/reference/ggtheme.html

# load data 
url = 
