

function gaussian_kernel(b)
    """
    returns a zero-mean Gaussian kernel φ(x) with bandwidth b.
    """
    return x -> pdf(Normal(0, b), x)
end

function kernel_density_estimate(φ, O)
    """
    Kernel density estimation for a kernel φ and list of observations O.
    """
    return x -> sum([φ(x - o) for o in O]) / length(O)
end
