include("../../../src/includes.jl")
# Gardner switch (BMC Syst Biol 2016 Leon)
# u is the concentration of repressor 1
# v the concentration of repressor 2
# α1 and α2 denote the effective rates of synthesis of repressors 1 and 2
# β and γ are the cooperativity of repression of promoter 1 and of repressor 2


# test setting
u0 = [3., 2.9]
p = [100., 2., 100., 2.] # from Supplementary material (BMC Syst Biol 2016 Leon)
tspan = (0.0, 10.0)


timepoints = 0.2:0.2:10.0 # poistions of data point selected from SDE solve
len = 10
initpoints = [Array(range(0, stop = 1, length = len)), Array(range(0, stop = 1, length = len))] # TO DO: how to set inits?
npoints = 20 # this is number of SDEs
kde_grid = [0.25:0.005:.75, 0.25:0.005:.75] # TO DO: how to set kde_grid?
test_prob_arg_list = [f_2d_gardner, g_nd_additive, tspan, initpoints, timepoints, npoints, kde_grid]


sigma_low = 0.2
sigma_high = 0.8
test_p_low = [p..., sigma_low] # alpha, lambda, beta, c, sigma
test_p_high = [p..., sigma_high] # alpha, lambda, beta, c, sigma

a1, b1 = solve_prob_2d_new(test_prob_arg_list, test_p_low)
a2, b2 = solve_prob_2d_new(test_prob_arg_list, test_p_high)

p1 = contourf(b1)
p2 = contourf(b2)
plot(p1, p2)
