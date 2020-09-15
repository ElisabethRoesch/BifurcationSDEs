using DifferentialEquations
function f_supercritical_pitchfork(x, p, t) # neq
    dx = p[1]*x[1]-x[1]^3
    return [dx]
end
function g_multiplicative_noise(x, p, t) # noiseeq
    dx = p[2]*x[1]
    return [dx]
end

# Next lines only for rerun.
tspan = (0.0, 2.0)
timepoints = 0.2:0.2:2.0
initpoints = range(-5., stop = 5.0, length = 10)
npoints = 20

temp_prob = SDEProblem(f_supercritical_pitchfork, g_multiplicative_noise, [1.],
    tspan, [1.,1.])
sol = solve(temp_prob, saveat = timepoints)

alg = sol.alg
