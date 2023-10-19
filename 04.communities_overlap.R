# species correlate also in time
# sampling animals through camera traps

install.packages("overlap")
library(overlap)

# data from a national park in Indonisia "Kerinci"
data(kerinci)
summary(kerinci)   # info about the dataset

head(kerinci)

# the first 6 rows (header) refer to the tiger
# The unit of time is the day, so values range from 0 to 1. 
# The package overlap works entirely in radians: fitting density curves uses trigonometric functions (sin, cos, tan),
# so this speeds up simulations. The conversion is straightforward: kerinci$Time * 2 * pi

# We add a new column to the dataset containing our new variable
kerinci$timeRad <- kerinci$Time * 2 * pi         # we need to pass from linear to circular time because of the manner the package is working
head(kerinci)

# sequel or sql
# [] is selecting elements inside the dataset

# sps is the column indicating the species
tiger <- kerinci[kerinci$Sps == "tiger",]   # the come is needed to close the query

plot(tiger$timeRad)

# or

timetig <- tiger$timeRad

# plot the density of the kernel
densityPlot(timetig, rug=TRUE)    # rug is needed to smooth the lines

# select only data for macaque
maca <- kerinci[kerinci$Sps == "macaque",]
timemac <- maca$timeRad

# overlap between the species
overlapPlot(timetig, timemac)

# adding a legend
legend('topright', c("Tigers", "Macaques"), lty=c(1,2), col=c("black","blue"), bty='n')
