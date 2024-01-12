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
