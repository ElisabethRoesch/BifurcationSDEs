include("../src/bifurcations.jl")
include("../src/distances.jl")
include("../src/noise.jl")
include("../src/noise_analysis.jl")
include("../src/noise_visualise.jl")
using DifferentialEquations, KernelDensity, Plots, StatsBase, Distances
# for testing solve_prob_alpha_sigma
# test_p = [-0.6, 0.1]
# for testing rep_solve
test_list_alpha, test_list_sigma = Array(range(-15., stop = 15.0, length = 9)), Array(range(-0., stop = 2.0, length = 4))
tspan = (0.0, 2.0)
initpoints = range(-5., stop = 5.0, length = 10)
test_prob_arg_list = [f_supercritical_pitchfork, g_multiplicative_noise, tspan, initpoints]
@time rep_output = rep_solve(test_prob_arg_list, test_list_alpha, test_list_sigma) #first dim is alpha, second dim is sigma



p1 = plot_rep_solve(rep_output, test_list_alpha, test_list_sigma, 5, length(test_list_alpha), 1, 1, :Dark2_5)
p2 = plot_rep_solve(rep_output, test_list_alpha, test_list_sigma, 1, 5, 1, 1, :Dark2_5)
p3 = plot_rep_solve(rep_output, test_list_alpha, test_list_sigma, 5, length(test_list_alpha), 2, 2, :Dark2_5)
p4 = plot_rep_solve(rep_output, test_list_alpha, test_list_sigma, 1, 5, 2, 2, :Dark2_5)
p5 = plot_rep_solve(rep_output, test_list_alpha, test_list_sigma, 5, length(test_list_alpha), 3, 3, :Dark2_5)
p6 = plot_rep_solve(rep_output, test_list_alpha, test_list_sigma, 1, 5, 3, 3, :Dark2_5)
p7 = plot_rep_solve(rep_output, test_list_alpha, test_list_sigma, 5, length(test_list_alpha), 4, 4, :Dark2_5)
p8 = plot_rep_solve(rep_output, test_list_alpha, test_list_sigma, 1, 5, 4, 4, :Dark2_5)
p_app = plot(p2, p1, p4, p3, p6, p5, p8, p7, layout = (4, 2))
savefig("test/plots/summary_plot.pdf")


cols = ["#696969","#920005","#920005","#920005"]
alphas_col = [1.,.4,.6,1.]
ps = plot_rep_solve_2(rep_output, test_list_alpha, test_list_sigma, 1, length(test_list_alpha), 1, 4, cols, alphas_col)
    p_app = plot(ps..., layout = (4,9))
    savefig("test/plots/summary_plot_2.pdf")





KS_res = KS_vectors(rep_output)
p = plot_KS_vectors(KS_res, test_list_sigma, test_list_alpha)
p_all =plot(p[1], p[2], layout=(1,2))



H_res = H_vectors(rep_output)
p = plot_H_vectors(H_res, test_list_sigma, test_list_alpha)
p_all =plot(p[1], p[2], layout=(1,2))
