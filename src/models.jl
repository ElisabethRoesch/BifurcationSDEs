function f_2d_rowan_toy(dx,x,p,t) #p = [α, λ, β, c, σ]
    alpha = p[1]
    lamda = p[2]
    beta = p[3]
    c = p[4]
    sigma = p[5]

    dx[1] = 2*alpha*x[1]
        -4*lamda*x[1]^3
        -beta
        +4*c*lamda*x[2]^3
    dx[2] = 2*c*alpha*x[1]
        -4*c*lamda*x[1]^3
        -c*beta
        -4*lamda*x[2]^3

    # dx[1] = 4*lamda*x[2]^3
    # dx[2] = 2*alpha*x[1]
    #     -4*lamda*x[1]^3
    #     -beta

    # dx[1] = 2*alpha*x[1]
    #     -4*lamda*x[1]^3
    #     -beta
    # dx[2] = -4*lamda*x[2]^3

    return  dx
end

function f_2d_gardner(x, p, t)
    u, v = x
    alpha1, beta, alpha2, gamma = p
    du = alpha1/(1+v^beta)-u
    dv = alpha2/(1+u^gamma)-v
    return [du, dv]
end

function f_4d_dev_model(x, p, t)
    N, OS, FGF, G = x
    alpha, gamma,   k0,     c0, c1, c2, c3, c4,     e0, e1, e2,     a0, a1, a2,     b0, b1, b2, b3,     LIF, I3  = p
    dN = # dN = dividend/divisor - subtrahend
        (k0*OS*(c0+c1*N^2+k0*OS+c2*LIF))    # dividend
        /
        (1+(k0*OS*(c1*N^2+k0*OS+c2*LIF+c3*FGF^2))+c4*OS*G^2)  # divisor
        - gamma*N   #subtrahend
    dOS =  # dN = addend + dividend/divisor - subtrahend
        alpha   # addend
        + (e0+e1*OS)    # dividend
        /
        (1+e1*OS+e2*G^2)    # divisor
        - gamma*OS  #subtrahend
    dFGF = # dFGF = dividend/divisor - subtrahend
        (a0+a1*OS)  # dividend
        /
        (1+a1*OS+a2*I3) # divisor
        - gamma*FGF # subtrahend
    dG = # dG = dividend/divisor - subtrahend
        (b0+b1*G^2+b3*OS) # dividend
        /
        (1+b1*G^2+b2*N^2+b3*OS) # divisor
        - gamma*G # subtrahend
    dx = [dN, dOS, dFGF, dG]
    return dx
end


# Test equations:
# f_2d_rowan_toy([1,2], [0.1, 0.1, 0.1, 0.1, 0.1], "")
# f_2d_gardner([1,2], [0.1, 0.1, 0.1, 0.1], "")
# f_4d_dev_model([1,2,3,4], [0.1, 0.1, 0.1, 0.1, 0.1, 0.1, 0.1, 0.1, 0.1, 0.1, 0.1, 0.1, 0.1, 0.1, 0.1, 0.1, 0.1, 0.1, 0.1, 0.1], "")
