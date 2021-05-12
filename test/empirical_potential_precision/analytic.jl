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
savefig("test/plots/pot_analytic.pdf")

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
    cf_pot = contourf(as, bs, f, xlabel = "α", levels = 10, color = cc, ylabel = "X", grid = "off")
    # aaa = hcat(det...)'
    # cf_pot = contourf(aaa, levels = 30)
    # heatmap(aaa)
    return cf_pot
end
empirical = plot_contour_pot(det)
savefig("test/plots/quasi_pot_emp.pdf")
ps = plot(bifur_dia, analytic, empirical, layout = (1, 3), size = (1500, 500))


#savefig("test/plots/pot_vs_quasi.pdf")
using GR, JLD
z = peaks(200)
contourf(z)
heatmap(z)


ns = Array(range(-5, stop = 5, length =100))
neg = -3.75
zer = 0.
pos = 3.75

pot_neg_a = [f(neg,n) for n in ns]
pot_zer_a = [f(zer,n) for n in ns]
pot_pos_a = [f(pos,n) for n in ns]

# For paper figure: plot slices:
plot( ns, pot_neg_a, label = "", grid = "off", color = "#0e6b0e", ylim = (-10,110))
savefig("test/empirical_potential_precision/p_neg.pdf")
plot( ns, pot_zer_a, label = "", grid = "off", color = "#0e6b0e", ylim = (-10,110))
savefig("test/empirical_potential_precision/p_zero.pdf")
plot( ns, pot_pos_a, label = "", grid = "off", color = "#0e6b0e", ylim = (-10,110))
savefig("test/empirical_potential_precision/p_pos.pdf")




a_l = length(det)
b_l = length(det[1])
as=1:a_l
bs=1:b_l
function f2(a, b)
    return pot[a][b]
end


ind_neg = Int(round((15-3.75)/30*a_l))
ind_zer = Int(a_l/2)
ind_pos = a_l-ind_neg


ind_list = 1:b_l
q_neg_a = [f2(ind_neg,n) for n in ind_list]
q_zer_a = [f2(ind_zer,n) for n in ind_list]
q_pos_a = [f2(ind_pos,n) for n in ind_list]

# For paper figure: plot slices:
plot( ind_list, q_neg_a, label = "", grid = "off", color = "#0e6b0e", ylim = (-2.5,0))
savefig("test/empirical_potential_precision/q_neg.pdf")

plot( ind_list, q_zer_a, label = "", grid = "off", color = "#0e6b0e", ylim = (-2.5,0))
savefig("test/empirical_potential_precision/q_zer.pdf")

plot( ind_list, q_pos_a, label = "", grid = "off", color = "#0e6b0e", ylim = (-2.5,0))
savefig("test/empirical_potential_precision/q_pos.pdf")
