include("../src/includes.jl")

bifur_type = "saddle_node"
test_list_alpha, test_list_sigma = Array(range(-5, stop = 5.0, length = 9)), Array(range(0., stop = 2.0, length = 4))
tspan = (0.0, 2.0)
timepoints = 0.2:0.2:2.0
initpoints = range(-5., stop = 5, length = 10)
npoints = 20
test_prob_arg_list = [f_saddle_node, g_multiplicative_noise, tspan, initpoints, timepoints, npoints]
# @time rep_output_raw, rep_output_potential = rep_solve(test_prob_arg_list, test_list_alpha, test_list_sigma) #first dim is alpha, second dim is sigma
file_path_raw = string("test/data/rep_output_", bifur_type, "_raw.jld")
file_path_potential = string("test/data/rep_output_", bifur_type, "_potential.jld")
# save(file_path_raw, "rep_output_raw", rep_output_raw)
# save(file_path_potential, "rep_output_potential", rep_output_potential)

rep_output_raw = load(file_path_raw)["rep_output_raw"]
rep_output_potential = load(file_path_potential)["rep_output_potential"]

cols = ["#696969", "#920005", "#920005", "#920005"]
alphas_col = [1.,.4,.6,1.]

E_res = Entropy_vectors(rep_output_raw)
ps_test = plot_summary_stat(E_res, test_list_alpha, test_list_sigma, cols, alphas_col, 1.)
    p_all = plot(ps_test... , layout = (4, 1))
    savefig(string("test/plots/", bifur_type, "_entropy_single_data_summ_stat_plot_test.pdf"))



# This does not work because of unstable regions. see plot_potential_unstable instead.
ps_potential = plot_potentials(rep_output_potential, test_list_alpha, test_list_sigma, 1, length(test_list_alpha), 1, 4, cols, alphas_col)
    p_app = plot(ps_potential..., layout = (length(test_list_sigma),length(test_list_alpha)))
    savefig(string("test/plots/", bifur_type, "_summary_plot_2_potential.pdf"))

ps = plot_raw_data(rep_output_raw, test_list_alpha, test_list_sigma, 1, length(test_list_alpha), 1, length(test_list_sigma), cols, alphas_col)
    p_app = plot(ps..., layout = ( length(test_list_sigma),length(test_list_alpha)))
    savefig(string("test/plots/", bifur_type, "_summary_plot_2_raw.pdf"))

ps = plot_potential_unstable(rep_output_raw, test_list_alpha, test_list_sigma, 1,
    length(test_list_alpha), 1, length(test_list_sigma), cols, alphas_col, (-5,5), -100)
    p_app = plot(ps..., layout = ( length(test_list_sigma), length(test_list_alpha)))
    savefig(string("test/plots/", bifur_type, "_summary_plot_unstable.pdf"))

KS_res = KS_vectors(rep_output_raw)
p = plot_KS_vectors(KS_res, test_list_sigma, test_list_alpha)
p_all =plot(p[1], p[2], layout=(1,2))
savefig(string("test/plots/", bifur_type, "_KS_raw_data.pdf"))
KS_res = KS_vectors(rep_output_potential)
p = plot_KS_vectors(KS_res, test_list_sigma, test_list_alpha)
p_all =plot(p[1], p[2], layout=(1,2))
savefig(string("test/plots/", bifur_type, "_KS_potential_data.pdf"))

# This doesn't work (throws exception as arrays of diff lengths bc of instability.)
H_res = H_vectors(rep_output_raw)
p = plot_H_vectors(H_res, test_list_sigma, test_list_alpha)
p_all = plot(p[1], p[2], layout = (1,2))
savefig(string("test/plots/", bifur_type, "_hell_raw_data.pdf"))

H_res = H_vectors(rep_output_potential)
p = plot_H_vectors(H_res, test_list_sigma, test_list_alpha)
p_all = plot(p[1], p[2], layout = (1,2))
savefig(string("test/plots/", bifur_type, "_hell_potential_data.pdf"))
