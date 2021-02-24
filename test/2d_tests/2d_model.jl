include("../src/includes.jl")

bifur_type = "2d_model"
test_list_alpha, test_list_sigma = Array(range(-5, stop = 5.0, length = 9)), Array(range(0., stop = 2., length = 4))

# to run
tspan = (0.0, 2.0)
timepoints = 0.2:0.2:2.0
initpoints = [range(-10, stop = 10, length = 10), range(-10, stop = 10, length = 10)]
npoints = 20
test_prob_arg_list = [f_2d, g_2d, tspan, initpoints, timepoints, npoints]
# to do: implement rep_solve for multidim
@time rep_output_raw, rep_output_potential  = rep_solve(test_prob_arg_list, test_list_alpha, test_list_sigma) #first dim is alpha, second dim is sigma

file_path_raw = string("test/data/rep_output_", bifur_type, "_raw.jld")
file_path_potential = string("test/data/rep_output_", bifur_type, "_potential.jld")
save(file_path_raw, "rep_output_raw", rep_output_raw)
save(file_path_potential, "rep_output_potential", rep_output_potential)

# Or load data:
file_path_raw = string("test/data/rep_output_", bifur_type, "_raw.jld")
file_path_potential = string("test/data/rep_output_", bifur_type, "_potential.jld")
rep_output_raw = load(file_path_raw)["rep_output_raw"]
rep_output_potential = load(file_path_potential)["rep_output_potential"]

# Visualise:
cols = ["#696969", "#920005", "#920005", "#920005"]
alphas_col = [1.,1.,1.,1.]

# PLOT zeros values
print(E_res[5,:])
E_res = Entropy_vectors(rep_output_raw)
ps_test = plot_summary_stat(E_res, test_list_alpha, test_list_sigma, cols, alphas_col, 0.75)
    p_all = plot(ps_test... , layout = (4, 1))
    savefig(string("test/plots/", bifur_type, "_entropy_single_data_summ_stat_plot_test_v2.pdf"))



ps_potential = plot_potentials(rep_output_potential, test_list_alpha, test_list_sigma, 1, length(test_list_alpha), 1, 4, cols, alphas_col)
    p_app = plot(ps_potential..., layout = (length(test_list_sigma),length(test_list_alpha)))
    savefig(string("test/plots/", bifur_type, "_summary_plot_2_potentialtt_v2.pdf"))

ps_raw = plot_raw_data(rep_output_raw, test_list_alpha, test_list_sigma, 1, length(test_list_alpha), 1, 4, cols, alphas_col)
    p_app = plot(ps_raw..., layout = (length(test_list_sigma),length(test_list_alpha)))
    savefig(string("test/plots/", bifur_type, "_summary_plot_2_rawtt_v2.pdf"))

ps = plot_potential_unstable(rep_output_raw, test_list_alpha, test_list_sigma, 1,
    length(test_list_alpha), 1, length(test_list_sigma), cols, alphas_col, (-5,5), -100)
    p_app = plot(ps..., layout = ( length(test_list_sigma), length(test_list_alpha)))
    savefig(string("test/plots/", bifur_type, "_summary_plot_unstablett_v2.pdf"))

KS_res = KS_vectors(rep_output_raw)
p = plot_KS_vectors(KS_res, test_list_sigma, test_list_alpha)
p_all =plot(p[1], p[2], layout=(1,2))
savefig(string("test/plots/", bifur_type, "_KS_raw_data.pdf"))
KS_res = KS_vectors(rep_output_potential)
p = plot_KS_vectors(KS_res, test_list_sigma, test_list_alpha)
p_all =plot(p[1], p[2], layout=(1,2))
savefig(string("test/plots/", bifur_type, "_KS_potential_data.pdf"))

H_res = H_vectors(rep_output_raw)
p = plot_H_vectors(H_res, test_list_sigma, test_list_alpha)
p_all =plot(p[1], p[2], layout=(1,2))
savefig(string("test/plots/", bifur_type, "_hell_raw_data.pdf"))

H_res = H_vectors(rep_output_potential)
p = plot_H_vectors(H_res, test_list_sigma, test_list_alpha)
p_all =plot(p[1], p[2], layout=(1,2))
savefig(string("test/plots/", bifur_type, "_hell_potential_data.pdf"))
