
include("../../src/includes.jl")

# list_alpha, list_sigma = Array(range(-5, stop = 5.0, length = 9)), Array(range(0., stop = 2., length = 4))

tspan = (0.0, 100.0) # span of sde solve
timepoints = 0.2:0.2:100.0 # poistions of data point selected from SDE solve
len = 10
# TO DO: how to set inits?
initpoints = [Array(range(0, stop = 1, length = len)), Array(range(0, stop = 1, length = len))]
npoints = 20 # this is number of SDEs
# TO DO: how to set kde_grid?
kde_grid= [0.0:0.01:1.0, 0.0:0.01:1.0]
test_prob_arg_list = [f_2d, g_2d, tspan, initpoints, timepoints, npoints, kde_grid]


# EXAMPLE 1: Three settings (three different values for beta) for LOW noise (sigma = 0.2)
# Setting 1:
prob_arg_list = test_prob_arg_list
test_p = [0.5, 0.25, -0.4, 0.5, 0.2] # alpha, lambda, beta, c, sigma
temp_f, temp_g, temp_tspan, initpoints, timepoints, npoints = prob_arg_list
a,b = solve_prob_multi_d(test_prob_arg_list, test_p)
p1 = contourf(b, title = "beta = -0.4",xlabel = "State 1", ylabel = "State 2", label = "Quasipotential", clims = (-10,0))

# Setting 2:
prob_arg_list = test_prob_arg_list
test_p = [0.5, 0.25, 0.0, 0.5, 0.2]
temp_f, temp_g, temp_tspan, initpoints, timepoints, npoints = prob_arg_list
a,b = solve_prob_multi_d(test_prob_arg_list, test_p)
p2 = contourf(b, title = "beta = 0.0", xlabel = "State 1", ylabel = "State 2", label = "Quasipotential", clims = (-10,0))


# Setting 3:
prob_arg_list = test_prob_arg_list
test_p = [0.5, 0.25, 0.4, 0.5, 0.2]
temp_f, temp_g, temp_tspan, initpoints, timepoints, npoints = prob_arg_list
a,b = solve_prob_multi_d(test_prob_arg_list, test_p)
p3 = contourf(b, title = "beta = 0.4", xlabel = "State 1", ylabel = "State 2", label = "Quasipotential", clims = (-10,0))

plot(p1, p2, p3)



# EXAMPLE 2: Three settings (three different values for beta) for MEDIUM noise (sigma = 0.4)
# Setting 1:
sigma = 0.4
prob_arg_list = test_prob_arg_list
test_p = [0.5, 0.25, -0.4, 0.5, sigma] # alpha, lambda, beta, c, sigma
temp_f, temp_g, temp_tspan, initpoints, timepoints, npoints = prob_arg_list
a,b = solve_prob_multi_d(test_prob_arg_list, test_p)
p1 = contourf(b, title = "beta = -0.4",xlabel = "State 1", ylabel = "State 2", label = "Quasipotential", clims = (-10,0))

# Setting 2:
prob_arg_list = test_prob_arg_list
test_p = [0.5, 0.25, 0.0, 0.5, sigma]
temp_f, temp_g, temp_tspan, initpoints, timepoints, npoints = prob_arg_list
a,b = solve_prob_multi_d(test_prob_arg_list, test_p)
p2 = contourf(b, title = "beta = 0.0", xlabel = "State 1", ylabel = "State 2", label = "Quasipotential", clims = (-10,0))


# Setting 3:
prob_arg_list = test_prob_arg_list
test_p = [0.5, 0.25, 0.4, 0.5, sigma]
temp_f, temp_g, temp_tspan, initpoints, timepoints, npoints = prob_arg_list
a,b = solve_prob_multi_d(test_prob_arg_list, test_p)
p3 = contourf(b, title = "beta = 0.4", xlabel = "State 1", ylabel = "State 2", label = "Quasipotential", clims = (-10,0))

plot(p1, p2, p3)




# EXAMPLE 1: Three settings (three different values for beta) for HIGH noise (sigma = 0.2)

# Setting 1:
prob_arg_list = test_prob_arg_list
test_p = [0.5, 0.25, -0.4, 0.5, 0.8] # alpha, lambda, beta, c, sigma
temp_f, temp_g, temp_tspan, initpoints, timepoints, npoints = prob_arg_list
a,b = solve_prob_multi_d(test_prob_arg_list, test_p)
p1 = contourf(b, title = "beta = -0.4",xlabel = "State 1", ylabel = "State 2", label = "Quasipotential", clims = (-10,0))

# Setting 2:
prob_arg_list = test_prob_arg_list
test_p = [0.5, 0.25, 0.0, 0.5, 0.8]
temp_f, temp_g, temp_tspan, initpoints, timepoints, npoints = prob_arg_list
a,b = solve_prob_multi_d(test_prob_arg_list, test_p)
p2 = contourf(b, title = "beta = 0.0", xlabel = "State 1", ylabel = "State 2", label = "Quasipotential", clims = (-10,0))


# Setting 3:
prob_arg_list = test_prob_arg_list
test_p = [0.5, 0.25, 0.4, 0.5, 0.8]
temp_f, temp_g, temp_tspan, initpoints, timepoints, npoints = prob_arg_list
a,b = solve_prob_multi_d(test_prob_arg_list, test_p)
p3 = contourf(b, title = "beta = 0.4", xlabel = "State 1", ylabel = "State 2", label = "Quasipotential", clims = (-10,0))

plot(p1, p2, p3)
