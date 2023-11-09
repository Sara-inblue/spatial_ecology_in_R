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
