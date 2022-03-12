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
function update(𝒫::POMDP, M::FastInformedBound, Γ)
    𝒮, 𝒜, 𝒪, R, T, O, γ = 𝒫.𝒮, 𝒫.𝒜, 𝒫.𝒪, 𝒫.R, 𝒫.T, 𝒫.O, 𝒫.γ
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

function solve(M::FastInformedBound, 𝒫::POMDP)
    Γ = [zeros(length(𝒫.𝒮)) for a in 𝒫.𝒜]
    Γ = alphavector_iteration(𝒫, M, Γ)
    return AlphaVectorPolicy(𝒫, Γ, 𝒫.𝒜)
end
