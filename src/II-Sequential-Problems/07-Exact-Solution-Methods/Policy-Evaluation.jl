function lookahead(𝒫::MDP, U, s, a)
    """
    Functions for com        puting the lookahead state-action
        value from a state s given an action
        a using an estimate of the value
        function U for the MDP 𝒫 . The sec        ond version handles the case when
        U is a vector.
    """
    𝒮, T, R, γ = 𝒫.𝒮, 𝒫.T, 𝒫.R, 𝒫.γ
    return R(s, a) + γ * sum(T(s, a, s′) * U(s′) for s′ in 𝒮)
end
function lookahead(𝒫::MDP, U::Vector, s, a)
    𝒮, T, R, γ = 𝒫.𝒮, 𝒫.T, 𝒫.R, 𝒫.γ
    return R(s, a) + γ * sum(T(s, a, s′) * U[i] for (i, s′) in enumerate(𝒮))
end


function iterative_policy_evaluation(𝒫::MDP, π, k_max)
    """
    Iterative policy
evaluation, which iteratively computes the value function for a policy π for MDP 𝒫 with discrete state
and action spaces using k_max iterations.
    """
    𝒮, T, R, γ = 𝒫.𝒮, 𝒫.T, 𝒫.R, 𝒫.γ
    U = [0.0 for s in 𝒮]
    for k = 1:k_max
        U = [lookahead(𝒫, U, s, π(s)) for s in 𝒮]
    end
    return U
end


function policy_evaluation(𝒫::MDP, π)
    """
    Exact policy evaluation, which computes the value
function for a policy π for an MDP
𝒫 with discrete state and action
spaces.
    """
    𝒮, R, T, γ = 𝒫.𝒮, 𝒫.R, 𝒫.T, 𝒫.γ
    R′ = [R(s, π(s)) for s in 𝒮]
    T′ = [T(s, π(s), s′) for s in 𝒮, s′ in 𝒮]
    return (I - γ*T′)\R′
    end