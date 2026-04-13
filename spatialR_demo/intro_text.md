# Intro to Spatial vector data in R 

We will go through the following steps: 
1. Load and explore vector data as a simple feature using `sf`
2. Use `ggplot2` for developing different types of visualizations 
3. Create interactive maps with `mapview` 

We will work with the following packages: 

* [Simple Features for R](https://r-spatial.github.io/sf/index.html), or sf, allows you to work with vector data as a data frame
* [mapview](https://r-spatial.github.io/mapview/index.html) for interactive viewing of maps 
* [ggplot2](https://ggplot2.tidyverse.org/) for creating data visualizations

Our data is from [Cal Fire Historic Fire Perimeter](https://www.fire.ca.gov/what-we-do/fire-resource-assessment-program/fire-perimeters). It contains all fire perimeters in California since 1950. This larger dataset has been filtered down to two shapefiles to simplify working with it: 
1. `calfire_2023-25/` contains all polygons in the state of California for the years 2023-2025
2. `calfire_HUU_SRF/` contains all polygons for all years, for the units: Humboldt - Del Norte CAL FIRE and Six Rivers National Forest

[Link to presentation slides](https://docs.google.com/presentation/d/1u3dHLBAbzV09xcYbOR_ysGG6VpdVswMmmjdhsAfSYyo/edit?usp=sharing) from presentation on 4/14
