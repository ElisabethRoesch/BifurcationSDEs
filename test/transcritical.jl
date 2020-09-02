include("../src/bifurcations.jl")
include("../src/distances.jl")
include("../src/noise.jl")
include("../src/noise_analysis.jl")
include("../src/noise_visualise.jl")
using DifferentialEquations, KernelDensity, Plots, StatsBase, Distances
# for testing solve_prob_alpha_sigma
# test_p = [-0.6, 0.1]
# for testing rep_solve
test_list_alpha, test_list_sigma = Array(range(0, stop = 10.0, length = 9)), Array(range(0., stop = 2.0, length = 4))
tspan = (0.0, 2.0)
initpoints = range(0., stop = 5., length = 10)
test_prob_arg_list = [f_transcritical, g_multiplicative_noise, tspan, initpoints]
@time rep_output = rep_solve(test_prob_arg_list, test_list_alpha, test_list_sigma) #first dim is alpha, second dim is sigma


cols = ["#696969","#920005","#920005","#920005"]
alphas_col = [1.,.4,.6,1.]
ps = plot_rep_solve_2(rep_output, test_list_alpha, test_list_sigma, 1, length(test_list_alpha), 1, length(test_list_sigma), cols, alphas_col)
    p_app = plot(ps..., layout = ( length(test_list_sigma),length(test_list_alpha)))
    savefig("test/plots/transcritical_summary_plot_2.pdf")
