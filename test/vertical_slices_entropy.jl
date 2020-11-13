include("../src/includes.jl")

bifur_type = "transcritical"
file_path_raw_n = string("test/data/large_scale_sigma_neg/rep_output_", bifur_type, "_raw.jld")
file_path_raw_z = string("test/data/large_scale_sigma/rep_output_", bifur_type, "_raw.jld")
file_path_raw_p = string("test/data/large_scale_sigma_pos/rep_output_", bifur_type, "_raw.jld")

rep_output_raw_n = load(file_path_raw_n)["rep_output_raw"]
rep_output_raw_z = load(file_path_raw_z)["rep_output_raw"]
rep_output_raw_p = load(file_path_raw_p)["rep_output_raw"]

E_res_n = Entropy_vectors(rep_output_raw_n)
E_res_z = Entropy_vectors(rep_output_raw_z)
E_res_p = Entropy_vectors(rep_output_raw_p)
E_res_multi = [E_res_n, E_res_z, E_res_p]
alphas = [-2.5, 0, 2.5]
test_list_sigma =Array(range(0., stop = 7.5, length = 20))
multi_p_transcritical = plot_large_scale_multi(E_res_multi, alphas, test_list_sigma,bifur_type)
# savefig(multi_p_transcritical, string("test/plots/large_scale_sigma/", bifur_type,"_vertical_slice_entropy_n_z_p.pdf"))


bifur_type = "saddle_node"
file_path_raw_n = string("test/data/large_scale_sigma_neg/rep_output_", bifur_type, "_raw.jld")
file_path_raw_z = string("test/data/large_scale_sigma/rep_output_", bifur_type, "_raw.jld")
file_path_raw_p = string("test/data/large_scale_sigma_pos/rep_output_", bifur_type, "_raw.jld")

rep_output_raw_n = load(file_path_raw_n)["rep_output_raw"]
rep_output_raw_z = load(file_path_raw_z)["rep_output_raw"]
rep_output_raw_p = load(file_path_raw_p)["rep_output_raw"]

E_res_n = Entropy_vectors(rep_output_raw_n)
E_res_z = Entropy_vectors(rep_output_raw_z)
E_res_p = Entropy_vectors(rep_output_raw_p)
E_res_multi = [E_res_n, E_res_z, E_res_p]
alphas = [-2.5, 0, 2.5]
test_list_sigma =Array(range(0., stop = 7.5, length = 20))
multi_p_saddle_node = plot_large_scale_multi(E_res_multi, alphas, test_list_sigma,bifur_type)
# savefig(multi_p_saddle_node, string("test/plots/large_scale_sigma/", bifur_type,"_vertical_slice_entropy_z_p_n.pdf"))

bifur_type = "supercritical_pitchfork"
file_path_raw_n = string("test/data/large_scale_sigma_neg/rep_output_", bifur_type, "_raw.jld")
file_path_raw_z = string("test/data/large_scale_sigma/rep_output_", bifur_type, "_raw.jld")
file_path_raw_p = string("test/data/large_scale_sigma_pos/rep_output_", bifur_type, "_raw.jld")

rep_output_raw_n = load(file_path_raw_n)["rep_output_raw"]
rep_output_raw_z = load(file_path_raw_z)["rep_output_raw"]
rep_output_raw_p = load(file_path_raw_p)["rep_output_raw"]

E_res_n = Entropy_vectors(rep_output_raw_n)
E_res_z = Entropy_vectors(rep_output_raw_z)
E_res_p = Entropy_vectors(rep_output_raw_p)
E_res_multi = [E_res_n, E_res_z, E_res_p]
alphas = [-7.5, 0, 7.5]
test_list_sigma =Array(range(0., stop = 7.5, length = 20))
multi_p_supercritical_pitchfork = plot_large_scale_multi(E_res_multi, alphas, test_list_sigma,bifur_type)
# savefig(multi_p_supercritical_pitchfork, string("test/plots/large_scale_sigma/", bifur_type,"_vertical_slice_entropy_z_p_n.pdf"))


ps = plot(multi_p_supercritical_pitchfork,multi_p_transcritical, multi_p_saddle_node,layout = (1,3), size=(1500,500))
savefig(ps, string("test/plots/large_scale_sigma/all_bifurs_vertical_slice_entropy_n_z_p2.pdf"))
