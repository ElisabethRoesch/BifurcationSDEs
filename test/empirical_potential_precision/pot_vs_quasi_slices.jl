using Plots, JLD

function plot_slice_comp(alphas, x, ind_pot, ind_quasi)
    function f(alpha, n)
        return -(alpha/2)n^2+(1/4)n^4
    end
    # we only plot inner third
    inds = Array(range(23, step = 1, stop = 68))
    y = [f(alphas[ind_pot], i) for i in x]
    p1 = plot(x[inds], y[inds], label = "", grid = "off", color= "#5ba95d", ylim = (-10, 150))
    savefig(string("test/plots/pot_slices_$ind_pot","$ind_quasi.pdf"))
    file_path = "test/server_tests/anissa_test/plots1/data/rerun_longer_time_span/rep_output_supercritical_pitchfork_potential_rerun_more_inits.jld"
    pot = load(file_path)["rep_output_potential"]
    det = pot[:,1]
    a_l = length(det)
    b_l = length(det[1])
    as = 1:a_l
    bs = 1:b_l
    function f2(a, b)
        return pot[a][b]
    end
    inds2 = Array(range(1, step = 1, stop = 1000))
    ar = Array(bs)
    y2 = [f2(ind_quasi, i) for i in ar]
    p2 = plot(ar[inds2], y2[inds2], label = "", grid = "off", color= "#5ba95d", ylim = (-2.3,0))
    savefig(string("test/plots/quasi_pot_slices_$ind_pot","$ind_quasi.pdf"))
    return p1, p2
end

alphas = Array(range(-15, stop = 15, length = 9))
x = Array(range(-15, stop = 15, length = 90))
neg_ind_pot = 4
neg_ind_quasi = 40
zero_ind_pot = 5
zero_ind_quasi = 50
pos_ind_pot = 6
pos_ind_quasi = 60
neg_pot_p, neg_quasi_p = plot_slice_comp(alphas, x, neg_ind_pot, neg_ind_quasi)
zero_pot_p, zero_quasi_p = plot_slice_comp(alphas, x, zero_ind_pot, zero_ind_quasi)
pos_pot_p, pos_quasi_p = plot_slice_comp(alphas, x, pos_ind_pot, pos_ind_quasi)
plot(neg_pot_p)
ps = plot(neg_pot_p, zero_pot_p, pos_pot_p, layout = (1, 3), size = (2000, 1000))
# savefig("test/plots/pot_slices.pdf")
ps = plot(neg_quasi_p, zero_quasi_p, pos_quasi_p, layout = (1, 3), size = (2000, 1000))
# savefig("test/plots/quasi_slices.pdf")
