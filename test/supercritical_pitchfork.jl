include("../src/includes.jl")

test_list_alpha, test_list_sigma = Array(range(-15., stop = 15.0, length = 9)), Array(range(-0., stop = 2.0, length = 4))
tspan = (0.0, 2.0)
initpoints = range(-5., stop = 5.0, length = 10)
test_prob_arg_list = [f_supercritical_pitchfork, g_multiplicative_noise, tspan, initpoints]
@time rep_output = rep_solve(test_prob_arg_list, test_list_alpha, test_list_sigma) #first dim is alpha, second dim is sigma
file_path = "test/data/rep_output_supercritical.jld"
save(file_path, "rep_output", rep_output)

# Or load data:
rep_outputw = load(file_path)["rep_output"]


cols = ["#696969","#920005","#920005","#920005"]
alphas_col = [1.,.4,.6,1.]
ps = plot_rep_solve_2(rep_output, test_list_alpha, test_list_sigma, 1, length(test_list_alpha), 1, 4, cols, alphas_col)
    p_app = plot(ps..., layout = (4,9))
    savefig("test/plots/supercritical_pitchfork_summary_plot_2.pdf")



KS_res = KS_vectors(rep_output)
p = plot_KS_vectors(KS_res, test_list_sigma, test_list_alpha)
p_all =plot(p[1], p[2], layout=(1,2))



H_res = H_vectors(rep_output)
p = plot_H_vectors(H_res, test_list_sigma, test_list_alpha)
p_all =plot(p[1], p[2], layout=(1,2))


Entropy_vectors(rep_output)
E_res = Entropy_vectors(rep_output)
p = plot_E_vectors(E_res, test_list_sigma, test_list_alpha)
p_all =plot(p[1], p[2], layout=(1,2))
