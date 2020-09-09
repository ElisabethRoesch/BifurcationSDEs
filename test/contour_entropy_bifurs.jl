include("../src/includes.jl")

bifur_types = ["supercritical_pitchfork", "saddle_node", "transcritical"]
test_list_alpha, test_list_sigma = Array(range(-15., stop = 15.0, length = 9)), Array(range(-0., stop = 2.0, length = 4))
test_list_alpha2, test_list_sigma2 = Array(range(-5, stop = 5.0, length = 9)), Array(range(0., stop = 2., length = 4))
n_bifurs = length(bifur_types)

test_list_alphas = [test_list_alpha, test_list_alpha2, test_list_alpha2]
test_list_sigmas = [test_list_sigma, test_list_sigma2, test_list_sigma2]


file_path_raws = [get_file_path_raw(bifur_types[i]) for i in 1:n_bifurs]
rep_output_raws = [load_raw(file_path_raws[i]) for i in 1:n_bifurs]
file_path_plots = [get_file_path_plot_entropy(bifur_types[i]) for i in 1:n_bifurs]
Es = [get_entropy_single(rep_output_raws[i]) for i in 1:n_bifurs]

p_cf_e_s = plot_multi_contourf_entropy(Es,  test_list_alphas, test_list_sigmas)
[savefig(p_cf_e_s[i], file_path_plots[i]) for i in 1:n_bifurs]

# z = [f(i,j) for i in test_list_alpha, j in test_list_sigma]
# h = heatmap(test_list_alpha, test_list_sigma, f, size = (500,500), legend=false, xlabel = "α", ylabel = "σ")
# c = contour(test_list_alpha, test_list_sigma, f, size = (500,500), legend=false, xlabel = "α", ylabel = "σ")
# surface(test_list_alpha, test_list_sigma, g, xlabel = "α", ylabel = "σ", zlabel = "H")
# plot(test_list_alpha, test_list_sigma, z, st=:surface)
