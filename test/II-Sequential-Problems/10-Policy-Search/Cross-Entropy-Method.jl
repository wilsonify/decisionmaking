struct CrossEntropyPolicySearch
    """
    Cross entropy policy search, which iteratively improves a search distribution initially set to p . This algorithm takes
as input a parameterized policy
π(θ, s) and a policy evaluation
function U . In each iteration, m
samples are drawn and the top
m_elite are used to refit the distribution. The algorithm terminates after k_max iterations. The
distribution p can be defined using the Distributions.jl package. 
    """
    # initial distribution
    p::Any
    m::Any
    # number of samples
    m_elite::Any # number of elite samples
    k_max::Any
    # number of iterations
end
function optimize_dist(M::CrossEntropyPolicySearch, π, U)
    p, m, m_elite, k_max = M.p, M.m, M.m_elite, M.k_max
    for k = 1:k_max
        θs = rand(p, m)
        us = [U(π, θs[:, i]) for i = 1:m]
        θ_elite = θs[:, sortperm(us)[(m-m_elite+1):m]]
        p = Distributions.fit(typeof(p), θ_elite)
    end
    return p
end
function optimize(M, π, U)
    return Distributions.mode(optimize_dist(M, π, U))
end
