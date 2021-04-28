# Creates article figure 2d_toy_q.pdf, which is 3x3 Quasipotentials Q(X) for 3 noise and 3 beta levels.
include("../../../../src/includes.jl")

# get min and max for normalisation
min_q = 1000
max_q = -1000
for i in 1:3
    for j in 1:3
        key = string("$i","_$j")
        file_path_raw = string("test/nd_model_tests/2d_tests/data_additive_11_IC/rep_output_", key, "_potential.jld")
        temp_outputs = load(file_path_raw)[key]
        min_temp = min(temp_outputs...)
        max_temp = max(temp_outputs...)
        if min_q>min_temp
            min_q=min_temp
        end
        if max_q<max_temp
            max_q=max_temp
        end
    end
end

plts = []
    for i in 1:3
        for j in 1:3
            key = string("$i","_$j")
            file_path_raw = string("test/nd_model_tests/2d_tests/data_additive_11_IC/rep_output_", key, "_potential.jld")
            temp_outputs = load(file_path_raw)[key]
            print(size(temp_outputs))
            plt = contourf(temp_outputs)
            cc = cgrad([  "#922B21", "#E6B0AA"], [0,1])
            plt = contourf(temp_outputs, color = cc,  size = (500, 500), clims = (min_q, max_q), xlabel = "", ylabel = "", legend = :none, levels = 30)
            push!(plts, plt)
        end
    end
    plot(plts...)
savefig("2d_toy_q.pdf")

# checking gradient
cc =  cgrad([ "#E6B0AA", "#922B21"], [0,1])
min_q, max_q
# to get legend

key = string("1","_1")
file_path_raw = string("test/nd_model_tests/2d_tests/data_additive_11_IC/rep_output_", key, "_potential.jld")
temp_outputs = load(file_path_raw)[key]
print(size(temp_outputs))
cc = cgrad(["#922B21", "#E6B0AA"], [min_q, max_q])
plt = contourf(temp_outputs, color = cc, clims = (min_q, max_q), xlabel = "", ylabel = "", levels = 4)
savefig("colorbar.pdf")
