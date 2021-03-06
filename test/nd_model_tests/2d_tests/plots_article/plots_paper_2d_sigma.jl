# TO DO: ylim, gradient max match
include("../../../../src/includes.jl")
# Load data
keys = ["2" "3" "4"] #dont zero
set = []
function get_files(key)
    file_path_raw = string("large_scale_sigma_low/raw_zero_", key, ".jld")
    file_path_potential = string("large_scale_sigma_low/q_zero_", key, ".jld")
    rep_output_raw = load(file_path_raw)["raw"]
    rep_output_potential = load(file_path_potential)["q"]
    return rep_output_raw, rep_output_potential
end
for i in 1:3
    push!(set,  get_files(keys[i]))
end



# get min and max for normalisation
min_q = 1000
    max_q = -1000
    for j in 1:3
        min_temp = min(set[j][2]...)
        max_temp = max(set[j][2]...)
        if min_q>min_temp
            min_q=min_temp
        end
        if max_q<max_temp
            max_q=max_temp
        end
    end


raw_plts = []
    q_plts = []
    entropy_plts = []
    for i in 1:3
        raw = set[i][1]
        q = set[i][2]
        # Raw data plot
        raw_plt = scatter(raw[1], raw[2],  size = (500, 500), color =  "#E6B0AA", grid = "off", markerstrokecolor =  "#922B21",  xlim = (-2, 2), ylim = (-2, 2), label = "")
        cc = cgrad([  "#922B21", "#E6B0AA"], [0,1])
        # Q plot
        q_plt = contourf(q, color = cc,  size = (500, 500), clims = (min_q, max_q), xlabel = "", ylabel = "", legend = :none, levels = 120)
        push!(raw_plts, raw_plt)
        push!(q_plts, q_plt)
        # Entropy plot
        len = size(set[1][2])[1]
        entropy_vals = Array{Float64}(undef,len)
        for k in 1:len
            temp_b = set[i][2]
            entropy_vals[k] = get_entropy(temp_b[:,k]) # entropy col wise of potential
        end
        #ylim = (0,2.5),
        entropy_plt = plot(entropy_vals, label = "",ylim = (0,2), grid = "off",  color = "#005b96", fill=(0,0.5,"#b3cde0"), size = (500, 500))
        push!(entropy_plts, entropy_plt)
    end
    plts = raw_plts..., q_plts..., entropy_plts...
    plot(plts..., layout=(3,3))
savefig("2d_toy_sigma.pdf")
cc = cgrad([  "#922B21", "#E6B0AA"], [0,1])
plt = contourf(set[1][2], color = cc, clims = (min_q, max_q), xlabel = "", ylabel = "", levels = 4)
savefig("colorbar_sigma.pdf")
