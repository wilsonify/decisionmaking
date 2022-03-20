struct PolicyIteration
    """
    Policy iteration,
which iteratively improves an initial policy π to obtain an optimal
policy for an MDP problem with discrete
state and action spaces.
    """
    π::Any # initial policy
    k_max::Any # maximum number of iterations
end
function solve(M::PolicyIteration, problem::MDP)
    π, 𝒮 = M.π, problem.𝒮
    for k = 1:M.k_max
        U = policy_evaluation(problem, π)
        π′ = ValueFunctionPolicy(problem, U)
        if all(π(s) == π′(s) for s in 𝒮)
            break
        end
        π = π′
    end
    return π
end


