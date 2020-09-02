function solve_prob_alpha_sigma_new(prob_arg_list, p_arg) # More efficient version
    temp_f, temp_g, temp_tspan = prob_arg_list
    temp_p = p_arg
    initpoints = range(-5., stop = 5.0, length = 10) # keeping this low is good for performance
    Npoints = 20 # keeping this low is good for performance
    timepoints = 0.0:0.2:2.0 # changing stepsize doenst cost much but makes results smoother. changed start from 0.2 ( why was it 0.2 before?).
    temp_outputs = Array{Float64}(undef, length(initpoints)*Npoints*length(timepoints))
    for i in 1:length(initpoints)
        x0 = [initpoints[i]]
        temp_prob = SDEProblem(temp_f, temp_g, x0, temp_tspan, temp_p)
        for j in 1:Npoints
            nsol = Array(solve(temp_prob, saveat = timepoints))
            temp_outputs[(i-1)*length(timepoints)*Npoints+(j-1)*length(timepoints)+1:(i-1)*length(timepoints)*Npoints+(j-1)*length(timepoints)+length(timepoints)] = nsol
        end
    end
    return temp_outputs
end

function rep_solve(prob_arg_list, list_alpha, list_sigma)
    outputs = Array{Array{Float64,1}}(undef,length(list_alpha),length(list_sigma))
    for i in range(1, stop = length(list_alpha))
        for j in range(1, stop = length(list_sigma))
            test_p =[list_alpha[i], list_sigma[j]]
            outputs[i, j] = solve_prob_alpha_sigma_new(test_prob_arg_list, test_p)
        end
    end
    return outputs
end
