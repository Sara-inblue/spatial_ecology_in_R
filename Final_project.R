library(raster)
library(viridis)

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
SST <- c(present_SST, RCP26_SST, RCP45_SST, RCP60_SST, RCP85_SST)
sal <- c(present_salinity, RCP26_salinity, RCP45_salinity, RCP60_salinity, RCP85_salinity)
current_vel <- c(present_current_vel, RCP26_current_vel, RCP45_current_vel, RCP60_current_vel, RCP85_current_vel)

# highlighting the change of the variables between the present and projected periods
SST_change_RCP26 <- SST[[2]]-SST[[1]]
sal_change_RCP26 <- sal[[2]]-sal[[1]]
current_vel_change_RCP26 <- current_vel[[2]]-current_vel[[1]]

SST_change_RCP45 <- SST[[3]]-SST[[1]]
sal_change_RCP45 <- sal[[3]]-sal[[1]]
current_vel_change_RCP45 <- current_vel[[3]]-current_vel[[1]]

SST_change_RCP60 <- SST[[4]]-SST[[1]]
sal_change_RCP60 <- sal[[4]]-sal[[1]]
current_vel_change_RCP60 <- current_vel[[4]]-current_vel[[1]]

SST_change_RCP85 <- SST[[5]]-SST[[1]]
sal_change_RCP85 <- sal[[5]]-sal[[1]]
current_vel_change_RCP85 <- current_vel[[5]]-current_vel[[1]]

# defining the color palette to use in the plots
cl_vir <- colorRampPalette(viridis(7))(255)

# plotting the changes in the variables
par(mfrow=c(2,2))
plot(SST_change_RCP26, col=cl_vir, main="SST Change - RCP2.6")
plot(SST_change_RCP45, col=cl_vir, main="SST Change - RCP4.5")
plot(SST_change_RCP60, col=cl_vir, main="SST Change - RCP6.0")
plot(SST_change_RCP85, col=cl_vir, main="SST Change - RCP8.5")

par(mfrow=c(2,2))
plot(sal_change_RCP26, col=cl_vir, main="Salinity Change - RCP2.6")
plot(sal_change_RCP45, col=cl_vir, main="Salinity Change - RCP4.5")
plot(sal_change_RCP60, col=cl_vir, main="Salinity Change - RCP6.0")
plot(sal_change_RCP85, col=cl_vir, main="Salinity Change - RCP8.5")

par(mfrow=c(2,2))
plot(current_vel_change_RCP26, col=cl_vir, main="Current velocity Change - RCP2.6")
plot(current_vel_change_RCP45, col=cl_vir, main="Current velocity Change - RCP4.5")
plot(current_vel_change_RCP60, col=cl_vir, main="Current velocity Change - RCP6.0")
plot(current_vel_change_RCP85, col=cl_vir, main="Current velocity Change - RCP8.5")
