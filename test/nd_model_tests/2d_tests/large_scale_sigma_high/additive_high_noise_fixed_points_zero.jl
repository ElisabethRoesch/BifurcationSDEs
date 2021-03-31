include("../../../../src/includes.jl")

setForceEvalDirect!(false)
Array(-10:.5:10)

function test_sigmas(sigmas)
    tspan = (0.0, 1000.0)
    timepoints = [1000.0]
    len = 11
    initpoints = [Array(range(-2, stop = 2, length = len)), Array(range(-2, stop = 2, length = len))]
    npoints = 1000
    kde_grid = [-10:.5:10, -10:.5:10]
    test_prob_arg_list = [f_2d_rowan_toy, g_nd_additive, tspan, initpoints, timepoints, npoints, kde_grid]
    res = []
    for sigma_temp in sigmas
        a_temp, b_temp  = test_sigma(sigma_temp, test_prob_arg_list)
        push!(res, (a_temp, b_temp))
        println("sigma_temp is: ", sigma_temp)
    end
    return res
end


function test_sigma(sigma_temp, test_prob_arg_list)
    test_p_temp = [0.5, 0.25, 0.0, 0.5, sigma_temp] # alpha, lambda, beta, c, sigma
    a_temp, b_temp = solve_prob_2d_new(test_prob_arg_list, test_p_temp)
    return a_temp, b_temp
end

function get_plots(data)
    len = length(data)
    plts = Array{Any}(undef, len, 2)
    for i in 1:len
        raw_plot_temp, q_plot_temp = get_plot_pair(data[i])
        plts[i,1] = raw_plot_temp
        plts[i,2] = q_plot_temp
    end
    ps_raws = plot(plts[2:end,1]...)
    ps_qs = plot(plts[2:end,2]...)
    return ps_raws, ps_qs
end

function get_plot_pair(data_temp)
    a_temp, b_temp = data_temp
    raw_plot_temp = contourf(b_temp, size = (1500, 500), xlab = "x1", ylab = "x2", label = "Q(X)")
    q_plot_temp = scatter(a_temp[1],a_temp[2], xlab = "x1", ylab = "x2", label = "End points of simulation", xlim = (-2, 2),ylim = (-2, 2), size = (1500, 500))
    return raw_plot_temp, q_plot_temp
end

function save_res(res)
    for i in 1:length(res)
        save("large_scale_sigma_high/raw_zero_$i.jld", "raw", res[i][1])
        save("large_scale_sigma_high/q_zero_$i.jld", "q", res[i][2])
    end
end

save_res(res)

sigmas = Array(range(0., step = 1., stop = 10.))
#res = test_sigmas(sigmas)
p1, p2 =  get_plots(res)
plot(p1)
savefig("large_scale_sigma_high/raw_zero_all.pdf")
plot(p2)
savefig("large_scale_sigma_high/q_zero_all.pdf")
