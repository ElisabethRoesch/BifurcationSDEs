include("../../../src/includes.jl")
plts = []
entrs = []
for i in 1:3
    for j in 1:3
        key = string("$i","_$j")
        file_path_raw = string("test/nd_model_tests/2d_tests/data_additive_11_IC/rep_output_", key, "_raw.jld")
        temp_outputs = load(file_path_raw)[key]
        e = get_entropy(temp_outputs[1], temp_outputs[2])
        e_rounded = round(e, digits = 2)
        plt = scatter(temp_outputs[1], temp_outputs[2], xlim = (-2, 2), ylim = (-2, 2), label = "", title = "H(X) = $e_rounded")
        push!(plts, plt)
        push!(entrs, e)
    end
end
plot(plts...)
savefig("entropy_additive_noise.pdf")
