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
