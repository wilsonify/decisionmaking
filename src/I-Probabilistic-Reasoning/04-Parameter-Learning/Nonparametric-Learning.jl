gaussian_kernel(b) = x -> pdf(Normal(0, b), x)
"""
The method
gaussian_kernel returns a
zero-mean Gaussian kernel φ(x)
with bandwidth b. Kernel density
estimation is also implemented for
a kernel φ and list of observations
O.
"""
function kernel_density_estimate(φ, O)
    return x -> sum([φ(x - o) for o in O]) / length(O)
end
