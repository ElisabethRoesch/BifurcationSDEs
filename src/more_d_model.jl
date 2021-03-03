# TO DO: FIX x should be dx
function f_2d(x, p, t) #p = [α, λ, β,c, σ]
    x[1] = 2*p[1]*x[1]-4*p[2]*x[1]^3-p[3]+4*p[4]*p[2]*x[2]^3
    x[2] = 2*p[4]*p[1]*x[1]-4*p[4]*p[2]*x[1]^3-p[4]*p[3]+4*p[2]*x[2]^3
    return  x
end

function f_4d(x, p, t) # x = N, OS, FGF, G
    N, OS, FGF, G = x
    dN = # dN = dividend/divisor - subtrahend
        (k0*OS*(c0+c1*N^2+k0*OS+c2*LIF)) #  dividend
        /
        (1+(k0*OS*(c1*N^2+k0*OS+c2*LIF+c3*FGF^2))+c4*OS*G^2)  # divisor
        - gamma*N   #subtrahend
    dOS =  # dN = addend + dividend/divisor - subtrahend
        alpha # addend
        + (e0+e1*OS)  #  dividend
        /
        (1+e1*OS+e2*G^2)   # divisor
        - gamma*OS  #subtrahend
    dFGF = ()/()- gamma*FGF
    dG = ()/() - gamma*G
    dx = [dN, dOS, dFGF, dG]
    return dx
end


a
dx = Array{Float64}(undef, 4)
