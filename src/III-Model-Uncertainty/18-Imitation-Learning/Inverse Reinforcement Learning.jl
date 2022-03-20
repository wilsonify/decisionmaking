struct InverseReinforcementLearning
    """
    A structure for inverse reinforcement learning and
    a method for estimating a feature
    expectations vector from rollouts.
    """
    problem::Any # problem
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
    problem, b, m, d, β, γ = M.problem, M.b, M.m, M.d, M.β, M.problem.γ
    μ(τ) = sum(γ^(k - 1) * β(s, a) for (k, (s, a)) in enumerate(τ))
    τs = [simulate(problem, rand(b), π, d) for i = 1:m]
    return mean(μ(τ) for τ in τs)
end
