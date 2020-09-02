function plot_rep_solve(outputs, list_alpha, list_sigma, alpha_start, alpha_end,  sigma_start, sigma_end, color_palette)
    p = plot(xlab = "x", ylab = "potential", ylims = (-2, 0), grid = "off", legend = :outertopright, size = (1000,1100), palette = color_palette)
    for i in range(alpha_start, stop = alpha_end)
        for j in range(sigma_start, stop = sigma_end)
            kdx_1_N200 = kde(rep_output[i,j], bandwidth = 0.05)
            sup1 = plot!(-5.0:0.01:5.0, -log.(pdf(kdx_1_N200,-5.0:0.01:5.0).+1), # we added log shift
                    label = "$(test_list_alpha[i]), $(test_list_sigma[j])")
        end
    end
    return p
end

function plot_rep_solve_2(outputs, list_alpha, list_sigma, alpha_start, alpha_end,  sigma_start, sigma_end, cols, alphas_col)
    ps = []
    for i in range(sigma_start , stop = sigma_end)
        for j in range(alpha_start, stop = alpha_end )
            p = plot(xlab = "", ylab = "",  xlims = (-2, 0), grid = "off", size = (1000,1500), axis=nothing)
            kdx_1_N200 = kde(rep_output[j,i], bandwidth = 0.05)
            sup1 = plot!(-log.(pdf(kdx_1_N200,-5.0:0.01:5.0).+1), -5.0:0.01:5.0, # we added log shift
                    # label = "$(test_list_alpha[i]), $(test_list_sigma[j])"
                     label = "", color =cols[i], alpha = alphas_col[i]
                    )
            push!(ps, p)
        end
    end
    return ps
end


function plot_rep_solve_3(outputs, list_alpha, list_sigma, alpha_start, alpha_end,  sigma_start, sigma_end, cols, alphas_col)
    ps = []
    for i in range(sigma_start , stop = sigma_end)
        for j in range(alpha_start, stop = alpha_end )
            p = plot(xlab = "", ylab = "",  xlims = (-2, 0), grid = "off", size = (1000,1500), axis=nothing)
            kdx_1_N200 = kde(rep_output[j,i], bandwidth = 0.05)
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
    for i in 1:Int(round(length(test_list_alpha)/2))
        temp_alpha = test_list_alpha[i]
        plot!(test_list_sigma, KS_res[i,:], label = "Alpha: $temp_alpha")
        scatter!(test_list_sigma, KS_res[i,:], label = "")
    end
    p2 = plot(grid = "off", ylab = "KS distance to lowest noise", size = (900,400),palette = :Dark2_5, xlab = "increasing stochastisity",  legend = :outertopright)
    for i in Int(round(length(test_list_alpha)/2)):size(KS_res)[1]
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
