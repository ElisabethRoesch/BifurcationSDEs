include("../../../../src/includes.jl")
using InformationMeasures
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


q_e_s2 = Matrix(undef, size(keys)[1], size(keys)[2])
len = size(set[1,1][2])[1]
for i in 1:size(keys)[1]
    for j in 1:size(keys)[2]
        res2 = Array{Float64}(undef,len)
        for k in 1:len
            temp_b = set[i,j][2]
            res2[k] = get_entropy(temp_b[:,k]) # entropy col wise of potential
        end
        q_e_s2[i,j] = res2

    end
end
cols = ["#011f4b", "#005b96", "#b3cde0"]
ps2 = []
    for i in 1:3
        for j in 1:3
            p2 = plot(q_e_s2[i,j], label = "", grid = "off", ylim = (0,2.5), color = "#005b96", fill=(0,0.5,"#b3cde0"), size = (500, 500))
            push!(ps2, p2)
        end
    end
    plot(ps2..., layout = (3,3))
savefig("2d_toy_entropy.pdf")
