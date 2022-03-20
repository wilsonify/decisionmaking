struct LikelihoodRatioGradient
    """
    A method for estimating a policy gradient of a policy π(s) for an MDP problem with initial
        state distribution b using the likelihood ratio trick. The gradient with
        respect to the parameterization vector θ is estimated from m rollouts to
        depth d using the log policy gradients ∇logπ .
    """
    problem # problem
    b # initial state distribution
    d # depth
    m # number of samples
    ∇logπ # gradient of log likelihood
    end
    function gradient(M::LikelihoodRatioGradient, π, θ)
    problem, b, d, m, ∇logπ, γ = M.problem, M.b, M.d, M.m, M.∇logπ, M.problem.γ
    πθ(s) = π(θ, s)
    R(τ) = sum(r*γ^(k-1) for (k, (s,a,r)) in enumerate(τ))
    ∇U(τ) = sum(∇logπ(θ, a, s) for (s,a) in τ)*R(τ)
    return mean(∇U(simulate(problem, rand(b), πθ, d)) for i in 1:m)
    end