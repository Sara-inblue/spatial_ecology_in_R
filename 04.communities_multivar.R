# species prefer to go for partition (divion of resources) instead of competition

# going into the field we take 3 samples and count the number of individuals for 3 different species 
# we use the number of individuals to plot the species on a graph

# since we cannot create plots with more than 3-d (our mind cannot conceive it) we use multivariate analysis (principal component analysis)
# maybe in one of the dimensions we cannot see some variables that we see as separate are connected

# the 2^ principal component is, by definition, perperndicular to the 1^ one (direction with the largest range of varibility)
# the 1^ PC is always explaing the highest veribility, thus the one explained by the 2^ one is always smaller

install.packages("vegan")   # vegetation analysis
library(vegan)

data(dune)   # matrix that contains the number of individuals for different species
dune

head(dune)  # it shows the first 6 rows of the dataset
tail(dune)  # it shows you the last 3 rows of the dataset

# decorana: detrended correspondence (how different species are correspondent with other) analysis
ord <- decorana(dune)
ord

# we are interested in the lenght of the 1^ axes (indicates the range)
ldc1 <- 3.7004   # yo could also use = because they are actually equivalent
ldc2 <- 3.1166
ldc3 <- 1.30055
ldc4 <- 1.47888

total = ldc1 + ldc2 + ldc3 + ldc4

plcd1 = ldc1 * 100 / total
plcd2 = ldc2 * 100 / total
plcd3 = ldc3 * 100 / total
plcd4 = ldc4 * 100 / total

plcd1
plcd2

plcd1 + plcd2    # they alone are retaining around 70% of variabilty

# final multivariate space showing the correlation in space
# it allows you to describe different environments in you dataset
plot(ord)


# species correlate also in time
# sampling animals through camera traps

install.packages("overlap")
library(overlap)

