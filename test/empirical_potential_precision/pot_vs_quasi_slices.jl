using Plots, JLD



alphas = Array(range(-15, stop = 15, length=9))
x = Array(range(-15, stop = 15, length=90))


function f(alpha, n)
    return -(alpha/2)n^2+(1/4)n^4
end
# we only plot inner third
inds= Array(range(31, step=1, stop = 60))
y = [f(alphas[4],i) for i in x]
p1 = plot(x[inds],y[inds], label ="")

file_path = "test/server_tests/anissa_test/plots1/data/rerun_longer_time_span/rep_output_supercritical_pitchfork_potential_rerun_more_inits.jld"
pot = load(file_path)["rep_output_potential"]
det = pot[:,1]
a_l = length(det)
b_l = length(det[1])
as=1:a_l
bs=1:b_l
function f2(a, b)
    return pot[a][b]
end
inds2=Array(range(334, step=1, stop = 666))
ar = Array(bs)
y2 = [f2(44,i) for i in ar]
p2 = plot(ar[inds2], y2[inds2], label = "")




ps = plot(p1, p2, empirical, layout = (1,3), size=(1500,500))


#savefig("test/plots/pot_vs_quasi.pdf")
