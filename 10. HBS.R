# Case study on harmuful algal blooms in Lake Garda focusing on cyanobacteria

install.packages("sen2r")

library(ncdf4)
library(terra)
library(sen2r)

# set working directory
setwd("C:/Users/sarar/Downloads")

# load data
Lake_Garda_0711 <- rast("c_gls_LWQ100_202208110000_GLOBAL_MSI_V1.5.nc")
plot(Lake_Garda_0711)

Lake_Garda_0721 <- rast("c_gls_LWQ100_202208110000_GLOBAL_MSI_V1.5.nc")
plot(Lake_Garda_021)

Lake_Garda_0801 <- rast("c_gls_LWQ100_202208010000_GLOBAL_MSI_V1.5.nc")
plot(Lake_Garda_0801)

Lake_Garda_0811 <- rast("c_gls_LWQ100_202208110000_GLOBAL_MSI_V1.5.nc")
plot(Lake_Garda_0811)

# converting satellite imagery inti Bottom-Of-Atmosphere (BoA) reflectance using
Lake_Garda_0711_BoA <- sen2r(Lake_Garda_0711.SAFE)



