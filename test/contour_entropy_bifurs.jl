include("../src/includes.jl")

bifur_types = ["supercritical_pitchfork", "saddle_node", "transcritical"]
# test_list_alpha length is 100 for new runs, old ones is 9
test_list_alpha, test_list_sigma = Array(range(-15., stop = 15.0, length = 9)), Array(range(-0., stop = 2.0, length = 4))
test_list_alpha2, test_list_sigma2 = Array(range(-5, stop = 5.0, length = 9)), Array(range(0., stop = 2., length = 4))
n_bifurs = length(bifur_types)

test_list_alphas = [test_list_alpha, test_list_alpha2, test_list_alpha2]
test_list_sigmas = [test_list_sigma, test_list_sigma2, test_list_sigma2]


file_path_raws = [get_file_path_raw(bifur_types[i]) for i in 1:n_bifurs]
# file_path_raws[1] = "test/server_tests/anissa_test/plots1/data/rerun_longer_time_span/rep_output_supercritical_pitchfork_raw_rerun_more_inits.jld"

rep_output_raws = [load_raw(file_path_raws[i]) for i in 1:n_bifurs]
file_path_plots = [get_file_path_plot_entropy(bifur_types[i]) for i in 1:n_bifurs]
Es = [get_entropy_single(rep_output_raws[i]) for i in 1:n_bifurs]

p_cf_e_s = plot_multi_contourf_entropy(Es,  test_list_alphas, test_list_sigmas)
#[savefig(p_cf_e_s[i], file_path_plots[i]) for i in 1:n_bifurs]
plot(p_cf_e_s[1],p_cf_e_s[3],p_cf_e_s[2],  layout = (1,3), size=(2300,500))
savefig("entropy_contour_multi_alpha_leg.pdf")
# z = [f(i,j) for i in test_list_alpha, j in test_list_sigma]
# h = heatmap(test_list_alpha, test_list_sigma, f, size = (500,500), legend=false, xlabel = "α", ylabel = "σ")
# c = contour(test_list_alpha, test_list_sigma, f, size = (500,500), legend=false, xlabel = "α", ylabel = "σ")
# surface(test_list_alpha, test_list_sigma, g, xlabel = "α", ylabel = "σ", zlabel = "H")
# plot(test_list_alpha, test_list_sigma, z, st=:surface)


aa = function(a,b)
    return a+b
end
cc = cgrad([:white, :green], [0.1, 0.3, 0.8])
cf_e = contourf([1,2,3], [10, 15, 20], aa, color = cc)

plot([1,2,3], [5,09,7])

vspan!(1,2)

using KernelDensity, Plots, Distributions


function npdensity(z,inferior,superior)

    n = size(z,2)
    p = zeros(n)
    for i = 1:n
        x = z[:,i]
        y = kde(x)
        q05 = quantile(x,0.05)
        Plots.plot(range(minimum(x), stop=inferior, length=100),z->pdf(y,z), color=:red, fill=(0,0.5,:red), label="-Zc")
        q95 = quantile(x,0.95)
        Plots.plot!(range(inferior, stop=superior, length=100),z->pdf(y,z), color=:green, fill=(0,0.5,:green),label="Região de Aceitação")
        Plots.plot!(range(superior, stop=maximum(x), length=100),z->pdf(y,z), color = :red, fill=(0,0.5,:red),label="Zc")
        m = mean(x)
        m = median(x)
        if i == 1
            p = Plots.plot!([m,m],[0,pdf(y,m)],color=:black, label="mediana")
        else
            p = [p, Plots.plot!([m,m],[0,pdf(y,m)],color=:black, label="mediana")]
        end
    end
    return p
end

parafusos = rand( Normal( 0 , 1 ),1000000)
a=npdensity(parafusos,-1.96,1.96)

plot([1,2,3],[4,7,2], fill=(0,0.5,:red), linecolor = :white)
plot!([1,2,3],[4,3,2], fill=(0,0.5,:red), linecolor = :white)
