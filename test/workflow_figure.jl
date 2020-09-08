include("../src/includes.jl")

bifur_type = "supercritical_pitchfork"
file_path_raw = string("test/data/rep_output_", bifur_type, "_raw.jld")
file_path_potential = string("test/data/rep_output_", bifur_type, "_potential.jld")
test_list_alpha, test_list_sigma = Array(range(-15., stop = 15.0, length = 9)), Array(range(-0., stop = 2.0, length = 4))


rep_output_raw = load(file_path_raw)["rep_output_raw"]
rep_output_potential = load(file_path_potential)["rep_output_potential"]


test_list_alpha[4]
# inits eig bei -5, 5 aber wegen 0.2 timespan start saving those not visable
p_time_ode_neg = workflow_time_one_sig_one_alpha(rep_output_raw, 4, 1)
        savefig(string("test/plots/workflow/", bifur_type, "_p_time_ode_neg.pdf"))
p_time_ode_pos = workflow_time_one_sig_one_alpha(rep_output_raw, 6, 1)
        savefig(string("test/plots/workflow/", bifur_type, "_p_time_ode_pos.pdf"))
p_time_sde_neg = workflow_time_one_sig_one_alpha(rep_output_raw, 4, 3)
        savefig(string("test/plots/workflow/", bifur_type, "_p_time_sde_neg.pdf"))
p_time_sde_pos = workflow_time_one_sig_one_alpha(rep_output_raw, 6, 3)
        savefig(string("test/plots/workflow/", bifur_type, "_p_time_sde_pos.pdf"))

p_pot_ode_pos = workflow_potential_one_sig_one_alpha(rep_output_potential, 6, 1)
        savefig(string("test/plots/workflow/", bifur_type, "_p_pot_ode_pos.pdf"))
p_pot_sde_neg = workflow_potential_one_sig_one_alpha(rep_output_potential, 4, 3)
        savefig(string("test/plots/workflow/", bifur_type, "_p_pot_sde_neg.pdf"))
p_pot_sde_pos = workflow_potential_one_sig_one_alpha(rep_output_potential, 6, 3)
        savefig(string("test/plots/workflow/", bifur_type, "_p_pot_sde_pos.pdf"))
p_pot_ode_neg = workflow_potential_one_sig_one_alpha(rep_output_potential, 4, 1)
        savefig(string("test/plots/workflow/", bifur_type, "_p_pot_ode_neg.pdf"))
