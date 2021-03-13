include("../../../src/includes.jl")


####
# Load data
keys = ["1_1" "1_2" "1_3";
        "2_1" "2_2" "2_3";
         "3_1" "3_2" "3_3"]
set = Matrix(undef, size(keys)[1], size(keys)[2])
function get_files(key)
    file_path_raw = string("test/nd_model_tests/2d_tests/data/rep_output_", key, "_raw.jld")
    file_path_potential = string("test/nd_model_tests/2d_tests/data/rep_output_", key, "_potential.jld")
    rep_output_raw = load(file_path_raw)[key]
    rep_output_potential = load(file_path_potential)[key]
    return rep_output_raw, rep_output_potential
end
for i in 1:size(keys)[1]
    for j in 1:size(keys)[2]
        set[i,j] = get_files(keys[i,j])
    end
end

#####
# Entropy via InformationMeasures.jl
using InformationMeasures, Plots

set[1,1][2][1,]

q_e_s = Matrix(undef, size(keys)[1], size(keys)[2])
q_e_s2 = Matrix(undef, size(keys)[1], size(keys)[2])

for i in 1:size(keys)[1]
    for j in 1:size(keys)[2]
        res = Array{Float64}(undef,41)
        res2 = Array{Float64}(undef,41)

        for k in 1:41
            temp_b = set[i,j][2]
            print(size(temp_b[k,:]))
            res[k] = get_entropy(temp_b[k,:]) # entropy col wise of potential
            res2[k] = get_entropy(temp_b[:,k]) # entropy col wise of potential

        end
        q_e_s[i,j] = res
        q_e_s2[i,j] = res2

    end
end
ps = []
ps2 = []

for i in 1:3
    for j in 1:3
        p = plot(q_e_s[i,j])
        p2 = plot(q_e_s2[i,j])
        push!(ps, p)
        push!(ps2, p2)
    end
end
plot(ps..., layout = (3,3))
savefig("entropy_colwise1.pdf")
plot(ps2..., layout = (3,3))
savefig("entropy_colwise2.pdf")


p_q_e_s = contourf(q_e_s)


p_1 = [1,2,3.3]
p_2 = [0 0 0;
        4 5 6.3]
e_p_1 = InformationMeasures.get_entropy(p_1)
e_p_2 = InformationMeasures.get_entropy(p_2)
p2_b = slicematrix(p_2)
e_p_2 = InformationMeasures.get_entropy(p2_b...)


a = slicematrix(rep_output_potential)

#####



#####
# Fisher infromation via FiniteDiff
using FiniteDiff
f(x) = x^2
res = FiniteDiff.hessian(f, [1])
#####


#####
# Entorpy with QuantumInformation
using

# Example:
p_1 = [1,2,3]
p_2 = [1 2 3;
        4 5 6]

s_e_p_1 = shannon_entropy(p_1)
v_e_p_1 = vonneumann_entropy(p_1)
s_e_p_2 = shannon_entropy(p_2) # Error
v_e_p_2 = vonneumann_entropy(p_2) # Error

s_e = shannon_entropy(a...) # Error
v_e = vonneumann_entropy(a...) # Error
####

using Shannon
Shannon.entrpopy(p2)

using Statistics, Plots
q_stds = Matrix(undef, size(keys)[1], size(keys)[2])
q_vars = Matrix(undef, size(keys)[1], size(keys)[2])
q_cors = Matrix(undef, size(keys)[1], size(keys)[2])
q_covs = Matrix(undef, size(keys)[1], size(keys)[2])

for i in 1:size(keys)[1]
    for j in 1:size(keys)[2]
        q_stds[i,j] = std(set[i,j][2]) # std of potential
        q_vars[i,j] = var(set[i,j][2]) # std of potential
        q_cors[i,j] = cor(set[i,j][2]) # std of potential
        q_covs[i,j] = cov(set[i,j][2]) # std of potential

    end
end
p_stds = contourf(q_stds)
p_vars = contourf(q_vars)
p_cors = contourf(q_cors, Nothing)
p_covs = contourf(q_covs)



contourf([1 2 3; 1  NaN 3])
