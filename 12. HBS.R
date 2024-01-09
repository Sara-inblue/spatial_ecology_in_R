# Case study on harmuful algal blooms in Lake Garda focusing on cyanobacteria

install.packages("tidyverse")
install.packages("raster")
install.packages("waterquality")
install.packages("sen2r")
install.packages("sf")
install.packages("gdalUtils")
install.packages("magrittr")
install.packages("rgdal")
install.packages("caret")

library(tidyverse)
library(raster)
library(waterquality)
library(sen2r)
library(sf)
library(gdalUtils) #no such package for version of R I'm using
library(magrittr)
library(rgdal)
library(caret)

# set working directory
setwd("C:/Users/sarar/Downloads")

sen2cor("C:/Users/sarar/Downloads/S2B_MSIL2A_20220824T101559_N0400_R065_T32TPR_20220824T122701.SAFE")

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



