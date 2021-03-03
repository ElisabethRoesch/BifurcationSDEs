# TO DO rename functions so we can implement several multiplicative noises
function g_multiplicative_noise(x, p, t) # noiseeq
    dx = p[2]*x[1]
    return [dx]
end

function g_additive_noise(x, p, t) # noiseeq
    dx = p[2]
    return [dx]
end

function g_2d(x, p, t) #p = [α, λ, β, c, σ]
    x.= p[5]
end

function g_4d_additive(x, p, t)
    sigma = p[1]
    dx = fill(sigma, 10)
    return dx
end

function g_4d_multiplicative_v1(x, p, t)
    sigma = p[1]
    dx = fill(sigma, 10)
    return dx
end


a
a
