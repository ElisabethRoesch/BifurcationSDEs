function f_supercritical_pitchfork(x, p, t) # neq
    dx = p[1]*x[1]-x[1]^3
    return [dx]
end
function f_subcritical_pitchfork(x, p, t)
    dx = p[1]*x[1]+x[1]*x[1]*x[1]
    return [dx]
end
function f_transcritical(x, p, t)
   dx = p[1]*x[1]-x[1]*x[1]
   return [dx]
end
function f_saddle_node(x, p, t)
    dx = p[1]-x[1]*x[1]
    return [dx]
end
