
using Plots
x1 = Array(range(0, stop = 10, length=90))
x2 = Array(range(-10, stop = 0, length=90))

function stable1(al)
    return sqrt(al)
end
function stable2(al)
    return -sqrt(al)
end
function stable3(al)
    return 0
end
function unstable(al)
    return 0
end
bifur_dia = plot(x1, stable1, label = "", color = "black",axis = nothing,  ylim = (-5,5), grid = "off")
    plot!(x1, stable2, label = "", color = "black" )
    plot!(x2, stable3, label = "", color = "black" )
    plot!(x1, unstable, label = "", color = "black", line = :dash  )


    plot!([-5, -5], [4, 1], arrow = true, color = :black,   label = "")
    plot!([-5, -5], [-4, -1], arrow = true, color = :black,   label = "")

    plot!([0, 0], [4, 1], arrow = true, color = :black,   label = "")
    plot!([0, 0], [-4, -1], arrow = true, color = :black,   label = "")

    plot!([5, 5], [4, 3.3], arrow = true, color = :black,   label = "")
    plot!([5, 5], [-4, -3.3], arrow = true, color = :black,   label = "")

    plot!([5, 5], [1, 2], arrow = true, color = :black,   label = "")
    plot!([5, 5], [-1,-2], arrow = true, color = :black,   label = "")
    plot!(size=(300,200))
savefig("test/plots/workflow/bifur_dia_super.pdf")
