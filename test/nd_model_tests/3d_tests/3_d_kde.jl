using KernelDensityEstimate
setForceEvalDirect!(false)
using KernelDensityEstimatePlotting
data = rand(3,100)
pd33 = kde!(data)
pd33(v)
#evaluate(pd33,randn(4))
p1 = KernelDensityEstimatePlotting.plot(pd33)
ms = pd33.means

v = hcat([0;0;0.0], [1;0;0.0])



for d in ds
function eval_pdf(temp_kde, temp_v)
    pdf_v = temp_kde(temp_v)
    return pdf_v
end

function generate_v_grid(ranges)
    a = [-2:0.1:2;]

    return
end


eval_pdf(p2, [1,2;])


p2([1 2])
p1 = kde!(randn(1,100))
p2 = kde!(randn(2,100))

r1 = [-2:0.1:2;]
r2 = [-2:0.1:2;]
d = 2
vs = Matrix{Float64}(undef, d, length(r1)*length(r2))
n,m = length(r1), length(r2)

for i in 1:n
    for j in  1:m
        v = [r1[i],r2[j]]
        vs[:,(i-1)*n+j] = v
    end
end

pdfs = p2(vs)



r3 = [-2:0.1:2;]
ranges = [r1, r2, r3]

d = length(ranges)
for d in
pdfs = Array{Float64,2}(undef, length(r1), length(r2))
for i in 1:n
    for j in  1:m
        pdf_v = eval_pdf(p2, vs[i,j])
        pdfs[i,j] = pdf_v
    end
end

vs_1 = [r1;]
vs_2 = [r2;]


KernelDensityEstimatePlotting.plot(a)
using Plots
Plots.plot(ms)
Plots.plot(ms[1:100])
using Gadfly
# hstack(p1 , p2 , p3)
dat = randn(2,100)
pd = kde!(dat)
pm12 = marginal(pd,[1;2])
pm1 = marginal(pd,[1])
pm2 = marginal(pd,[2])
p1 = plot(pm1)
p2 = plot(pm2)
hstack(p1 , p2)


using KernelDensity, Plots
data = rand(100)
kde_data = kde(data)
arr_pdf = pdf(kde_data,-5.0:0.01:5.0)
plot(arr_pdf)
# Wollen: pdf in array from.
# Plan: hard code for 2d, see if it works. compare with kd package
# if yes, dann 3 d
# if yes dann n d
# if yes dann in pot function.







include("../../src/includes.jl")

setForceEvalDirect!(false)
bifur_type = "2d_model"
test_list_alpha, test_list_sigma = Array(range(-5, stop = 5.0, length = 9)), Array(range(0., stop = 2., length = 4))

# to run
tspan = (0.0, 2.0)
timepoints = 0.2:0.2:2.0
initpoints = [range(-10, stop = 10, length = 10), range(-10, stop = 10, length = 10)]
npoints = 20
test_prob_arg_list = [f_2d, g_2d, tspan, initpoints, timepoints, npoints]

temp_f, temp_g, temp_tspan, initpoints, timepoints, npoints = test_prob_arg_list
temp_p = [0.5, 0.25, -0.05, 0.5, 0.4]
n_states = length(initpoints)
temp_outputs = [Float64[]  for j in 1:n_states]
for i in 1:length(initpoints)
        x0 = [initpoints[i][j] for j in 1:n_states]
        temp_prob = SDEProblem(temp_f, temp_g, x0, temp_tspan, temp_p)
        for j in 1:npoints
            nsol = Array(solve(temp_prob, saveat = timepoints))
            for state in 1:n_states
                append!(temp_outputs[state], nsol[state,:])
            end
        end
end

len = length(temp_outputs[1])
in = Array{Float64,2}(undef, 2, len)
in[1,:] = temp_outputs[1]
in[2,:] = temp_outputs[2]
size(in)

pdf2 = kde!(in)
r1 = [-5.0:0.01:5.0;]
r2 = [-5.0:0.01:5.0;]
d = 2
vs = Matrix{Float64}(undef, d, length(r1)*length(r2))
n,m = length(r1), length(r2)
for i in 1:n
    for j in  1:m
        v = [r1[i],r2[j]]
        vs[:,(i-1)*n+j] = v
    end
end
pdfs = pdf2(vs)
pdfs_shift = pdfs.+1
potential = -log.(pdfs_shift)
potential_matrix = reshape(potential, (n,m))



contour(potential_matrix)
