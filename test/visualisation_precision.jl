include("../src/includes.jl")


file_path_pot_1 = "test/server_tests/anissa_test/plots1/data/rerun_longer_time_span/rep_output_supercritical_pitchfork_potential_rerun_more_inits.jld"
file_path_pot_2 = "test/server_tests/anissa_test/plots2/data/rerun_longer_time_span/rep_output_supercritical_pitchfork_potential_rerun_more_inits.jld"
file_path_pot_3 = "test/server_tests/anissa_test/plots3/data/rerun_longer_time_span/rep_output_supercritical_pitchfork_potential_rerun_more_inits.jld"
file_path_pot_4 = "test/server_tests/anissa_test/plots4/data/rerun_longer_time_span/rep_output_supercritical_pitchfork_potential_rerun_more_inits.jld"
file_path_pots= [file_path_pot_1, file_path_pot_2, file_path_pot_3, file_path_pot_4]

rep_output_pots = [load_pot(file_path_pots[i]) for i in 1:length(file_path_pots)]

# test_list_alpha, test_list_sigma = Array(range(-15., stop = 15.0, length = 9)), Array(range(-0., stop = 2.0, length = 4))
# test_list_alpha2, test_list_sigma2 = Array(range(-5, stop = 5.0, length = 9)), Array(range(0., stop = 2., length = 4))
# n_bifurs = length(bifur_types)

# test_list_alphas = [test_list_alpha]# , test_list_alpha2, test_list_alpha2]
# test_list_sigmas = [test_list_sigma]#, test_list_sigma2, test_list_sigma2]


# file_path_pots = [get_file_path_pot_rerun(bifur_types[i]) for i in 1:n_bifurs]
# rep_output_pots = [load_pot(file_path_pots[i]) for i in 1:n_bifurs]
# file_path_plots = [get_file_path_plot_pot(bifur_types[i]) for i in 1:n_bifurs]


file_path_plots = ["test/server_tests/anissa_test/visualisation_precision/1.pdf", "test/server_tests/anissa_test/visualisation_precision/2.pdf", "test/server_tests/anissa_test/visualisation_precision/3.pdf", "test/server_tests/anissa_test/visualisation_precision/4.pdf"]

ps = plot_multi_contour_pot(rep_output_pots)

[savefig(plot(ps[i] ... , layout = (1,4), size = (2000,500)), file_path_plots[i]) for i in 1:length(file_path_pots)]


plot(ps[4]..., layout = (1,4), size = (2000,500))
