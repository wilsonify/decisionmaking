"""
    Value iteration for
    POMDPs, which finds the domi-
    nating h-step plans for a finite hori-
    zon POMDP of horizon k_max by it-
    eratively constructing optimal sub-
    plans. The ValueIteration struc-
    ture is the same as what was de-
    fined in algorithm 7.8 in the con-
    text of MDPs.
"""
function value_iteration(𝒫::POMDP, k_max)
    𝒮, 𝒜, R = 𝒫.𝒮, 𝒫.𝒜, 𝒫.R
    plans = [ConditionalPlan(a) for a in 𝒜]
    Γ = [[R(s, a) for s in 𝒮] for a in 𝒜]
    plans, Γ = prune(plans, Γ)
    for k = 2:k_max
        plans, Γ = expand(plans, Γ, 𝒫)
        plans, Γ = prune(plans, Γ)
    end
    return (plans, Γ)
end

function solve(M::ValueIteration, 𝒫::POMDP)
    plans, Γ = value_iteration(𝒫, M.k_max)
    return LookaheadAlphaVectorPolicy(𝒫, Γ)
end
