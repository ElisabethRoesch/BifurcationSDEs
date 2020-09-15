
using Plots
alphas = Array(range(0, stop = 15, length=9))
x = Array(range(0, stop = 15, length=90))
x2 = Array(range(-15, stop = 0, length=90))

function stable1(al)
    if al > 0
        return sqrt(al)
    end
    return 0
end
function stable2(al)
    if al > 0
        return -sqrt(al)
    end
    return 0
end
function unstable(al)
    return 0
end
bifur_dia = plot(alphas, unstable, axis = nothing,  size(1000, 500), xlabel = "α", ylabel = "X", label = "unstable",legend = :topleft, line = :dash, color ="black", grid = "off", ylim = (-5,5))
plot!(x, stable1, label = "stable", color = "black")
plot!(x, stable2, label = "", color = "black")
plot!(x2, stable2, label = "", color = "black")
savefig("test/plots/workflow/bifur_dia.pdf")
