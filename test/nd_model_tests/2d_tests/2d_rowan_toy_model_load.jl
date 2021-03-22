# Test entropy with samples
include("../../../src/includes.jl")

using Plots
contour(raw_1_2)


plts = []

for i in 1:3
    for j in 1:3
        key = string("$i","_$j")
        file_path_raw = string("test/nd_model_tests/2d_tests/data_additive_11_IC/rep_output_", key, "_raw.jld")
        raw = load(file_path_raw)[key]
        plt = scatter(raw[1], raw[2], xlim = (-2, 2),ylim = (-2, 2), label = "")
        push!(plts, plt)
    end
end

plot(plts...)
