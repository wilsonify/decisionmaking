"""
    The expansion
    step in value iteration, which con-
    structs all k + 1-step conditional
    plans and associated alpha vectors
    from a set of k-step conditional
    plans and alpha vectors. The way
    we combine alpha vectors of sub-
    plans follows equation (20.17).
"""
function ConditionalPlan(𝒫::POMDP, a, plans)
    subplans = Dict(o => π for (o, π) in zip(𝒫.𝒪, plans))
    return ConditionalPlan(a, subplans)
end
function combine_lookahead(𝒫::POMDP, s, a, Γo)
    𝒮, 𝒪, T, O, R, γ = 𝒫.𝒮, 𝒫.𝒪, 𝒫.T, 𝒫.O, 𝒫.R, 𝒫.γ
    U′(s′, i) = sum(O(a, s′, o) * α[i] for (o, α) in zip(𝒪, Γo))
    return R(s, a) + γ * sum(T(s, a, s′) * U′(s′, i) for (i, s′) in enumerate(𝒮))
end


function combine_alphavector(𝒫::POMDP, a, Γo)
    return [combine_lookahead(𝒫, s, a, Γo) for s in 𝒫.𝒮]
end
function expand(plans, Γ, 𝒫)
    𝒮, 𝒜, 𝒪, T, O, R = 𝒫.𝒮, 𝒫.𝒜, 𝒫.𝒪, 𝒫.T, 𝒫.O, 𝒫.R
    plans′, Γ′ = [], []
    for a in 𝒜
        # iterate over all possible mappings from observations to plans
        for inds in product([eachindex(plans) for o in 𝒪]...)
            πo = plans[[inds...]]
            Γo = Γ[[inds...]]
            π = ConditionalPlan(𝒫, a, πo)
            α = combine_alphavector(𝒫, a, Γo)
            push!(plans′, π)
            push!(Γ′, α)
        end
    end
    return (plans′, Γ′)
end
