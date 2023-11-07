# use different bands to create indeces

install.packages("ggplot2")
instal.packages("viridis")

library(imageRy) 
library(terra)
library(ggplot2)
library(viridis)

im.list()

mato_grosso92 <- im.import( "matogrosso_l5_1992219_lrg.jpg" ) # this image has already been processed
# currently the bands are: 1=NIR, 2=red ,3=green

im.plotRGB(mato_grosso92, r=2, g=1, b=3)
# here we re-assigned the bands to the colors

# enhancing the bare soil (yellow catch our eyes more)
im.plotRGB(mato_grosso92, r=2, g=3, b=1)
# the rio peixoto should be black (it's water) but it's actully the same color of the bare soil because of the high amount of sediments

mato_grosso2006 <- im.import("matogrosso_ast_2006209_lrg.jpg")
im.plotRGB(mato_grosso2006, r=2, g=3, b=1)                             
