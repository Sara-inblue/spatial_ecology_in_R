library(sf)
Programme_BioObs <- read.csv("Programme_BioObs.csv")

Programme_BioObs_spat <- st_as_sf(Programme_BioObs, coords = c("decimalLongitude", "decimalLatitude"),
                          crs = crs(Med_present_SST))
