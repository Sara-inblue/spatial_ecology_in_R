# species prefer to go for partition (divion of resources) instead of competition

install.packages("vegan)
libray(vegan)

# going into the field we take 3 samples and count the number of individuals for 3 different species 
# we use the number of individuals to plot the species on a graph

# since we cannot create plots with more than 3-d (our mind cannot conceive it) we use multivariate analysis (principal component analysis)
# maybe in one of the dimensions we cannot see some variables that we see as separate are connected

# the 2^ principal component is, by definition, perperndicular to the 1^ one (direction with the largest range of varibility)
# the 1^ PC is always explaing the highest veribility, thus the one explained by the 2^ one is always smaller

install.packages("overlap")
library(overlap)
