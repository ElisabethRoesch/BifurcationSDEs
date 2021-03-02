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


# example input:
# prob_arg_list = test_prob_arg_list
# test_p = [0.5, 0.25, -0.05, 0.5, 0.4]

function solve_prob_multi_d(prob_arg_list, p_arg)
    temp_f, temp_g, temp_tspan, initpoints, timepoints, npoints = prob_arg_list
    temp_p = test_p
    n_states = length(initpoints)
    temp_outputs = [Float64[]  for j in 1:n_states]
    for i in 1:length(initpoints)
            x0 = [initpoints[i][j] for j in 1:n_states]
            temp_prob = SDEProblem(temp_f, temp_g, x0, temp_tspan, temp_p)
            for j in 1:npoints
                nsol = Array(solve(temp_prob, saveat = timepoints))
                for state in 1:n_states
                    append!(temp_outputs[state], nsol[state,:])
                end
            end
    end
    kde_t = kde((temp_outputs[1],temp_outputs[2]))
    potential = -log.(pdf(kde_t, -5.0:0.01:5.0, -5.0:0.01:5.0).+1)
    return temp_outputs, potential
end

function solve_prob_multi_d_new(prob_arg_list, p_arg)
    temp_f, temp_g, temp_tspan, initpoints, timepoints, npoints = prob_arg_list
    temp_p = test_p
    n_states = length(initpoints)
    temp_outputs = [Float64[]  for j in 1:n_states]
    for i in 1:length(initpoints)
            x0 = [initpoints[i][j] for j in 1:n_states]
            temp_prob = SDEProblem(temp_f, temp_g, x0, temp_tspan, temp_p)
            for j in 1:npoints
                nsol = Array(solve(temp_prob, saveat = timepoints))
                for state in 1:n_states
                    append!(temp_outputs[state], nsol[state,:])
                end
            end
    end

    len = length(temp_outputs[1])
    in = Array{Float64,2}(undef, 2, len)
    in[1,:] = temp_outputs[1]
    in[2,:] = temp_outputs[2]
    print("this is before kde")
    print("size(in)  ", size(in))
    pdf2 = KernelDensityEstimate.kde!(in)
    print("this is after kde")
    r1 = [-5.0:0.01:5.0;]
    r2 = [-5.0:0.01:5.0;]
    d = 2
    vs = Matrix{Float64}(undef, d, length(r1)*length(r2))
    n,m = length(r1), length(r2)
    for i in 1:n
        for j in  1:m
            v = [r1[i],r2[j]]
            vs[:,(i-1)*n+j] = v
        end
    end
    pdfs = pdf2(vs)
    pdfs_shift = pdfs.+1
    potential = -log.(pdfs_shift)
    potential_matrix = reshape(potential, (n,m))
    return temp_outputs, potential_matrix # Check format of second return of this function.
end
