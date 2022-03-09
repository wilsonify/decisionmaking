struct LikelihoodRatioGradient
    """
    A method for esti        mating a policy gradient of a pol        icy π(s) for an MDP 𝒫 with initial
        state distribution b using the likeli        hood ratio trick. The gradient with
        respect to the parameterization vec        tor θ is estimated from m rollouts to
        depth d using the log policy gradi        ents ∇logπ .
    """
    𝒫 # problem
    b # initial state distribution
    d # depth
    m # number of samples
    ∇logπ # gradient of log likelihood
    end
    function gradient(M::LikelihoodRatioGradient, π, θ)
    𝒫, b, d, m, ∇logπ, γ = M.𝒫, M.b, M.d, M.m, M.∇logπ, M.𝒫.γ
    πθ(s) = π(θ, s)
    R(τ) = sum(r*γ^(k-1) for (k, (s,a,r)) in enumerate(τ))
    ∇U(τ) = sum(∇logπ(θ, a, s) for (s,a) in τ)*R(τ)
    return mean(∇U(simulate(𝒫, rand(b), πθ, d)) for i in 1:m)
    end