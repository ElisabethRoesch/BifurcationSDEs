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

function g_2d_rowan_toy_CLE(dx, x, p, t) # pos x : g(x) = sqrt(f(x))
    x1 = 2*p[1]*x[1]-4*p[2]*x[1]^3-p[3]+4*p[4]*p[2]*x[2]^3
    x2 = 2*p[4]*p[1]*x[1]-4*p[4]*p[2]*x[1]^3-p[4]*p[3]+4*p[2]*x[2]^3
    dx_f = [x1, x2]
    sigma = p[end]
    for i in 1:2
        if dx_f[i] < 0
            dx[i] = -sigma*sqrt(abs(dx_f[i]))
        else
            dx[i] = sigma*sqrt(dx_f[i])
        end
    end
    return dx
end

tspan = (0.0, 1000.0)
u0 = [2.,2.]

test_p = [0.5, 0.25, -0.05, 0.5, 0.01]
temp_prob = SDEProblem(f, g_2d_rowan_toy_CLE, u0, tspan, test_p)
nsol = solve(temp_prob)
p1 = plot(nsol)



test_p2 = [0.5, 0.25, -0.05, 0.5, 1.2]
temp_prob2 = SDEProblem(f, g, u0, tspan, test_p2)
nsol2 = solve(temp_prob2)
p2 = plot(nsol2)

plot(p1, p2)
