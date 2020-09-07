function solve_prob_alpha_sigma_new(prob_arg_list, p_arg) # More efficient version
    temp_f, temp_g, temp_tspan, initpoints, timepoints, npoints = prob_arg_list
    temp_p = p_arg
    temp_outputs = Float64[]
    for i in 1:length(initpoints)
        x0 = [initpoints[i]]
        temp_prob = SDEProblem(temp_f, temp_g, x0, temp_tspan, temp_p)
        for j in 1:npoints
            nsol = Array(solve(temp_prob, saveat = timepoints))
            append!(temp_outputs, nsol)
        end
    end
    kdx_1_N200 = kde(temp_outputs, bandwidth = 0.05)
    potential = -log.(pdf(kdx_1_N200,-5.0:0.01:5.0).+1)
    return temp_outputs, potential
end

function rep_solve(prob_arg_list, list_alpha, list_sigma)
    output_raw = Array{Array{Float64,1}}(undef,length(list_alpha),length(list_sigma))
    output_potential = Array{Array{Float64,1}}(undef,length(list_alpha),length(list_sigma))
    for i in range(1, stop = length(list_alpha))
        for j in range(1, stop = length(list_sigma))
            test_p = [list_alpha[i], list_sigma[j]]
            output_raw[i, j], output_potential[i, j] = solve_prob_alpha_sigma_new(test_prob_arg_list, test_p)
        end
    end
    return output_raw, output_potential
end
