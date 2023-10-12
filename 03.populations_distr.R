# Why populations are disperse over the landscape in a certain manner?

library(sdm) # spatial distribution modell
library(terra)  #it now contains also the rgdal package

# the system.file is going to look for a certain file in the package you insalled
# external is a folder inside the package sdm that contains a file coll species.shp
#shp files are colled vector files
file <- system.file("external/species.shp", package="sdm")
file

# vect is a function to pass from the shp file to the points
species <- vect(file)
species

