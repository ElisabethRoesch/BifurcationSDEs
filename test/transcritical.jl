include("../src/includes.jl")

# Run thiings
test_list_alpha, test_list_sigma = Array(range(-5, stop = 5.0, length = 9)), Array(range(0., stop = 2., length = 4))
tspan = (0.0, 2.0)
initpoints = range(-5., stop = 5., length = 10)
test_prob_arg_list = [f_transcritical, g_multiplicative_noise, tspan, initpoints]
@time rep_output = rep_solve(test_prob_arg_list, test_list_alpha, test_list_sigma) #first dim is alpha, second dim is sigma
file_path = "test/data/rep_output_transcritical.jld"
save(file_path, "rep_output", rep_output)

# Or load data:
rep_outputw = load(file_path)["rep_output"]

# Visualise:
cols = ["#696969","#920005","#920005","#920005"]
alphas_col = [1.,.4,.6,1.]
ps = plot_rep_solve_2(rep_output, test_list_alpha, test_list_sigma, 1, length(test_list_alpha), 1, length(test_list_sigma), cols, alphas_col)
    p_app = plot(ps..., layout = ( length(test_list_sigma),length(test_list_alpha)))
    savefig("test/plots/transcritical_summary_plot_2.pdf")

ps = plot_rep_solve_4(rep_output, test_list_alpha, test_list_sigma, 1,
    length(test_list_alpha), 1, length(test_list_sigma), cols, alphas_col, (-5,5), -100)
    p_app = plot(ps..., layout = ( length(test_list_sigma),length(test_list_alpha)))
    savefig("test/plots/transcritical_summary_plot_3.pdf")
