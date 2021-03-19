# # TO DO rename functions so we can implement several multiplicative noises
# function g_multiplicative_noise(x, p, t) # noiseeq
#     dx = p[2]*x[1]
#     return [dx]
# end
#
# function g_additive_noise(x, p, t) # noiseeq 1D: g(x) = sigma (Coomer et al.: Fig 2)
#     dx = p[2]
#     return [dx]
# end
#
# function g_2d(x, p, t) #p = [α, λ, β, c, σ]
#     x.= p[5]
# end

function g_nd_additive(dx, x, p, t) # 1D: g(x) = sigma (Coomer et al.: Fig 2)
    sigma = p[end]
    dx .= fill(sigma, length(x))
    return dx
end

function g_nd_multiplicative_v1(dx, x, p, t) # 1D: g(x) = sigma*x
    sigma = p[end]
    dx .= fill(sigma, length(x)).*x
    return dx
end

# Remove:
# function g_nd_multiplicative_v2(x, p, t) # 1D: g(x) = sigma/4(x^4 −4*x^2 +8) (Coomer et al.: Fig 3)
#     sigma = p[1]
#     dx = [sigma/4*(x_temp^4 - 4*x_temp^2 + 8) for x_temp in x]
#     return dx
# end
#
# function g_nd_multiplicative_v3(x, p, t) # 1D: g(x) = sigma*(1 + x^2) (Coomer et al.: Fig 4)
#     sigma = p[1]
#     dx = [ sigma*(1 + x_temp^2) for x_temp in x]
#     return dx
# end


function g_2d_rowan_toy_root(dx, x, p, t) # pos x : g(x) = sqrt(f(x))
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

function g_2d_rowan_toy_CLE(dx, x, p, t) # TO DO

    # propensities:
    h1 = 2*p[1]*x[1]
    h2 = 4*p[2]*x[1]^3
    h3 = p[3]
    h4 = 4*p[4]*p[2]*x[2]^3
    h5 = 2*p[4]*p[1]*x[1]
    h6 = 4*p[4]*p[2]*x[1]^3
    h7 = p[4]*p[3]
    h8 = 4*p[2]*x[2]^3
    hs = [h1, h2, h3, h4;
            h5, h6, h7, h8]
    S = [1 -1 -1 1;
        1, -1, -1, -1]
    res = S*hs*S'
    for i in 1:2
        if dx_f[i] < 0
            dx[i] = -sigma*sqrt(abs(dx_f[i]))
        else
            dx[i] = sigma*sqrt(dx_f[i])
        end
    end
    return dx
end


# Test equations:
# g_nd_additive([1,2,3], [0.1], "")
# g_nd_multiplicative_v2([1,2,3], [0.1], "")
# g_nd_multiplicative_v1([1,2,3], [0.1], "")
# g_nd_multiplicative_v3([1.,2,3], [0.1], "")
# g_2d_rowan_toy_CLE([1., 3], [1., 3], [0.1, 0.1, 0.1, 0.1, 0.1], "")
