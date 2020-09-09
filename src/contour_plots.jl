function get_file_path_raw(bifur_type)
    return string("test/data/rep_output_", bifur_type, "_raw.jld")
end
function get_file_path_pot(bifur_type)
    return string("test/data/rep_output_", bifur_type, "_potential.jld")
end
function get_file_path_pot_rerun(bifur_type)
    return string("test/data/rerun_longer_time_span/rep_output_", bifur_type, ".jld")
end
function load_raw(file_path_raw)
    return load(file_path_raw)["rep_output_raw"]
end
function get_file_path_plot_entropy(bifur_type)
    return string("test/plots/contour/", bifur_type, "_contour_entropy.pdf")
end
function get_file_path_plot_pot(bifur_type)
    return string("test/plots/contour/", bifur_type, "_contour_pot.pdf")
end
function get_entropy_single(raw)
    return Entropy_vectors(raw)
end
function plot_contourf_entropy(E, test_list_alpha, test_list_sigma)
    function f(alpha, sigma)
        ind_x = findfirst(a -> a == alpha, test_list_alpha)
        ind_y = findfirst(s -> s == sigma, test_list_sigma)
        return E[ind_x, ind_y]
    end
    cf_e = contourf(test_list_alpha, test_list_sigma, f, legend = false, size = (500, 500), xlabel = "α", ylabel = "σ")
    return cf_e
end
function plot_multi_contourf_entropy(Es, test_list_alphas, test_list_sigmas)
    p_cf_e_s = []
    for i in 1:length(Es)
        temp_p_cf_e = plot_contourf_entropy(Es[i], test_list_alphas[i], test_list_sigmas[i])
        push!(p_cf_e_s, temp_p_cf_e)
    end
    return p_cf_e_s
end

function plot_multi_contour_pot(rep_output_pots)
    n_bifurs = length(rep_output_pots)
    n_sigmas = size(rep_output_pots[1])[2]
    cf_pot_s = []
    for i in 1:n_bifurs
        pot_temp_bifur = rep_output_pots[i]
        cf_pot_s_temp_bifur = []
        for j in 1:n_sigmas
            pot_temp_bifur_temp_sigma = pot_temp_bifur[:,j]
            cf_pot_temp_bifur_temp_sigma = plot_contour_pot(pot_temp_bifur_temp_sigma)
            push!(cf_pot_s_temp_bifur, cf_pot_temp_bifur_temp_sigma)
        end
        push!(cf_pot_s, cf_pot_s_temp_bifur)
    end
    return cf_pot_s
end

function plot_contour_pot(pot) # r_pitch_det
    a_l = length(pot)
    b_l = length(pot[1])
    as=1:a_l
    bs=1:b_l
    function f(a, b)
        return pot[a][b]
    end
    cf_pot = contourf(as, bs, f, legend = false, size = (500, 500), xlabel = "α", ylabel = "X")
    return cf_pot
end
