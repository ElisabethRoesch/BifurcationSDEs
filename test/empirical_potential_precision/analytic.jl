using Plots, JLD



# function stable1(al)
#     if al > 0
#         return sqrt(al)
#     end
#     return 0
# end
# function stable2(al)
#     if al > 0
#         return -sqrt(al)
#     end
#     return 0
# end
# function unstable(al)
#     return 0
# end
alphas = Array(range(-15, stop = 15, length=9))
# x = Array(range(-15, stop = 15, length=90))
# bifur_dia = plot(alphas, unstable, axis = nothing, label = "unstable", line = :dash, color ="black", grid = "off")
# plot!(x,stable1,  xlabel = "α", ylabel = "X",legend = :topleft, label ="stable" ,color ="black")
# plot!(x,stable2, legend = :topleft, label ="" ,color ="black", ylim = (-5,5))


function f(alpha, n)
    return -(alpha/2)n^2+(1/4)n^4
end
ns = Array(range(-5, stop = 5, length =10))
cc = cgrad(["#32343e", "#446b6a", "#5ba95d"], [0.1, 0.3, 0.8])
analytic = contourf(alphas, ns, f, xlab = "α", ylab = "X", ylim = (-5,5), color = cc, grid = "off")



file_path = "test/server_tests/anissa_test/plots1/data/rerun_longer_time_span/rep_output_supercritical_pitchfork_potential_rerun_more_inits.jld"
pot = load(file_path)["rep_output_potential"]
det = pot[:,1]
function plot_contour_pot(pot) # r_pitch_det
    a_l = length(pot)
    b_l = length(pot[1])
    as=1:a_l
    bs=1:b_l
    function f(a, b)
        return pot[a][b]
    end
    cc = cgrad(["#32343e", "#446b6a", "#5ba95d"], [0.1, 0.3, 0.8])
    cf_pot = contourf(as, bs, f, xlabel = "α", levels = 100, color = cc, ylabel = "X", grid = "off")
    # aaa = hcat(det...)'
    # cf_pot = contourf(aaa, levels = 30)
    # heatmap(aaa)
    return cf_pot
end
empirical = plot_contour_pot(det)

ps = plot(bifur_dia, analytic, empirical, layout = (1, 3), size = (1500, 500))


#savefig("test/plots/pot_vs_quasi.pdf")
using GR, JLD
z = peaks(200)
contourf(z)
heatmap(z)
