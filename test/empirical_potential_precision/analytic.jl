using Plots, JLD



function stable1(al)
    if al > 0
        return sqrt(al)
    end
    return 0
end
function stable2(al)
    if al > 0
        return -sqrt(al)
    end
    return 0
end
function unstable(al)
    return 0
end
alphas = Array(range(-15, stop = 15, length=9))
x = Array(range(-15, stop = 15, length=90))
bifur_dia = plot(alphas, unstable, axis = nothing, label = "unstable", line = :dash, color ="black", grid = "off")
plot!(x,stable1,  xlabel = "α", ylabel = "X",legend = :topleft, label ="stable" ,color ="black")
plot!(x,stable2, legend = :topleft, label ="" ,color ="black", ylim = (-5,5))


function f(alpha, n)
    return -(alpha/2)*(n^2)+(1/4)*(n^4)
end
ns = Array(range(-5, stop = 5, length =10))
analytic = contourf(alphas, ns, f, xlab = "α", ylab = "X", legend = false, ylim = (-5,5), axis = nothing)

# For testing subtle diffs in stable and unstable fixed points
# a= []
# xsm = Array(range(-3, stop = 3, length=90))
# for j in xsm
#     push!(a, f(2,j))
# end
# f(2,sqrt(2))
# f(2,0)
# test = scatter(x, a.+1)


file_path = "test/data/rerun_longer_time_span/rep_output_supercritical_pitchfork_potential_rerun_more_sdes_longer_time_span.jld"
pot = load(file_path)["rep_output_potential"]
det = pot[:,1]
function plot_contour_pot(pot) # r_pitch_det
    a_l = length(pot)
    b_l = length(pot[1])
    as=1:a_l
    bs=1:b_l
    function f(a, b)
        return pot[a][b]
    end
    cf_pot = contourf(as, bs, f, xlabel = "α", ylabel = "X", legend =false, axis = nothing)
    return cf_pot
end
empirical = plot_contour_pot(det)

function myfind(c)
    a = similar(c, Int)
    count = 1
    @inbounds for i in eachindex(c)
        a[count] = i
        count += (c[i] != zero(eltype(c)))
    end
    return resize!(a, count-1)
end

# Testing singularity consequences
# A = det[6]
# B = myfind(A)
# plot(A)

ps = plot(bifur_dia, analytic, empirical, layout = (1,3), size=(1500,500))
savefig("test/plots/empirical_vs_analytic_det.pdf")
