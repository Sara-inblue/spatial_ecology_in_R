# Final script including ll the scripts from the previous classes

# ---------------------------
# Summary
# 01 Beginning
# 02.1 Population density
# 02.2 Population distribution
# 03.1 Communities multivariate analysis
# 03.2 Communities overlap
# 04 Remote sensing data visulaization

# ---------------------------

# 01 Beginning
# R as a calculator
2 + 3

# Assign to an object
zima <- 2 + 3          # in some languages you use = to assign
zima

duccio <- 5 + 3
duccio

zima * duccio

# or

final <- zima * duccio
final

final^2

# Array
sophi <- c(10, 20, 30, 50, 70) # c indicates a function
sophi

paula <- c(100, 500, 600, 1000, 2000)
paula

plot(paula, sophi)

# change the labels in the plot
plot(paula, sophi, xlab="number of people", ylab="microplastics")

#or
people <- paula
microplastics <- sophi

plot(people, microplastics)

# change point symbols in R "point character" pch
plot(people, microplastics, pch=19)

# increase/decrease the dimension of the points "character exaggeration"
plot(people, microplastics, cex=2)

# change the color
plot(people, microplastics, col="blue")  #colors are stored with " "

# ---------------------------

# 02.1 Population density
# Package is needed for point pattern analysis
# https://CRAN.R-project.org/package=spatstat
install.packages("spatstat")
library(spatstat)

# let's use the bei data (dataset about tropical forest trees):
bei

# plotting the data
plot(bei)

# changing dimension - cex
plot(bei, cex=.2)

# changing the symbol - pch
plot(bei, cex=.2, pch=19)

# bei.extra is a datast containing data about eleation and gradient
bei.extra
plot(bei.extra)

# let's use only part of the dataset: elev
plot(bei.extra$elev)
elevation <- bei.extra$elev
plot(elevation)

# second method to select elements
elevation2 <- bei.extra[[1]]
plot(elevation2)

# let's create a desity map (passing from points to a continue surface: interpolation)
densitymap <- density(bei)  # density is a function of the spatstat package
densitymap #we are working with pixels now (image)

plot(densitymap)

# add bei points to the density map (overwrithing the image we have created)
points(bei)

# change the color palette in the map
# colors in R are stored with quotes
# R is sensible to capital letters
# 100 rapresents the gradient: how many "inner" colors we want to use to pass through to range of colors

cl <- colorRampPalette(c("black", "red", "orange", "yellow"))(100)
plot(densitymap, col=cl)

# build a new color palette avoiding usung red, green and blue together
cl2 <- colorRampPalette(c("magenta4", "hotpink2", "deeppink1", "plum1"))(100)
plot(densitymap, col=cl2)

# creating a multiframe (like a table)
par(mfrow= c(1,2))  # we put c(1,2) because their are part of an array
plot(densitymap)
plot(elev)

par(mfrow= c(2,1))
plot(densitymap)
plot(elev)

# we can use the elevation to understand why the trees are distributed in this way (so to understand the density)
# at higher elevation we have less trees (lower density)

# as an exercise create anothe rmultiframe
par(mfrow=c(1,3))
plot(bei)
plot(densitymap)
plot(elev)

# ---------------------------

# 02.2 Population distribution
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

# ---------------------------

# 03.1 Communities multivariate analysis
# species prefer to go for partition (divion of resources) instead of competition

# going into the field we take 3 samples and count the number of individuals for 3 different species 
# we use the number of individuals to plot the species on a graph

# since we cannot create plots with more than 3-d (our mind cannot conceive it) we use multivariate analysis (principal component analysis)
# maybe in one of the dimensions we cannot see some variables that we see as separate are connected

# the 2^ principal component is, by definition, perperndicular to the 1^ one (direction with the largest range of varibility)
# the 1^ PC is always explaing the highest veribility, thus the one explained by the 2^ one is always smaller

install.packages("vegan")   # vegetation analysis
library(vegan)

data(dune)   # matrix that contains the number of individuals for different species
dune

head(dune)  # it shows the first 6 rows of the dataset
tail(dune)  # it shows you the last 3 rows of the dataset

# decorana: detrended correspondence (how different species are correspondent with other) analysis
ord <- decorana(dune)
ord

# we are interested in the lenght of the 1^ axes (indicates the range)
ldc1 <- 3.7004   # yo could also use = because they are actually equivalent
ldc2 <- 3.1166
ldc3 <- 1.30055
ldc4 <- 1.47888

total = ldc1 + ldc2 + ldc3 + ldc4

plcd1 = ldc1 * 100 / total
plcd2 = ldc2 * 100 / total
plcd3 = ldc3 * 100 / total
plcd4 = ldc4 * 100 / total

plcd1
plcd2

plcd1 + plcd2    # they alone are retaining around 70% of variabilty

# final multivariate space showing the correlation in space
# it allows you to describe different environments in you dataset
plot(ord)

# ---------------------------

# 03.2 Communities overlap
# species correlate also in time
# sampling animals through camera traps

install.packages("overlap")
library(overlap)

# data from a national park in Indonisia "Kerinci"
data(kerinci)
summary(kerinci)   # info about the dataset

head(kerinci)

# the first 6 rows (header) refer to the tiger
# The unit of time is the day, so values range from 0 to 1. 
# The package overlap works entirely in radians: fitting density curves uses trigonometric functions (sin, cos, tan),
# so this speeds up simulations. The conversion is straightforward: kerinci$Time * 2 * pi

# We add a new column to the dataset containing our new variable
kerinci$timeRad <- kerinci$Time * 2 * pi         # we need to pass from linear to circular time because of the manner the package is working
head(kerinci)

# sequel or sql
# [] is selecting elements inside the dataset

# sps is the column indicating the species
tiger <- kerinci[kerinci$Sps == "tiger",]   # the come is needed to close the query

plot(tiger$timeRad)

# or

timetig <- tiger$timeRad

# plot the density of the kernel
densityPlot(timetig, rug=TRUE)    # rug is needed to smooth the lines

# select only data for macaque
maca <- kerinci[kerinci$Sps == "macaque",]
timemac <- maca$timeRad

# overlap between the species
overlapPlot(timetig, timemac)

# adding a legend
legend('topright', c("Tigers", "Macaques"), lty=c(1,2), col=c("black","blue"), bty='n')

# ---------------------------
