# Final script including ll the scripts from the previous classes

# ---------------------------
# Summary
# 01 Beginning
# 02.1 Population density
# 02.2 Population distribution
# 03.1 Communities multivariate analysis
# 03.2 Communities overlap
# 04 Remote sensing data visulaization
# 05 Spectral indeces
# 06 Time series
# 07 External data
# 08 Copernicus data
# 09 Clustering
# 10 Variability
# 11 Principal component analysis

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

# 04 Remote sensing data visulaization
# colors are representing the amount of reflectance of a pixel in a certain wavelenght

# plants use mostly red light to carry out photosynthesis

# to install packages from the CRAN
install.packages("devtools")
library(devtools)

# to install packeges from github
devtools::install_github("ducciorocchini/imageRy")

library(imageRy)
library(terra)

# list the data
# all the functions in imageRy start with im.
im.list()

# to make measuraments you use ellipsoids
# different ellipsoids are used in different regions to match the geoid perfectly
# datum = ellipsoid and where it is put [ex. Clark + Italy]

# the latitude is measured as the angle beetween a line perpendicular to the surface of the Earth and the equator
# if Earth is rapresented as a sphere the perpendicular line will intersect the center, but this is not the case for the ellipsoid
# when you provide lat and long you should also provide the datum you are using

# the world geodetic system (WGS) 84 is the one we are using.

# UTM is a map projection (way to represent the spherical Earth on a plane) system to assign cordinates to location to locations on the Earth surface
# if you know the initil reference system you can "translate it" to another one

# import different data from Sentinel-2
# b2 refers to band 2 (blue, 400 microns)
b2 <- im.import("sentinel.dolomites.b2.tif")
b2

# Let's change the color
cl <- colorRampPalette(c("black", "gray", "light gray")) (100)
plot(b2, col = cl)

# importing the green band
b3 <- im.import("sentinel.dolomites.b3.tif")
plot(b3, col = cl)

# importing the red band (600 microns)
b4 <- im.import("sentinel.dolomites.b4.tif")
plot(b4, col = cl)

# import the NIR band
b8 <- im.import("sentinel.dolomites.b8.tif")
plot(b8, col = cl)

# Let's put all the images in a single graph
par(mfrow = c(2,2))
plot(b2, col = cl)
plot(b3, col = cl)
plot(b4, col = cl)
plot(b8, col = cl)
dev.off() # it closes the devices

# stack images all together
stacksent <- c(b2, b3, b4, b8)

plot(stacksent, col = cl)

# to plot just one layer from the stack we can use the number of the "element" (layer)
plot(stacksent[[4]], col = cl)

# Plot in a multiframe the bands with different color ramps
cl2 <- colorRampPalette(c("dark blue", "blue", "light blue")) (100)
cl3 <- colorRampPalette(c("dark green", "green", "light green")) (100)
cl4 <- colorRampPalette(c("firebrick4", "firebrick", "red")) (100)
cl8 <- colorRampPalette(c("orangered", "gold", "yellow")) (100)

par(mfrow = c(2,2))
plot(b2, col = cl2)
plot(b3, col = cl3)
plot(b4, col = cl4)
plot(b8, col = cl8)

# Using the RGB space
# stacksent:
# band2 blue element 1, stacksent[[1]]
# band3 green element 2, stacksent[[2]]
# band4 red element 3, stacksent[[3]]
# band8 NIR element 4), stacksent[[4]]
im.plotRGB(stacksent, r=3, g=2, b=1) # the number refers to the index of the element

# we take out the blue and add NIR
# this means we're going to look at vegetation (strongly reflects NIR)
# it is possible to discriminate beetween pasture and wood by the brightness of the red
im.plotRGB(stacksent, r=4, g=3, b=2) 

# we use the green to color NIR instead of red
# the purple part is bare soil, rock and cities
im.plotRGB(stacksent, r=3, g=4, b=2) 

# we use ble to print the NIR
im.plotRGB(stacksent, r=3, g=2, b=4) 

# Let's look at the correlation between the info in two bands
# we do it with the pairs function is a scatterplot matrix
# for example with 5 band there will be 4 pairs for each to be analized and then we divide it by 2 obtain the final number of distances (they repeate once)
pairs(stacksent)

# ---------------------------

# 05 Spectral indeces
# use different bands to create indeces

install.packages("ggplot2")
instal.packages("viridis")

library(imageRy) 
library(terra)
library(ggplot2)
library(viridis)

im.list()

mato_grosso1992 <- im.import( "matogrosso_l5_1992219_lrg.jpg" ) # this image has already been processed
# currently the bands are: 1=NIR, 2=red ,3=green

im.plotRGB(mato_grosso1992, r=2, g=1, b=3)
# here we re-assigned the bands to the colors

# enhancing the bare soil (yellow catch our eyes more)
im.plotRGB(mato_grosso1992, r=2, g=3, b=1)
# the rio peixoto should be black (it's water) but it's actully the same color of the bare soil because of the high amount of sediments

mato_grosso2006 <- im.import("matogrosso_ast_2006209_lrg.jpg")
im.plotRGB(mato_grosso2006, r=2, g=3, b=1)   

# build a multiframe with 1992 and 2006 images
par(mfrow = c(1, 2))
im.plotRGB(mato_grosso1992, r=2, g=3, b=1)
im.plotRGB(mato_grosso2006, r=2, g=3, b=1) 

plot(mato_grosso1992[[1]])

# most images ar sotred in 8bits to decrease to weight of the info
# to know how much info you can store you need to elevate 2 to the number of pixels that yu have

# DVI = NIR - RED, we use different band but in the same image
# The calculation is done pixel by pixel
# we use = because is not an asseignation, but it's the actual value
dvi1992 = mato_grosso1992[[1]] - mato_grosso1992[[2]]
plot(dvi1992)

cl <- colorRampPalette(c("darkblue", "yellow", "red", "black")) (100)
plot(dvi1992, col = cl)

dvi2006 = mato_grosso2006[[1]] - mato_grosso2006[[2]]
plot(dvi2006, col = cl)

# images with different ranges (different number of bits) cannot be compared
# for this reason we normalize the DVI
# Normalized DVI = NIR - RED / NIR + RED  (also other types of normalization)
# we obtain a range from 0 to 1
ndvi1992 = (mato_grosso1992[[1]] - mato_grosso1992[[2]]) / (mato_grosso1992[[1]] + mato_grosso1992[[2]]) 
plot(ndvi1992, col = cl)

ndvi2006 = (mato_grosso2006[[1]] - mato_grosso2006[[2]]) / (mato_grosso2006[[1]] + mato_grosso2006[[2]]) 
plot(ndvi2006, col = cl)

par(mfrow = c(1, 2))
plot(ndvi1992, col = cl)
plot(ndvi2006, col = cl)

# we can use a function to calculate DVI and NDVI to speed up calculation
ndvi2006a <- im.ndvi(mato_grosso2006, 1, 2) # the numbers refer to the bands you want to use

# ---------------------------

# 06 Time series
library(imageRy)
library(terra)

im.list()

# import data about nitrogen levels during covid
# EN means european nitrogen
EN01 <- im.import("EN_01.png")  # situation in january
EN13 <- im.import("EN_13.png")  # situation in march

par(mfrow = c(2,1))
im.plotRGB.auto(EN01)  # it plots automatically the layers using the RGB space
im.plotRGB.auto(EN13)

# you can plot the difference between two images or between two elements (layers) of the images
# using the layers
ENdif = EN01[[1]] - EN13[[1]]
plot(ENdif)

# changing the palette
cldif <- colorRampPalette(c("blue", "white", "red")) (100)
plot(ENdif, col = cldif)

# using data baout temperature in Greenland
g2000 <- im.import("greenland.2000.tif")
g2000

clg <- colorRampPalette(c("black", "blue", "white", "red")) (100)
plot(g2000, col = clg) # very low T over greenland while higher T above the surroundings

g2005 <- im.import("greenland.2005.tif")
g2010 <- im.import("greenland.2010.tif")
g2015 <- im.import("greenland.2015.tif")

# plotting the last image to look at the difference
plot(g2015, col = clg)

par(mfrow = c(1,2))
plot(g2000, col = clg)
plot(g2015, col = clg)

# making a stack with all the images (they are becoming bands of a sngle dataset)
gstack <- c(g2000, g2005, g2010, g2015)
plot(gstack, col = clg)

Gdif = gstack[[1]] - gstack[[4]]
plot(Gdif, col = cldif)  # we use the previous colorRampPalette to underline the difference

# we are gonna plot the different years with the RGB space
# based on the color of the final image we can understand in which year the T was higher
im.plotRGB(gstack, r=1, g=2, b=3) # the middle looks blueish/blackish thus the T was higher in the last period


# ---------------------------

# 07 External data
# External data

library(terra)

# set working directory
# Even if windows shows you the path with \ you need to use / to actually 
setwd("C:/Users/sarar/Downloads")

# the rast function from the library terra is udes to import the image
naja_may <- rast("najafiraq_etm_2003140_lrg.jpg")  # windows is masking the extent so ou should add a .jpg

plotRGB(naja_may, r=1, g=2, b=3)

naja_august <- rast("najafiraq_oli_2023219_lrg.jpg")
plotRGB(naja_august, r=1, g=2, b=3)

par(mfrow= c(2,1))
plotRGB(naja_may, r=1, g=2, b=3)
plotRGB(naja_august, r=1, g=2, b=3)

# multitemporal change detection
naja_dif = naja_may[[1]] - naja_august[[1]]
cl <- colorRampPalette(c('brown', 'gray', 'orange')) (100)
plot(naja_dif, col=cl)

# example with harmful algal bloom
HAB_Washington <- rast("Washington_nc_SEA_2004275_lrg.jpg")
plotRGB(HAB_Washington, r=1, g=2, b=3)
plotRGB(HAB_Washington, r=3, g=2, b=1)

install.packages("ncdf4")

# ---------------------------

# 08 Copernicus data
# https://land.copernicus.vgt.vito.be/PDF/portal/Application.html#Home

library(ncdf4)
library(terra)

# giving the working directory of the data to R
setwd("C:/Users/sarar/Downloads")

# importing the data
surf_soil_moist2023_25 <- rast("c_gls_SSM1km_202311250000_CEURO_S1CSAR_V1.2.1.nc")
plot(surf_soil_moisture2023_25)     # there are two elements, one is the real image and the oter is the error
plot(surf_soil_moisture2023_25[[1]]) 

cl <- colorRampPalette(c('red','orange','yellow')) (100)
plot(surf_soil_moisture2023_25[[1]], col=cl) 

# making a crop of the image (selecting an area [ex. lake])
# defining the extention (minlon, maxlon, minlat, maxlat)
ext <- c(20, 23, 55, 57)   # I define it "externally" so I can use it also for other images
surf_soil_moisture2023_25_crop <- crop(surf_soil_moisture2023_25, ext)

plot(surf_soil_moisture2023_25_crop[[1]], col=cl)

surf_soil_moist2023_24 <- rast("c_gls_SSM1km_202311240000_CEURO_S1CSAR_V1.2.1.nc")
surf_soil_moisture2023_24_crop <- crop(surf_soil_moisture2023_24, ext)  # gives error becase probabli in this image there's nothing at the selected ext

# ---------------------------

# 09 Clustering
# cluster = individual objects with common features

# classifying satellite images and quantifying the changes

library(terra)
library(imageRy)

im.list()

# image portraying the Sun where different gasses are visible
# there are 3 different parts that differ for the amount of energy
Sun <- im.import('Solar_Orbiter_s_first_views_of_the_Sun_pillars.jpg')

# defining the number of cluster to use (based on the amount of energy)
Sun_clusters <- im.classify(Sun, num_clusters=3)
plot(Sun_clusters)

# Let's apply the same thing to Mato Grosso images
m1992 <- im.import("matogrosso_l5_1992219_lrg.jpg")
m2006 <- im.import("matogrosso_ast_2006209_lrg.jpg")

# the classes are 2: forest and agricultural areas
m1992_cluster <- im.classify(m1992, 2)
plot(m1992_cluster)

m2006_cluster <- im.classify(m2006, 2)
plot(m2006_cluster)

# we need to specify the element because we're getting 3 images showing the same thing (need to update imageRy)
par(mfrow=c(1,2))
plot(m1992_cluster[[1]])
plot(m2006_cluster[[1]])

# Let's calculate the frequency of the pixels in a certain class
f1992 <- freq(m1992_cluster)
f1992

# Let's calculate the percentage
tot_1992 <- ncell(m1992_cluster)
tot_1992
percentage_1992 <- f1992 * 100 / tot_1992 
percentage_1992

f2006 <- freq(m2006_cluster)
f2006

tot_2006 <- ncell(m2006_cluster)
tot_2006
percentage_2006 <- f2006 * 100 / tot_2006 
percentage_2006

# Let's build a table with the results
classes <- c('human', 'forest')
y1992 <- c(17, 83)    # percentages for the two classes in that year
y2006 <- c(54, 45)

results <- data.frame(classes, y1992, y2006) 
results

library(ggplot2)
library(patchwork)

# Final bar plot displaying the results
p1 <- ggplot(results, aes(x=classes, y=y1992, color=classes)) + geom_bar(stat="identity", fill="white")
p1
p2 <- ggplot(results, aes(x=classes, y=y2006, color=classes)) + geom_bar(stat="identity", fill="white")
p2

p1 + p2  # problem in showing data like this is that the scale is different

# final output, rescaled
p1 <- ggplot(results, aes(x=classes, y=y1992, color=classes)) + geom_bar(stat="identity", fill="white") + ylim(c(0,100))
p2 <- ggplot(results, aes(x=classes, y=y2006, color=classes)) + geom_bar(stat="identity", fill="white") + ylim(c(0,100))
p1 + p2


# ---------------------------

# 10 Variability
# measuraments of RS based on variability

library(imageRy)
library(terra)
library(viridis)

im.list()

glacier <- im.import("sentinel.png")

# b1=NIR, b2=red, b3=green
im.plotRGB(glacier, r=1, g=2, b=3)
im.plotRGB(glacier, r=2, g=1, b=3)

# varibility (in our case as standard deviation) can be calculated only on one variable
# we can use the NIR as an example
nir <- glacier[[1]]
plot(nir)

# let's use a moving window
# the matrix describes the dimensions of the moving window: composed by 9 pixels (1/9) distributed as 3 by 3
# "fun" call the function
sd_glacier <- focal(nir, matrix(1/9, 3, 3), fun=sd)
plot(sd_glacier)

cl_vir <- colorRampPalette(viridis(7))(255)
plot(sd_glacier, col=cl_vir)

# ---------------------------

# 11 principal component analysis
# choosing the layer to use objectively using pca
# pca compact all the data in one band which best represent all of it

library(imageRy)
library(terra)
library(viridis)

im.list()

sent <- im.import("sentinel.png")

pairs(sent)

# perform PCA on sent
sentpc <- im.pca(sent)
pc1 <- sentpc$PC1

viridisc <- colorRampPalette(viridis(7))(255)
plot(pc1, col=viridisc)

# calculating standard deviation ontop of pc1
pc1sd3 <- focal(pc1, matrix(1/9, 3, 3), fun=sd)
plot(pc1sd3, col=viridisc)

pc1sd7 <- focal(pc1, matrix(1/49, 7, 7), fun=sd)
plot(pc1sd7, col=viridisc)

par(mfrow=c(2,3))
im.plotRGB(sent, 2, 1, 3)
# sd from the variability script:
plot(sd3, col=viridisc)
plot(sd7, col=viridisc)
plot(pc1, col=viridisc)
plot(pc1sd3, col=viridisc)
plot(pc1sd7, col=viridisc)

# stack all the standard deviation layers
sdstack <- c(sd3, sd7, pc1sd3, pc1sd7)
names(sdstack) <- c("sd3", "sd7", "pc1sd3", "pc1sd7")
plot(sdstack, col=viridisc)

# ---------------------------
