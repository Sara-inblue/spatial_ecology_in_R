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
winnipeg <- rast("lakewinnipeg_oli2_2023268_lrg.jpg")

plotRGB(winnipeg, r=1, g=2, b=3)

w_clusters <- im.classify(winnipeg, num_clusters=3)
plot(w_clusters)

----------------------

setwd("C:/Users/sarar/Downloads")
file_path <- "B_europea_14.csv"
B_europea_14 <- read.csv(file_path)

lon <- B_europea_14[1]
lat <- B_europea_14[2]
plot(lon, lat)

B_europea_cromis <- read.csv("Programme_CROMIS.csv")

# Install and load the ggplot2 package
install.packages("ggplot2")
library(ggplot2)

# Replace "your_data.csv" with the actual file path
file_path <- "B_europea_14.csv"

# Read the CSV file into a data frame
data <- read.csv(file_path)

# Create a scatter plot with longitudes and latitudes
ggplot(data, aes(x = Longitude, y = Latitude)) +
  geom_point() +
  labs(title = "Scatter Plot of Longitudes and Latitudes",
       x = "Longitude",
       y = "Latitude")
