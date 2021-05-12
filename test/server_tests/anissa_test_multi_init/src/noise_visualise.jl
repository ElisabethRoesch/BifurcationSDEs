# function plot_rep_solve(outputs, list_alpha, list_sigma, alpha_start, alpha_end,  sigma_start, sigma_end, color_palette)
#     p = plot(xlab = "x", ylab = "potential", ylims = (-2, 0), grid = "off", legend = :outertopright, size = (1000,1100), palette = color_palette)
#     for i in range(alpha_start, stop = alpha_end)
#         for j in range(sigma_start, stop = sigma_end)
#             kdx_1_N200 = kde(rep_output[i,j], bandwidth = 0.05)
#             sup1 = plot!(-5.0:0.01:5.0, -log.(pdf(kdx_1_N200,-5.0:0.01:5.0).+1), # we added log shift
#                     label = "$(test_list_alpha[i]), $(test_list_sigma[j])")
#         end
#     end
#     return p
# end

function plot_potentials(outputs, list_alpha, list_sigma, alpha_start, alpha_end,  sigma_start, sigma_end, cols, alphas_col)
    ps = []
    for i in range(sigma_start , stop = sigma_end)
        for j in range(alpha_start, stop = alpha_end )
            p = plot(xlab = "", ylab = "",  xlims = (-2, 0), grid = "off", size = (1000,1500), axis=nothing)
            sup1 = plot!(outputs[j,i], -5.0:0.01:5.0, label = "", color = cols[i], alpha = alphas_col[i])
            push!(ps, p)
        end
    end
    return ps
end

function plot_raw_data(outputs, list_alpha, list_sigma, alpha_start, alpha_end,  sigma_start, sigma_end, cols, alphas_col)
    ps = []
    for i in range(sigma_start , stop = sigma_end)
        for j in range(alpha_start, stop = alpha_end )
            p = plot(xlab = "", ylab = "",  grid = "off",  size = (1000,1500), axis = nothing)
            sup1 = plot!(outputs[j,i], label = "", color = cols[i], alpha = alphas_col[i])
            push!(ps, p)
        end
    end
    return ps
end


# function plot_rep_solve_3(outputs, list_alpha, list_sigma, alpha_start, alpha_end,  sigma_start, sigma_end, cols, alphas_col)
#     ps = []
#     for i in range(sigma_start , stop = sigma_end)
#         for j in range(alpha_start, stop = alpha_end )
#             p = plot(xlab = "", ylab = "",  xlims = (-2, 0), grid = "off", size = (1000,1500), axis = nothing)
#             kdx_1_N200 = kde(rep_output[j,i], bandwidth = 0.05)
#             potential = -log.(pdf(kdx_1_N200,-5.0:0.01:5.0).+1)
#             sup1 = plot!(potential, -5.0:0.01:5.0, label = "", color = cols[i], alpha = alphas_col[i])
#             push!(ps, p)
#         end
#     end
#     return ps
# end
#
# # this excludes the super small values
function plot_potential_unstable(outputs, list_alpha, list_sigma, alpha_start, alpha_end,  sigma_start, sigma_end, cols, alphas_col, ylims, cutoff_val)
    ps = []
    for i in range(sigma_start , stop = sigma_end)
        for j in range(alpha_start, stop = alpha_end)
            p = plot(xlab = "", ylab = "",  xlims = (-2, 0), ylims = ylims, grid = "off", size = (1000,1500), axis=nothing)
            temp = outputs[j,i]
            inds = findall(x->x>cutoff_val, temp)
            kdx_1_N200 = kde(temp[inds], bandwidth = 0.05)
            sup1 = plot!(-log.(pdf(kdx_1_N200,-5.0:0.01:5.0).+1), -5.0:0.01:5.0, # we added log shift
                    # label = "$(test_list_alpha[i]), $(test_list_sigma[j])"
                     label = "", color =cols[i], alpha = alphas_col[i]
                    )
            push!(ps, p)
        end
    end
    return ps
end


function plot_KS_vectors(KS_res, test_list_sigma, test_list_alpha)
    p1 = plot(grid = "off", ylab = "KS distance to lowest noise",size = (900,400),palette =:Dark2_5, xlab = "increasing stochastisity",  legend = :outertopright)
    for i in 1:Int(round(length(test_list_alpha)/2)+1)
        temp_alpha = test_list_alpha[i]
        plot!(test_list_sigma, KS_res[i,:], label = "Alpha: $temp_alpha")
        scatter!(test_list_sigma, KS_res[i,:], label = "")
    end
    p2 = plot(grid = "off", ylab = "KS distance to lowest noise", size = (900,400),palette = :Dark2_5, xlab = "increasing stochastisity",  legend = :outertopright)
    for i in Int(round(length(test_list_alpha)/2)+1):size(KS_res)[1]
        temp_alpha = test_list_alpha[i]
        plot!(test_list_sigma, KS_res[i,:], label = "Alpha: $temp_alpha")
        scatter!(test_list_sigma, KS_res[i,:], label = "")
    end
    return p1, p2
end
function plot_H_vectors(H_res, test_list_sigma, test_list_alpha)
    p1 = plot(grid = "off", ylab = "Hellinger distance to lowest noise",size = (900,400),palette = :default, xlab = "increasing stochastisity",  legend = :outertopright)
    for i in 1:Int(round(length(test_list_alpha)/2)+1)
        temp_alpha = test_list_alpha[i]
        plot!(test_list_sigma, H_res[i,:], label = "Alpha: $temp_alpha")
        scatter!(test_list_sigma, H_res[i,:], label = "")
    end
    p2 = plot(grid = "off", ylab = "Hellinger distance to lowest noise", size = (900,400),palette = :default, xlab = "increasing stochastisity",  legend = :outertopright)
    for i in Int(round(length(test_list_alpha)/2)+1):size(H_res)[1]
        temp_alpha = test_list_alpha[i]
        plot!(test_list_sigma, H_res[i,:], label = "Alpha: $temp_alpha")
        scatter!(test_list_sigma, H_res[i,:], label = "")
    end
    return p1, p2
end

function plot_E_vectors(E_res, test_list_sigma, test_list_alpha)
    p1 = plot(grid = "off", ylab = "Entropy values",size = (900, 400), palette = :default, xlab = "increasing stochastisity",  legend = :outertopright)
    for i in 1:Int(round(length(test_list_alpha)/2)+1)
        temp_alpha = test_list_alpha[i]
        plot!(test_list_sigma, E_res[i,:], label = "Alpha: $temp_alpha")
        scatter!(test_list_sigma, E_res[i,:], label = "")
    end
    p2 = plot(grid = "off", ylab = "Entropy values", size = (900, 400), palette = :default, xlab = "increasing stochastisity",  legend = :outertopright)
    for i in Int(round(length(test_list_alpha)/2)+1):size(E_res)[1]
        temp_alpha = test_list_alpha[i]
        plot!(test_list_sigma, E_res[i,:], label = "Alpha: $temp_alpha")
        scatter!(test_list_sigma, E_res[i,:], label = "")
    end
    return p1, p2
end

function plot_P_vectors(P_res, test_list_sigma, test_list_alpha)
    p1 = plot(grid = "off", ylab = "Pairwise entropy to lower sigma", size = (900,400), palette = :default, xlab = "increasing stochastisity",  legend = :outertopright)
    for i in 1:Int(round(length(test_list_alpha)/2)+1)
        temp_alpha = test_list_alpha[i]
        plot!(test_list_sigma, P_res[i,:], label = "Alpha: $temp_alpha")
        scatter!(test_list_sigma, P_res[i,:], label = "")
    end
    p2 = plot(grid = "off", ylab = "Pairwise Entropy to lower sigma", size = (900,400), palette = :default, xlab = "increasing stochastisity",  legend = :outertopright)
    for i in Int(round(length(test_list_alpha)/2)+1):size(H_res)[1]
        temp_alpha = test_list_alpha[i]
        plot!(test_list_sigma, P_res[i,:], label = "Alpha: $temp_alpha")
        scatter!(test_list_sigma, P_res[i,:], label = "")
    end
    return p1, p2
end

function plot_summary_stat(summ_stat, test_list_alpha, test_list_sigma, cols, alphas_col)
    ps = []
    ann_cols = [:black, "#920005","#920005","#920005"]
    for i in 1:length(test_list_sigma)
        p_temp = plot(grid = "off", ylab = "", ylim = (0.,5), size = (500, 1500), palette = :default, xlab = "",  axis = nothing)
        plot!(test_list_alpha, summ_stat[:,i], label = "", color = cols[i], alpha = alphas_col[i])
        scatter!(test_list_alpha, summ_stat[:,i], label = "", color = cols[i], alpha = alphas_col[i])
        plot!([0.000000000000001,0], [0,summ_stat[Int(round(length(test_list_alpha)/2) + 1), i]], color = cols[i], alpha = alphas_col[i], label = "")
        x0_dist = round(summ_stat[Int(round(length(test_list_alpha)/2) + 1), i], digits = 2)
        annotate!(10, 0.5, text("H (α = 0) = $x0_dist", :right, 10, color = ann_cols[i], alpha = alphas_col[i]))
        push!(ps, p_temp)
    end
    return ps
end

function plot_large_scale(summ_stat, test_list_alpha, test_list_sigma)
    p = plot(grid = "off", ylab = "H(σ, α = 0)", size = (500, 500), palette = :default, xlab = "σ")
    plot!(test_list_sigma, summ_stat[1,:], color =:black, label = "")
    scatter!(test_list_sigma, summ_stat[1,:], color =:black, label = "")
    return p
end

function plot_large_scale_all_sum_stats(sum_stats, test_list_alpha, test_list_sigma, labels)
    cols = [:blue, :green, :orange, :red]
    p = plot(grid = "off", ylab = "Summary statistic (α = 0)", size = (500, 1000), palette = :default, xlab = "σ")
    for i in 1:length(sum_stats)
        plot!(test_list_sigma, sum_stats[i][1,:], color =cols[i], label = labels[i])
        scatter!(test_list_sigma, sum_stats[i][1,:],color =cols[i],  label = "")
    end
    return p
end

function workflow_time_one_sig_one_alpha(rep_output_raw, ind_alpha, ind_sigma)
        p_ode_time = plot(grid = "off", xlab = "", ylab = "", label ="")
            for i in 0:9 # 9 is number fo time points saved per ODE/SDE solution
                    plot!(1+i*10:10+i*10,rep_output_raw[ind_alpha,ind_sigma][1+i*20*10:10+i*20*10], ylim =(-5,5), color = :black, label = "")
            end
        plot!(size=(400,100), axis = nothing)
        return p_ode_time
end

function workflow_potential_one_sig_one_alpha(rep_output_potential, ind_alpha, ind_sigma)
    plt_pot = plot(-rep_output_potential[ind_alpha, ind_sigma], 1:length(rep_output_potential[ind_alpha, ind_sigma]),
                    label = "",  xlab = "", xlim =(-5,5), ylab = "", grid = "off", color = :black ,size=(50,100), axis = nothing)
    return plt_pot
end
