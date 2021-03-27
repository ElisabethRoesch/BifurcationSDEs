include("../../../src/includes.jl")

function g_test(dx, x, p, t)
    function diagonal(vec)
        len = length(vec)
        a = zeros(len, len)
        for i in 1:len
            a[i,i] = vec[i]
        end
        return a
    end
    h1 = 2*p[1]*x[1]
    h2 = 4*p[2]*x[1]^3
    if p[3]<0
        h3 = abs(p[3])
    end
    h4 = 4*p[4]*p[2]*x[2]^3
    h5 = 2*p[4]*p[1]*x[1]
    h6 = 4*p[4]*p[2]*x[1]^3
    if p[3]<0
        h7 = p[4]*abs(p[3])
    end
    h8 = 4*p[2]*x[2]^3
    hs = [h1 h2 h3 h4 h5 h6 h7 h8]'
    if p[3]<0
        S = [1 -1 -1 1 0 0 0 0; 0 0 0 0 1 -1 1 -1]
    else
        S = [1 -1 1 1 0 0 0 0; 0 0 0 0 1 -1 -1 -1]
    end
    f = S*hs
    # This for very small vals of hs[i]
    for i in 1:length(hs)
        if hs[i]<0
            hs[i] = 0
        end
    end
    g = S*diagonal(sqrt.(hs))
    dx .= p[5].*g
end

function f_test(dx, x, p, t)
    h1 = 2*p[1]*x[1]
    h2 = 4*p[2]*x[1]^3
    if p[3]<0
        h3 = abs(p[3])
    end
    h4 = 4*p[4]*p[2]*x[2]^3
    h5 = 2*p[4]*p[1]*x[1]
    h6 = 4*p[4]*p[2]*x[1]^3
    if p[3]<0
        h7 = p[4]*abs(p[3])
    end
    h8 = 4*p[2]*x[2]^3
    hs = [h1 h2 h3 h4 h5 h6 h7 h8]'
    if p[3]<0
        S = [1 -1 -1 1 0 0 0 0; 0 0 0 0 1 -1 1 -1]
    else
        S = [1 -1 1 1 0 0 0 0; 0 0 0 0 1 -1 -1 -1]
    end
    f = S*hs
    dx .= f[1,:]
end

x0 = [-1, -1]
sigma_low = 0.
p = [0.5, 0.25, -0.4, 0.5, sigma_low]
prob = SDEProblem(f_test, g_test, x0, (0.0, 1000.0), p, noise_rate_prototype = zeros(2, 8))
nsol = solve(prob)
plot(nsol[1,:])
plot(nsol[2,:])
