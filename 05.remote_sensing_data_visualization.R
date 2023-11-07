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
