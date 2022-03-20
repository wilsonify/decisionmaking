"""
Value iteration for POMDPs, 
which finds the dominating h-step plans for a finite horizon POMDP of horizon k_max by 
iteratively constructing optimal subplans. 
The ValueIteration structure is the same as what was defined in algorithm 7.8 in the context of MDPs.
"""
function value_iteration(problem::POMDP, k_max)
    𝒮, 𝒜, R = problem.𝒮, problem.𝒜, problem.R
    plans = [ConditionalPlan(a) for a in 𝒜]
    Γ = [[R(s, a) for s in 𝒮] for a in 𝒜]
    plans, Γ = prune(plans, Γ)
    for k = 2:k_max
        plans, Γ = expand(plans, Γ, problem)
        plans, Γ = prune(plans, Γ)
    end
    return (plans, Γ)
end

function solve(M::ValueIteration, problem::POMDP)
    plans, Γ = value_iteration(problem, M.k_max)
    return LookaheadAlphaVectorPolicy(problem, Γ)
end
