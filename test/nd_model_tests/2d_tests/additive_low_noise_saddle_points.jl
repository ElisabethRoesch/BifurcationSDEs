include("../../../src/includes.jl")
setForceEvalDirect!(false)
tspan = (0.0, 1000.0)
timepoints = [1000.0]
len = 11
initpoints = [Array(range(-2, stop = 2, length = len)), Array(range(-2, stop = 2, length = len))]
npoints = 1000
kde_grid = [-2:0.1:2, -2:0.1:2]
test_prob_arg_list = [f_2d_rowan_toy, g_nd_additive, tspan, initpoints, timepoints, npoints, kde_grid]



sigma_low = 0.3
key =  "1_2"
test_p = [0.5, 0.25, 0.0, 0.5, sigma_low] # alpha, lambda, beta, c, sigma
a3,b3 = solve_prob_2d_new(test_prob_arg_list, test_p)


sigma_low = 0.2
key =  "1_2"
test_p = [0.5, 0.25, 0.0, 0.5, sigma_low] # alpha, lambda, beta, c, sigma
a2,b2 = solve_prob_2d_new(test_prob_arg_list, test_p)



sigma_low = 0.01
key =  "1_2"
test_p = [0.5, 0.25, 0.0, 0.5, sigma_low] # alpha, lambda, beta, c, sigma
a1,b1 = solve_prob_2d_new(test_prob_arg_list, test_p)



ap1 = contourf(b1, size = (1500, 500), xlab = "x1", ylab = "x2",  title = "Noise: sigma = 0.1", label = "Q(X)")
ap2 = contourf(b2, size = (1500, 500), xlab = "x1", ylab = "x2",  title = "Noise: sigma = 0.2", label = "Q(X)")
ap3 = contourf(b3, size = (1500, 500), xlab = "x1", ylab = "x2",  title = "Noise: sigma = 0.3", label = "Q(X)")



bp1 = scatter(a1[1],a1[2], xlab = "x1", ylab = "x2",  title = "Noise: sigma = 0.1", label = "End points of simulation", xlim = (-2, 2),ylim = (-2, 2), size = (1500, 500))
bp2 = scatter(a2[1],a2[2], xlab = "x1", ylab = "x2",  title = "Noise: sigma = 0.2", label = "End points of simulation", xlim = (-2, 2),ylim = (-2, 2), size = (1500, 500))
bp3 = scatter(a3[1],a3[2], xlab = "x1", ylab = "x2", title = "Noise: sigma = 0.3", label = "End points of simulation", xlim = (-2, 2),ylim = (-2, 2), size = (1500, 500))


plot(bp1, bp2, bp3, layout = (1,3))
savefig("additive_noise_shifts_states_raw.pdf")
plot(ap1, ap2, ap3, layout = (1,3))
savefig("additive_noise_shifts_states_q.pdf")
