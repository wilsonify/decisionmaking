

struct ValueIteration
    """
    iteratively improves a value function U to obtain an optimal policy for an MDP problem with discrete state and action spaces. 
    The method terminates after k_max iterations.
    """
    k_max::Any # maximum number of iterations
end

function solve(M::ValueIteration, problem::MDP)
    U = [0.0 for s in problem.𝒮]
    for k = 1:M.k_max
        U = [backup(problem, U, s) for s in problem.𝒮]
    end
    return ValueFunctionPolicy(problem, U)
end
