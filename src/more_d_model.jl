function f_2d(x, p, t) #p = [α, λ, β,c, σ]
    x[1] = 2*p[1]*x[1]-4*p[2]*x[1]^3-p[3]+4*p[4]*p[2]*x[2]^3
    x[2] = 2*p[4]*p[1]*x[1]-4*p[4]*p[2]*x[1]^3-p[4]*p[3]+4*p[2]*x[2]^3
    return  x
end
function g_2d(x, p, t) #p = [α, λ, β, c, σ]
    x.= p[5]
end
