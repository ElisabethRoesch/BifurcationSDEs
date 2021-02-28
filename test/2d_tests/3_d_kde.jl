using KernelDensityEstimate
using KernelDensityEstimatePlotting
pd2 = kde!(randn(3,100));
@time pd2 = kde!(randn(3,100)); # defaults to loocv
pm12 = marginal(pd2,[1;2]);
pm2 = marginal(pm12,[2]);
plot(pm2);
