"""The fast informed
    bound algorithm, which finds an
    approximately optimal policy for
    an infinite horizon POMDP with
    discrete state, action, and observation spaces, where k_max is the
    number of iterations.
"""
struct FastInformedBound
    k_max::Any # maximum number of iterations
end
function update(problem::POMDP, M::FastInformedBound, Γ)
    𝒮, 𝒜, 𝒪, R, T, O, γ = problem.𝒮, problem.𝒜, problem.𝒪, problem.R, problem.T, problem.O, problem.γ
    Γ′ = [
        [
            R(s, a) +
            γ * sum(
                maximum(
                    sum(O(a, s′, o) * T(s, a, s′) * α′[j] for (j, s′) in enumerate(𝒮))
                    for α′ in Γ
                ) for o in 𝒪
            ) for s in 𝒮
        ] for a in 𝒜
    ]
    return Γ′
end

function solve(M::FastInformedBound, problem::POMDP)
    Γ = [zeros(length(problem.𝒮)) for a in problem.𝒜]
    Γ = alphavector_iteration(problem, M, Γ)
    return AlphaVectorPolicy(problem, Γ, problem.𝒜)
end
