using DifferentialEquations, Plots

function f(dx, x, p, t) # p = [α, λ, β, c, σ]
    α = p[1]
    λ = p[2]
    β = p[3]
    c = p[4]
    dx[1] = 2α*x[1] - 4λ*x[1]^3 - β + 4c*λ*x[2]^3
    dx[2] = 2c*α*x[1] - 4c*λ*x[1]^3 - c*β - 4λ*x[2]^3
    return  dx
end

function g(dx, x, p, t) # p = [α, λ, β, c, σ]
    sigma = p[end]
    dx .= fill(sigma, length(x))
    return dx
end

tspan = (0.0, 10.0)
u0 = [0.,0.]

test_p = [0.5, 0.25, -0.05, 0.5, 0.01]
temp_prob = SDEProblem(f, g, u0, tspan, test_p)
nsol = solve(temp_prob)
p1 = plot(nsol)



test_p2 = [0.5, 0.25, -0.05, 0.5, 1.2]
temp_prob2 = SDEProblem(f, g, u0, tspan, test_p2)
nsol2 = solve(temp_prob2)
p2 = plot(nsol2)

plot(p1, p2)
