len = 10
a = Array(range(-2, stop = 2, length = len))
b = Array(range(-2, stop = 2, length = 11))

using Plots

p1 = scatter(1:10,a, title = "10 IC", label = "")
p2 = scatter(1:11,b, title = "11 IC", label = "")

plot(p1, p2)

histogram(a, bins=10)
histogram(b, bins=11)
