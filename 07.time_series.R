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


