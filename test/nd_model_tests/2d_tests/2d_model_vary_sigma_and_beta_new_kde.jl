
include("../../../src/includes.jl")
setForceEvalDirect!(false) # needed for speed up for kde

# list_alpha, list_sigma = Array(range(-5, stop = 5.0, length = 9)), Array(range(0., stop = 2., length = 4))

tspan = (0.0, 10.0) # span of sde solve
timepoints = 0.2:0.2:10.0 # poistions of data point selected from SDE solve
len = 10
# TO DO: how to set inits?
initpoints = [Array(range(0, stop = 1, length = len)), Array(range(0, stop = 1, length = len))]
npoints = 20 # this is number of SDEs
# TO DO: how to set kde_grid?
kde_grid = [0.25:0.005:.75, 0.25:0.005:.75]
test_prob_arg_list = [f_2d_rowan_toy, g_2d_rowan_toy_CLE, tspan, initpoints, timepoints, npoints, kde_grid]

kde_grid_arr_start = Array(kde_grid[1])[1]
kde_grid_arr_end = Array(kde_grid[2])[end]


# EXAMPLE 1: Three settings (three different values for beta) for LOW noise (sigma = 0.2)
# Setting 1:
sigma_low = 0.2
prob_arg_list = test_prob_arg_list
test_p = [0.5, 0.25, -0.4, 0.5, sigma_low] # alpha, lambda, beta, c, sigma
temp_f, temp_g, temp_tspan, initpoints, timepoints, npoints = prob_arg_list
a,b = solve_prob_2d_new(test_prob_arg_list, test_p)
# p_low_1 = contourf(b, title = "beta = -0.4",xlabel = "State 1", ylabel = "State 2", label = "Quasipotential", clims = (-10,0))
p_low_1 = contourf(b,  clims = (-10,0), legend = :none, xticks = ([0:250:1000;], ["0", "0.25", "0.5","0.75","1.0"]), yticks = ([0:250:1000;], ["0", "0.25", "0.5","0.75","1.0"]))
# Setting 2:
prob_arg_list = test_prob_arg_list
test_p = [0.5, 0.25, 0.0, 0.5, sigma_low]
temp_f, temp_g, temp_tspan, initpoints, timepoints, npoints = prob_arg_list
a,b = solve_prob_2d_new(test_prob_arg_list, test_p)
# p_low_2 = contourf(b, title = "beta = 0.0", xlabel = "State 1", ylabel = "State 2", label = "Quasipotential", clims = (-10,0))
p_low_2 = contourf(b,clims = (-10,0), legend = :none, xticks =([0:250:1000;], ["0", "0.25", "0.5","0.75","1.0"]), yticks = ([0:250:1000;], ["0", "0.25", "0.5","0.75","1.0"]))


# Setting 3:
prob_arg_list = test_prob_arg_list
test_p = [0.5, 0.25, 0.4, 0.5, sigma_low]
temp_f, temp_g, temp_tspan, initpoints, timepoints, npoints = prob_arg_list
a,b = solve_prob_2d_new(test_prob_arg_list, test_p)
# p_low_3 = contourf(b, title = "beta = 0.4", xlabel = "State 1", ylabel = "State 2", label = "Quasipotential", clims = (-10,0))
p_low_3 = contourf(b, clims = (-10,0), legend = :none, xticks =([0:250:1000;], ["0", "0.25", "0.5","0.75","1.0"]), yticks = ([0:250:1000;], ["0", "0.25", "0.5","0.75","1.0"]))

plot(p_low_1, p_low_2, p_low_3)



# EXAMPLE 2: Three settings (three different values for beta) for MEDIUM noise (sigma = 0.4)
# Setting 1:
sigma_medium = 0.4
prob_arg_list = test_prob_arg_list
test_p = [0.5, 0.25, -0.4, 0.5, sigma_medium] # alpha, lambda, beta, c, sigma
temp_f, temp_g, temp_tspan, initpoints, timepoints, npoints = prob_arg_list
a,b = solve_prob_2d_new(test_prob_arg_list, test_p)
# p_medium_1 = contourf(b, title = "beta = -0.4",xlabel = "State 1", ylabel = "State 2", label = "Quasipotential", clims = (-10,0))
p_medium_1 = contourf(b, clims = (-10,0), legend = :none, xticks =([0:250:1000;], ["0", "0.25", "0.5","0.75","1.0"]),yticks =([0:250:1000;], ["0", "0.25", "0.5","0.75","1.0"]))

# Setting 2:
prob_arg_list = test_prob_arg_list
test_p = [0.5, 0.25, 0.0, 0.5, sigma_medium]
temp_f, temp_g, temp_tspan, initpoints, timepoints, npoints = prob_arg_list
a,b = solve_prob_2d_new(test_prob_arg_list, test_p)
# p_medium_2 = contourf(b, title = "beta = 0.0", xlabel = "State 1", ylabel = "State 2", label = "Quasipotential", clims = (-10,0))
p_medium_2 = contourf(b, clims = (-10,0), legend = :none, xticks =([0:250:1000;], ["0", "0.25", "0.5","0.75","1.0"]),yticks =([0:250:1000;], ["0", "0.25", "0.5","0.75","1.0"]))


# Setting 3:
prob_arg_list = test_prob_arg_list
test_p = [0.5, 0.25, 0.4, 0.5, sigma_medium]
temp_f, temp_g, temp_tspan, initpoints, timepoints, npoints = prob_arg_list
a,b = solve_prob_2d_new(test_prob_arg_list, test_p)
# p_medium_3 = contourf(b, title = "beta = 0.4", xlabel = "State 1", ylabel = "State 2", label = "Quasipotential", clims = (-10,0))
p_medium_3 = contourf(b, clims = (-10,0), legend = :none, xticks =([0:250:1000;], ["0", "0.25", "0.5","0.75","1.0"]),yticks =([0:250:1000;], ["0", "0.25", "0.5","0.75","1.0"]))

plot(p_medium_1, p_medium_2, p_medium_3)




# EXAMPLE 3: Three settings (three different values for beta) for HIGH noise (sigma = 0.8)
# Setting 1:
sigma_high = 0.8
prob_arg_list = test_prob_arg_list
test_p = [0.5, 0.25, -0.4, 0.5, sigma_high] # alpha, lambda, beta, c, sigma
temp_f, temp_g, temp_tspan, initpoints, timepoints, npoints = prob_arg_list
a,b = solve_prob_2d_new(test_prob_arg_list, test_p)
# p_high_1 = contourf(b, title = "beta = -0.4",xlabel = "State 1", ylabel = "State 2", label = "Quasipotential", clims = (-10,0))
p_high_1 = contourf(b, clims = (-10,0), legend = :none, xticks =([0:250:1000;], ["0", "0.25", "0.5","0.75","1.0"]),yticks =([0:250:1000;], ["0", "0.25", "0.5","0.75","1.0"]))

# Setting 2:
prob_arg_list = test_prob_arg_list
test_p = [0.5, 0.25, 0.0, 0.5, sigma_high]
temp_f, temp_g, temp_tspan, initpoints, timepoints, npoints = prob_arg_list
a,b = solve_prob_2d_new(test_prob_arg_list, test_p)
# p_high_2 = contourf(b, title = "beta = 0.0", xlabel = "State 1", ylabel = "State 2", label = "Quasipotential", clims = (-10,0))
p_high_2 = contourf(b, clims = (-10,0), legend = :none, xticks =([0:250:1000;], ["0", "0.25", "0.5","0.75","1.0"]),yticks =([0:250:1000;], ["0", "0.25", "0.5","0.75","1.0"]))


# Setting 3:
prob_arg_list = test_prob_arg_list
test_p = [0.5, 0.25, 0.4, 0.5, sigma_high]
temp_f, temp_g, temp_tspan, initpoints, timepoints, npoints = prob_arg_list
a,b = solve_prob_2d_new(test_prob_arg_list, test_p)
# p_high_3 = contourf(b, title = "beta = 0.4", xlabel = "State 1", ylabel = "State 2", label = "Quasipotential", clims = (-10,0))
p_high_3 = contourf(b, clims = (-10,0), legend = :none, xticks =([0:250:1000;], ["0", "0.25", "0.5","0.75","1.0"]),yticks =([0:250:1000;], ["0", "0.25", "0.5","0.75","1.0"]))

plot(p_high_1, p_high_2, p_high_3)

plot(p_low_1, p_low_2, p_low_3, p_medium_1, p_medium_2, p_medium_3, p_high_1, p_high_2, p_high_3)

savefig("three_noise_levels_three_beta_new.pdf")
