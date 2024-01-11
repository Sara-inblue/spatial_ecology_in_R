# Simulationg color blind vision

library(devtools)    # package to instal packages from GitHub
devtools::install_github("clauswilke/colorblindr")
library(colorblindr)

library(ggplot2)

iris
head(iris)   # allows you to see just the first lines

fig <- ggplot(iris, aes(Sepal.Length, fill = Species)) + geom_density(alpha = 0.7)
fig
