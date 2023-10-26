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

# import the different data we're going to use
# b2 refers to band 2 (blue)
b2 <- im.import("sentinel.dolomites.b2.tif")
b2

# b3 is green and b4 is red

# Let's change the color
cl <- colorRampPalette(c("dark gray", "gray", "light gray")) (100)
plot(b2, col = cl)

b3 <- im.import("sentinel.dolomites.b3.tif")
plot(b3, col = cl)
