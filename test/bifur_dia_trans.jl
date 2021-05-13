
using Plots
x1 = Array(range(0, stop = 10, length=80))
x2 = Array(range(-10, stop = 0, length=80))

function stable1(al)
    return 0
end
function stable2(al)
    return al
end
function unstable1(al)
    return al
end
function unstable2(al)
    return 0
end
bifur_dia = plot(x2, stable1, label = "", color = "black" )
    plot!(x2, unstable1, line = :dash ,label = "", color = "black" )
    plot!(x1, stable2, label = "", color = "black" )
    plot!(x1, unstable2,line = :dash , label = "", color = "black" , ylim = (-10,10), axis = nothing)
    scatter!([0],[0], color = "black", label = "")

    plot!([-5, -5], [8, 2], arrow = true, color = :black,   label = "")
    plot!([-5, -5], [-6, -8], arrow = true, color = :black,   label = "")
    plot!([-5, -5], [-4, -2], arrow = true, color = :black,   label = "")

    plot!([0, 0], [8, 2], arrow = true, color = :black,   label = "")
    plot!([0, 0], [-2, -8], arrow = true, color = :black,   label = "")

    plot!([5, 5], [8, 6], arrow = true, color = :black,   label = "")

    plot!([5, 5], [2, 4], arrow = true, color = :black,   label = "")
    plot!([5, 5], [-2,-8], arrow = true, color = :black,   label = "", size(100, 50))
    plot!(size=(300,200))
savefig("test/plots/workflow/bifur_dia_trans.pdf")
