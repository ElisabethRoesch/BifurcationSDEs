
using Plots
x = Array(range(0, stop = 10, length=90))
x2 = Array(range(-10, stop = 0, length=90))

function stable1(al)
    return sqrt(al)
end

function unstable1(al)
    return -sqrt(al)
end
bifur_dia = plot(x1, stable1, label = "", color = "black",xlim = (-10,10), ylim = (-5,5), grid = "off", axis = nothing)
    plot!(x1, unstable1, line = :dash ,label = "", color = "black" )
    scatter!([0],[0],color = "black", label = "")

    plot!([-5, -5], [4, -4], arrow = true, color = :black,   label = "")

    plot!([0, 0], [4, 1], arrow = true, color = :black,   label = "")
    plot!([0, 0], [-1, -4], arrow = true, color = :black,   label = "")

    plot!([5, 5], [4, 3], arrow = true, color = :black,   label = "")
    plot!([5, 5], [-3, -4], arrow = true, color = :black,   label = "")

    plot!([5, 5], [-1.5, 1.5], arrow = true, color = :black,   label = "")
    plot!(size=(300,200))
savefig("test/plots/workflow/bifur_dia_saddle.pdf")
