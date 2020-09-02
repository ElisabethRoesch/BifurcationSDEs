function g_multiplicative_noise(x, p, t) # noiseeq
    dx = p[2]*x[1]
    return [dx]
end
# TO DO -- add other noise functions
