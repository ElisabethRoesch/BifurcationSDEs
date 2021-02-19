function f_2d_rowan(x, p, t) #p = [α, λ, β,c, σ]
    dx1 = 2*p[1]*x[1]-4*p[2]*x[1]^3-p[3]+4*p[4]*p[2]*x[2]^3
    dx2 = 2*p[4]*p[1]*x[1]-4*p[4]*p[2]*x[1]^3-p[4]*p[3]+4*p[2]*x[2]^3
    return = [dx1, dx2]
end
function g_2d_rowan(x, p, t) #p = [α, λ, β, c, σ]
    dx.= p[5]
end
