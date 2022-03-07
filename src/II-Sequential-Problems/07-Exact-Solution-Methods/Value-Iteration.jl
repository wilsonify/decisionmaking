function backup(𝒫::MDP, U, s)
    """
    the backup procedure applied to an MDP 𝒫 , which
improves a value function U at state
s .
    """
    return maximum(lookahead(𝒫, U, s, a) for a in 𝒫.𝒜)
end

struct ValueIteration
    """
    Value iteration,
which iteratively improves a value
function U to obtain an optimal policy for an MDP 𝒫 with discrete state
and action spaces. The method terminates after k_max iterations.
    """
    k_max::Any # maximum number of iterations
end
function solve(M::ValueIteration, 𝒫::MDP)
    U = [0.0 for s in 𝒫.𝒮]
    for k = 1:M.k_max
        U = [backup(𝒫, U, s) for s in 𝒫.𝒮]
    end
    return ValueFunctionPolicy(𝒫, U)
end
