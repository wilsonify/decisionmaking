
struct HierarchicalSoftmax
    """
    The hierarchical
softmax model with precision parameter λ and level k . By default,
it starts with an initial joint policy
that assigns uniform probability to
all individual actions.
    """
    λ::Any # precision parameter
    k::Any # level
    π::Any # initial policy
end

function HierarchicalSoftmax(problem::SimpleGame, λ, k)
    π = [SimpleGamePolicy(ai => 1.0 for ai in 𝒜i) for 𝒜i in problem.𝒜]
    return HierarchicalSoftmax(λ, k, π)
end
function solve(M::HierarchicalSoftmax, problem)
    π = M.π
    for k = 1:M.k
        π = [softmax_response(problem, π, i, M.λ) for i in problem.ℐ]
    end
    return π
end
