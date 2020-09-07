# Calculates the KS distance between two distributions (approximate)
function kolmogorov_smirnov_distance(data1::Array{Float64}, data2::Array{Float64})
            #Produce function which returns ecdf
            ecdf_func_1 = StatsBase.ecdf(data1)
            ecdf_func_2 = StatsBase.ecdf(data2)
            #find maximum value of both data sets for ecdf intervals
            max = maximum([data1;data2])
            intervals = max/999
            #calculate ecdf value at each interval
            ecdf_vals_1 = Array{Float64,1}(undef,1000)
            for i in 1:1000
                        ecdf_vals_1[i] = ecdf_func_1(intervals*(i-1))
            end
            ecdf_vals_2 = Array{Float64,1}(undef,1000)
            for i in 1:1000
                        ecdf_vals_2[i] = ecdf_func_2(intervals*(i-1))
            end
            dist = maximum(abs.(ecdf_vals_1 - ecdf_vals_2))
            return dist
end
function KS_vectors(rep_output)
    res = Array{Float64}(undef,size(rep_output)[1],size(rep_output)[2])
    for i in 1:size(rep_output)[1]
        for j in 1:size(rep_output)[2]
            res[i,j] = kolmogorov_smirnov_distance(rep_output[i,1], rep_output[i,j])
        end
    end
    return res
end
function H_vectors(rep_output)
    resH = Array{Float64}(undef,size(rep_output)[1],size(rep_output)[2])
    for i in 1:size(rep_output)[1]
        for j in 1:size(rep_output)[2]
            resH[i,j] = hellinger(abs.(rep_output[i,1]), abs.(rep_output[i,j]))
        end
    end
    return resH
end

function Entropy_vectors(rep_output) #calculate entropy value for each rep_output for all alpha and sigma values
    resE = Array{Float64}(undef,size(rep_output)[1],size(rep_output)[2])
    for i in 1:size(rep_output)[1]
        for j in 1:size(rep_output)[2]
            resE[i,j] = get_entropy(rep_output[i,j])
        end
    end
    return resE
end

function pairwise_ent(Ent_vec) #calculate the pairwise entropy between rep_outputs for each alpha from sigma n to sigma n+1.
    resP = Array{Float64}(undef,size(rep_output)[1],size(rep_output)[2])
    for i in 1:size(rep_output)[1]
        for j in 1:size(rep_output)[2]
            resP[i,j] = get_entropy(rep_output[i,1], rep_output[i,j])
        end
    end
    return resP
end
