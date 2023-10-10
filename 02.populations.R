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
