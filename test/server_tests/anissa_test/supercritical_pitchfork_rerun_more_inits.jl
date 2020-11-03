include("../src/includes.jl")

bifur_type = "supercritical_pitchfork"
file_path_raw = string("test/data/rerun_longer_time_span/rep_output_", bifur_type, "_raw_rerun_more_inits.jld")
file_path_potential = string("test/data/rerun_longer_time_span/rep_output_", bifur_type, "_potential_rerun_more_inits.jld")
test_list_alpha, test_list_sigma = Array(range(-15., stop = 15.0, length = 9)), Array(range(-0., stop = 2.0, length = 4))


# Next lines only for rerun.
tspan = (0.0, 20.0)
timepoints = 2.:2.:20.0
initpoints = range(-5., stop = 5.0, length = 100)
npoints = 200
test_prob_arg_list = [f_supercritical_pitchfork, g_multiplicative_noise, tspan, initpoints, timepoints, npoints]
@time rep_output_raw, rep_output_potential = rep_solve(test_prob_arg_list, test_list_alpha, test_list_sigma) #first dim is alpha, second dim is sigma
save(file_path_raw, "rep_output_raw", rep_output_raw)
save(file_path_potential, "rep_output_potential", rep_output_potential)

# Or load data:
rep_output_raw = load(file_path_raw)["rep_output_raw"]
rep_output_potential = load(file_path_potential)["rep_output_potential"]
cols = ["#696969", "#920005", "#920005", "#920005"]
alphas_col = [1., .4, .6, 1.]

ps_potential = plot_potentials(rep_output_potential, test_list_alpha, test_list_sigma, 1, length(test_list_alpha), 1, 4, cols, alphas_col)
    p_app = plot(ps_potential..., layout = (length(test_list_sigma), length(test_list_alpha)))
    savefig(string("test/server_tests/anissa_test/plots/", bifur_type, "_summary_plot_2_potential_rerun_more_sdes.pdf"))

ps_raw = plot_raw_data(rep_output_raw, test_list_alpha, test_list_sigma, 1, length(test_list_alpha), 1, 4, cols, alphas_col)
    p_app = plot(ps_raw..., layout = (length(test_list_sigma), length(test_list_alpha)))
    savefig(string("test/server_tests/anissa_test/plots/", bifur_type, "_summary_plot_2_raw_rerun_more_sdes.pdf"))

KS_res = KS_vectors(rep_output_raw)
p = plot_KS_vectors(KS_res, test_list_sigma, test_list_alpha)
    p_all =plot(p[1], p[2], layout = (1, 2))
    savefig(string("test/server_tests/anissa_test/plots/", bifur_type, "_KS_raw_data_rerun_more_sdes.pdf"))
KS_res = KS_vectors(rep_output_potential)
p = plot_KS_vectors(KS_res, test_list_sigma, test_list_alpha)
    p_all = plot(p[1], p[2], layout = (1, 2))
    savefig(string("test/server_tests/anissa_test/plots/", bifur_type, "_KS_potential_data_rerun_more_sdes.pdf"))

H_res = H_vectors(rep_output_raw)
p = plot_H_vectors(H_res, test_list_sigma, test_list_alpha)
    p_all = plot(p[1], p[2], layout = (1, 2))
    savefig(string("test/server_tests/anissa_test/plots/", bifur_type, "_hell_raw_data_rerun_more_sdes.pdf"))

H_res = H_vectors(rep_output_potential)
p = plot_H_vectors(H_res, test_list_sigma, test_list_alpha)
    p_all = plot(p[1], p[2], layout = (1, 2))
    savefig(string("test/server_tests/anissa_test/plots/", bifur_type, "_hell_potential_data_rerun_more_sdes.pdf"))



E_res = Entropy_vectors(rep_output_raw)
p = plot_E_vectors(E_res, test_list_sigma, test_list_alpha)
    p_all = plot(p[1], p[2], layout = (1, 2))
    savefig(string("test/server_tests/anissa_test/plots/", bifur_type, "_entropy_single_raw_data_rerun_more_sdes.pdf"))


P_res = pairwise_ent(rep_output_raw)
p = plot_P_vectors(P_res, test_list_sigma, test_list_alpha)
    p_all = plot(p[1], p[2], layout = (1, 2))
    savefig(string("test/server_tests/anissa_test/plots/", bifur_type, "_entropy_pairwise_raw_data_rerun_more_sdes.pdf"))


ps_test = plot_summary_stat(E_res, test_list_alpha, test_list_sigma, cols, alphas_col)
    p_all = plot(ps_test... , layout = (4, 1))
    savefig(string("test/server_tests/anissa_test/plots/", bifur_type, "_entropy_single_data_summ_stat_plot_rerun_more_sdes.pdf"))


p_contour = plot_contour(rep_output_raw)
