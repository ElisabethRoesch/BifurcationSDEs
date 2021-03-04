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

function g_nd_additive(x, p, t) # 1D: g(x) = sigma (Coomer et al.: Fig 2)
    sigma = p[1]
    dx = fill(sigma, length(x))
    return dx
end

function g_nd_multiplicative_v1(x, p, t) # 1D: g(x) = sigma*x
    sigma = p[1]
    dx = fill(sigma, length(x)).*x
    return dx
end

function g_nd_multiplicative_v2(x, p, t) # 1D: g(x) = sigma/4(x^4 −4*x^2 +8) (Coomer et al.: Fig 3)
    sigma = p[1]
    dx = [sigma/4*(x_temp^4 - 4*x_temp^2 + 8) for x_temp in x]
    return dx
end

function g_nd_multiplicative_v3(x, p, t) # 1D: g(x) = sigma*(1 + x^2) (Coomer et al.: Fig 4)
    sigma = p[1]
    dx = [ sigma*(1 + x_temp^2) for x_temp in x]
    return dx
end

g_nd_additive([1,2,3], [0.1], "")
g_nd_multiplicative_v2([1,2,3], [0.1], "")
g_nd_multiplicative_v1([1,2,3], [0.1], "")
g_nd_multiplicative_v3([1.,2,3], [0.1], "")
