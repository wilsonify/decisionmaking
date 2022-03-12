struct InverseReinforcementLearning
    """
    A structure for in    verse reinforcement learning and
    a method for estimating a feature
    expectations vector from rollouts.
    """
    𝒫::Any # problem
    b::Any # initial state distribution
    d::Any # depth
    m::Any # number of samples
    π::Any # parameterized policy
    β::Any # binary feature mapping
    μE::Any # expert feature expectations
    RL::Any # reinforcement learning method
    ϵ::Any # tolerance
end




function feature_expectations(M::InverseReinforcementLearning, π)
    𝒫, b, m, d, β, γ = M.𝒫, M.b, M.m, M.d, M.β, M.𝒫.γ
    μ(τ) = sum(γ^(k - 1) * β(s, a) for (k, (s, a)) in enumerate(τ))
    τs = [simulate(𝒫, rand(b), π, d) for i = 1:m]
    return mean(μ(τ) for τ in τs)
end
