# R as a calculator
2 + 3

# Assign to an object
zima <- 2 + 3          # in some languages you use = to assign
zima

duccio <- 5 + 3
duccio

zima * duccio

# or

final <- zima * duccio
final

final^2

# Array
sophi <- c(10, 20, 30, 50, 70) # c indicates a function
sophi

paula <- c(100, 500, 600, 1000, 2000)
paula

plot(paula, sophi)

# change the labels in the plot
plot(paula, sophi, xlab="number of people", ylab="microplastics")

#or
people <- paula
microplastics <- sophi

plot(people, microplastics)

# change point symbols in R "point character" pch
plot(people, microplastics, pch=19)

# increase/decrease the dimension of the points "character exaggeration"
plot(people, microplastics, cex=2)

# change the color
plot(people, microplastics, col="blue")  #colors are stored with " "
