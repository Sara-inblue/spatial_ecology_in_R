library(raster)

# set working directory
setwd("C:/Users/sarar/Downloads")

# import data
# "present" data refer to the period 2000-2014
present_SST <- temp <- raster("Present_Surface_Temperature_Mean.tif")
present_salinity <- raster("Present_Surface_Salinity_Mean.tif")
present_current_vel <- raster("Present_Surface_Current_Velocity_Mean.tif")

# projected data for the period 2040-2050 using the representative concentration pathway scenarios (RCP) formulated by the IPCC
RCP26_SST <- temp <- raster("2050_RCP26_Surface_Temperature_Mean.tif")
RCP26_salinity <- raster("2050_RCP26_Surface_Salinity_Mean.tif")
RCP26_current_vel <- raster("2050_RCP26_Surface_Current_Velocity_Mean.tif")

RCP45_SST <- temp <- raster("2050_RCP45_Surface_Temperature_Mean.tif")
RCP45_salinity <- raster("2050_RCP45_Surface_Salinity_Mean.tif")
RCP45_current_vel <- raster("2050_RCP45_Surface_Current_Velocity_Mean.tif")

RCP60_SST <- temp <- raster("2050_RCP60_Surface_Temperature_Mean.tif")
RCP60_salinity <- raster("2050_RCP60_Surface_Salinity_Mean.tif")
RCP60_current_vel <- raster("2050_RCP60_Surface_Current_Velocity_Mean.tif")

RCP85_SST <- temp <- raster("2050_RCP85_Surface_Temperature_Mean.tif")
RCP85_salinity <- raster("2050_RCP85_Surface_Salinity_Mean.tif")
RCP85_current_vel <- raster("2050_RCP85_Surface_Current_Velocity_Mean.tif")

# create a stack for each variable containing the present and projected data
# layer 1 = present
# layer 2 = RCP26
# layer 3 = RCP45
# layer 4 = RCP60
# layer 5 = RCP85
temp <- c(present_SST, RCP26_SST, RCP45_SST, RCP60_SST, RCP85_SST)
sal <- c(present_salinity, RCP26_salinity, RCP45_salinity, RCP60_salinity, RCP85_salinity)
current_vel <- c(present_current_vel, RCP26_current_vel, RCP45_current_vel, RCP60_current_vel, RCP85_current_vel)

