include("../src/includes.jl")

bifur_types = ["supercritical_pitchfork_potential_rerun_more_sdes_longer_time_span"]
#bifur_types = ["supercritical_pitchfork_potential_rerun_more_sdes"]
#bifur_types = ["supercritical_pitchfork_potential_rerun_longer_timespan"]

test_list_alpha, test_list_sigma = Array(range(-15., stop = 15.0, length = 9)), Array(range(-0., stop = 2.0, length = 4))
test_list_alpha2, test_list_sigma2 = Array(range(-5, stop = 5.0, length = 9)), Array(range(0., stop = 2., length = 4))
n_bifurs = length(bifur_types)

test_list_alphas = [test_list_alpha]# , test_list_alpha2, test_list_alpha2]
test_list_sigmas = [test_list_sigma]#, test_list_sigma2, test_list_sigma2]


file_path_pots = [get_file_path_pot_rerun(bifur_types[i]) for i in 1:n_bifurs]
rep_output_pots = [load_pot(file_path_pots[i]) for i in 1:n_bifurs]
file_path_plots = [get_file_path_plot_pot(bifur_types[i]) for i in 1:n_bifurs]




ps = plot_multi_contour_pot(rep_output_pots)

#[savefig(plot(ps[i] ... , layout = (1,4), size = (2000,500)), file_path_plots[i]) for i in 1:n_bifurs]


plot(ps[1]..., layout = (1,4), size = (2000,500))
