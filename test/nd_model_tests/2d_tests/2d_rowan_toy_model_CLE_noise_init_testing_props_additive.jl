# Example case where all parameter are positive: p = [0.5, 0.25, 0.4, 0.5, sigma_low] = alpha, lambda, beta, c, sigma
include("../../../src/includes.jl")

function f_test(dx, x, p, t)
    h1 = 2*p[1]*x[1]
    h2 = 4*p[2]*x[1]^3
    h3 = p[3]
    h4 = 4*p[4]*p[2]*x[2]^3
    h5 = 2*p[4]*p[1]*x[1]
    h6 = 4*p[4]*p[2]*x[1]^3
    h7 = p[4]*p[3]
    h8 = 4*p[2]*x[2]^3
    hs = [h1 h2 h3 h4 h5 h6 h7 h8]'
    S = [1 -1 0 0 1 -1 0 0; 0 0 0 1 0 0 0 -1]
    f = S*hs
    dx .= f[:,1]
end


setForceEvalDirect!(false) # needed for speed up for kde
tspan = (0.0, 1000.0) # span of sde solve
timepoints = [1000.0] # poistions of data point selected from SDE solve
len = 11 # number inits
initpoints = [Array(range(-2, stop = 2, length = len)), Array(range(-2, stop = 2, length = len))]
npoints = 1000 # this is number of SDEs
kde_grid = [-2:0.1:2, -2:0.1:2]
test_prob_arg_list = [f_test, g_nd_additive, tspan, initpoints, timepoints, npoints, kde_grid]
sigma_low = 0.2 #???
key =  "1_3"
test_p = [0.5, 0.25, 0.4, 0.5, sigma_low] # alpha, lambda, beta, c, sigma
a_h_f,b_h_f = solve_prob_2d_new(test_prob_arg_list, test_p)


scatter(a_h_f[1],a_h_f[2], label = "")
