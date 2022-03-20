using ForwardDiff
"""
    The expansion
    step in value iteration, which constructs all k + 1-step conditional
    plans and associated alpha vectors
    from a set of k-step conditional
    plans and alpha vectors. The way
    we combine alpha vectors of subplans follows equation (20.17).
"""
function ConditionalPlan(problem::POMDP, a, plans)
    subplans = Dict(o => π for (o, π) in zip(problem.𝒪, plans))
    return ConditionalPlan(a, subplans)
end
function combine_lookahead(problem::POMDP, s, a, Γo)
    𝒮, 𝒪, T, O, R, γ = problem.𝒮, problem.𝒪, problem.T, problem.O, problem.R, problem.γ
    U′(s′, i) = sum(O(a, s′, o) * α[i] for (o, α) in zip(𝒪, Γo))
    return R(s, a) + γ * sum(T(s, a, s′) * U′(s′, i) for (i, s′) in enumerate(𝒮))
end


function combine_alphavector(problem::POMDP, a, Γo)
    return [combine_lookahead(problem, s, a, Γo) for s in problem.𝒮]
end
function expand(plans, Γ, problem)
    𝒮, 𝒜, 𝒪, T, O, R = problem.𝒮, problem.𝒜, problem.𝒪, problem.T, problem.O, problem.R
    plans′, Γ′ = [], []
    for a in 𝒜
        # iterate over all possible mappings from observations to plans
        for inds in product([eachindex(plans) for o in 𝒪]...)
            πo = plans[[inds...]]
            Γo = Γ[[inds...]]
            π = ConditionalPlan(problem, a, πo)
            α = combine_alphavector(problem, a, Γo)
            push!(plans′, π)
            push!(Γ′, α)
        end
    end
    return (plans′, Γ′)
end
