include("../src/includes.jl")


tspan = (0.0, 2.0)
timepoints = 0.2:0.2:2.0
initpoints = range(-5., stop = 5.0, length = 10)
npoints = 20
test_prob_arg_list = [f_supercritical_pitchfork, g_multiplicative_noise, tspan, initpoints, timepoints, npoints]
raw, pot = rep_solve(prob_arg_list, list_alpha, list_sigma)
