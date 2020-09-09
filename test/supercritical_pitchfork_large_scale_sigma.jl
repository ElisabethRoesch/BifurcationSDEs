include("../src/includes.jl")

bifur_type = "supercritical_pitchfork"
file_path_raw = string("test/data/large_scale_sigma/rep_output_", bifur_type, "_raw.jld")
file_path_potential = string("test/data/large_scale_sigma/rep_output_", bifur_type, "_potential.jld")
test_list_alpha, test_list_sigma = [0.], Array(range(0., stop = 7.5, length = 20))


# Next lines only for rerun.
tspan = (0.0, 2.0)
timepoints = 0.2:0.2:2.0
initpoints = range(-5., stop = 5.0, length = 10)
npoints = 20
test_prob_arg_list = [f_supercritical_pitchfork, g_multiplicative_noise, tspan, initpoints, timepoints, npoints]
@time rep_output_raw, rep_output_potential = rep_solve(test_prob_arg_list, test_list_alpha, test_list_sigma) #first dim is alpha, second dim is sigma
save(file_path_raw, "rep_output_raw", rep_output_raw)
save(file_path_potential, "rep_output_potential", rep_output_potential)

# Or load data:
rep_output_raw = load(file_path_raw)["rep_output_raw"]
rep_output_potential = load(file_path_potential)["rep_output_potential"]

cols = ["#696969", "#920005", "#920005", "#920005"]
alphas_col = [1.,.4,.6,1.]
ps_potential = plot_potentials(rep_output_potential, test_list_alpha, test_list_sigma, 1, length(test_list_alpha), 1, 4, cols, alphas_col)
    p_app = plot(ps_potential..., layout = (length(test_list_sigma),length(test_list_alpha)))
    savefig(string("test/plots/large_scale_sigma/", bifur_type, "_summary_plot_2_potential.pdf"))
ps_raw = plot_raw_data(rep_output_raw, test_list_alpha, test_list_sigma, 1, length(test_list_alpha), 1, 4, cols, alphas_col)
    p_app = plot(ps_raw..., layout = (length(test_list_sigma),length(test_list_alpha)))
    savefig(string("test/plots/large_scale_sigma/", bifur_type, "_summary_plot_2_raw.pdf"))

KS_res = KS_vectors(rep_output_raw)
KS_res_p = KS_vectors(rep_output_potential)
H_res = H_vectors(rep_output_raw)
H_res_p = H_vectors(rep_output_potential)
E_res = Entropy_vectors(rep_output_raw)
E_res_p = Entropy_vectors(rep_output_potential)
P_res = pairwise_ent(rep_output_raw)
P_res_p = pairwise_ent(rep_output_potential)
sum_stats = [KS_res, KS_res_p, H_res, H_res_p, E_res, E_res_p, P_res, P_res_p]
labels = ["KS to det (raw)", "KS to det (potential)", "Hellinger to det (raw)", "Hellinger to det (potential)", "Entropy (raw)", "Entropy (potential)", "Entropy to det (raw)", "Entropy to det (potential)"]

ps_test = plot_large_scale(E_res, test_list_alpha, test_list_sigma)
    p = plot(ps_test)
    savefig(string("test/plots/large_scale_sigma/", bifur_type, "_entropy_single_data_summ_stat_plot.pdf"))
inds_raw = [1,3,5,7]
inds_pot = [2,4,6,8]

ps_raw = plot_large_scale_all_sum_stats(sum_stats[inds_raw], test_list_alpha, test_list_sigma, labels[inds_raw])
    ps_pot = plot_large_scale_all_sum_stats(sum_stats[inds_pot], test_list_alpha, test_list_sigma, labels[inds_pot])
    p = plot(ps_raw, ps_pot, layout = (2,1))
    savefig(string("test/plots/large_scale_sigma/", bifur_type, "_all_data_summ_stat_plot_raw_pot.pdf"))
