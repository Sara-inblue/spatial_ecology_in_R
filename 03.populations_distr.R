# Why populations are disperse over the landscape in a certain manner?

library(sdm) # spatial distribution model
library(terra)  #it now contains also the rgdal package

# the system.file is going to look for a certain file in the package you insalled
# external is a folder inside the package sdm that contains a file coll species.shp
#shp files are colled vector files
file <- system.file("external/species.shp", package="sdm")
file

# vect is a function to pass from the shp file to the points
species <- vect(file)
species

# looking at the occurrence
# gives you a series of 0 and 1. These are presence (1) absence (0) data.
species$Occurrence

# There are problems with 0 (uncertain data), you might have missed the thing you where looking for.

plot(species)    #plots all data, both presences and absences

# we can select what we want to plot: presences or absences
# square brackts are used to select elements
pres <- species[species$Occurrence == 1]  # select presences

pres$Occurrence

plot(pres) # plot presences

# select absences
abse <- species[species$Occurrence == 0]
plot(abse)

# plot presences and absences one after the other 
par(mfrow = c(1,2))
plot(pres)
plot(abse)

dev.off # function to close the graph

# Look at the differences between:
#1
plot(pres, col="magenta")
points(abse, col="hotpink")

#2
par(mfrow = c(1,2))
plot(pres, col="magenta")
plot(abse, col="hotpink")

# let's understand why our species (frog) is distributed in this way: predictors (environmental variables)
# elevation predictor
# let's look at the path where we have our file
elev <- system.file("external/elevation.asc", package="sdm")  # asc means asci (type of image file)
elevmap <- rast(elev)  # rast is a function with terra package (we're dealing with images (raster))

plot(elevmap)
points(pres)   # plots the distribution on top of the map

# temperature predictor
temp <- system.file("external/temperature.asc", package="sdm")
tempmap <- rast(temp)

plot(tempmap)
points(pres)

# vegetation predictor
# large vegetation cover allow the frog to avoid predators
vege <- system.file("external/vegetation.asc", package="sdm")
vegemap <- rast(vege)

plot(vegemap)
points(pres)

# precipitation predictor
prec <- system.file("external/precipitation.asc", package="sdm")
precmap <- rast(prec)

plot(precmap)
points(pres)

par(mfrow= c(2,2))
plot(elevmap)
points(pres)
plot(tempmap)
points(pres)
plot(vegemap)
points(pres)
plot(precmap)
points(pres)
