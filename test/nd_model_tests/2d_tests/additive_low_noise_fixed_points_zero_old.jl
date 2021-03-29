
include("../../../src/includes.jl")
setForceEvalDirect!(false)


function test_sigmas(sigmas)
    tspan = (0.0, 1000.0)
    timepoints = [1000.0]
    len = 11
    initpoints = [Array(range(-2, stop = 2, length = len)), Array(range(-2, stop = 2, length = len))]
    npoints = 1000
    kde_grid = [-2:0.1:2, -2:0.1:2]
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
        save("large_scale_sigma/raw_zero_$i.jld", "raw", res[i][1])
        save("large_scale_sigma/q_zero_$i.jld", "q", res[i][2])
    end
end

save_res(res)

sigmas = Array(range(0., step = 0.1, stop = 1.))
#res = test_sigmas(sigmas)
p1, p2 =  get_plots(res)
plot(p1)
savefig("large_scale_sigma/raw_zero_all.pdf")
plot(p2)
savefig("large_scale_sigma/q_zero_all.pdf")





sigma_low_low = 0.01
test_p_low = [0.5, 0.25, 0.0, 0.5, sigma_low_low] # alpha, lambda, beta, c, sigma
a1,b1 = solve_prob_2d_new(test_prob_arg_list, test_p_low)

sigma_low_medium = 0.2
test_p_medium = [0.5, 0.25, 0.0, 0.5, sigma_low_medium] # alpha, lambda, beta, c, sigma
a2,b2 = solve_prob_2d_new(test_prob_arg_list, test_p_medium)


sigma_low_high = 0.3
test_p_high = [0.5, 0.25, 0.0, 0.5, sigma_low_high] # alpha, lambda, beta, c, sigma
a3,b3 = solve_prob_2d_new(test_prob_arg_list, test_p_high)





ap0 = contourf(b0, sizce = (1500, 500), xlab = "x1", ylab = "x2",  title = "Noise: sigma = 0.0", label = "Q(X)")
ap1 = contourf(b1, size = (1500, 500), xlab = "x1", ylab = "x2",  title = "Noise: sigma = 0.01", label = "Q(X)")
ap2 = contourf(b2, size = (1500, 500), xlab = "x1", ylab = "x2",  title = "Noise: sigma = 0.2", label = "Q(X)")
ap3 = contourf(b3, size = (1500, 500), xlab = "x1", ylab = "x2",  title = "Noise: sigma = 0.3", label = "Q(X)")

ap0 = plot()

bp0 = scatter(a0[1],a0[2], xlab = "x1", ylab = "x2",  title = "Noise: sigma = 0", label = "End points of simulation", xlim = (-2, 2),ylim = (-2, 2), size = (1500, 500))
bp1 = scatter(a1[1],a1[2], xlab = "x1", ylab = "x2",  title = "Noise: sigma = 0.01", label = "End points of simulation", xlim = (-2, 2),ylim = (-2, 2), size = (1500, 500))
bp2 = scatter(a2[1],a2[2], xlab = "x1", ylab = "x2",  title = "Noise: sigma = 0.2", label = "End points of simulation", xlim = (-2, 2),ylim = (-2, 2), size = (1500, 500))
bp3 = scatter(a3[1],a3[2], xlab = "x1", ylab = "x2", title = "Noise: sigma = 0.3", label = "End points of simulation", xlim = (-2, 2),ylim = (-2, 2), size = (1500, 500))


plot(bp0, bp1, bp2, bp3c)
savefig("additive_noise_shifts_states_raw_4.pdf")
plot(ap0, ap1, ap2, ap3, layout = (1,4))
savefig("additive_noise_shifts_states_q_4.pdf")
