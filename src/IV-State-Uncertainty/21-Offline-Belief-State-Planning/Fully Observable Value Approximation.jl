
"""
Iteration structure
for updating a set of alpha vectors Γ used by several of the methods in this chapter. The various
methods, including QMDP, differ
in their implementation of update .
After k_max iterations, this function
returns a policy represented by the
alpha vectors in Γ .
"""
function alphavector_iteration(problem::POMDP, M, Γ)
    for k = 1:M.k_max
        Γ = update(problem, M, Γ)
    end
    return Γ
end


"""
 The QMDP algorithm, which finds an approximately optimal policy for an infinite horizon POMDP with a discrete state and action space, where
k_max is the number of iterations.
QMDP assumes perfect observability.
"""
struct QMDP
    k_max::Any # maximum number of iterations
end
function update(problem::POMDP, M::QMDP, Γ)
    𝒮, 𝒜, R, T, γ = problem.𝒮, problem.𝒜, problem.R, problem.T, problem.γ
    Γ′ = [
        [
            R(s, a) +
            γ * sum(T(s, a, s′) * maximum(α′[j] for α′ in Γ) for (j, s′) in enumerate(𝒮))
            for s in 𝒮
        ] for a in 𝒜
    ]
    return Γ′
end

function solve(M::QMDP, problem::POMDP)
    Γ = [zeros(length(problem.𝒮)) for a in problem.𝒜]
    Γ = alphavector_iteration(problem, M, Γ)
    return AlphaVectorPolicy(problem, Γ, problem.𝒜)
end
