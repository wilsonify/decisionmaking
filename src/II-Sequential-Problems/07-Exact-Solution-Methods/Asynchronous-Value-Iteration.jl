struct GaussSeidelValueIteration
    """
    Asynchronous
value iteration, which updates
states in a different manner to
value iteration, often saving computation time. The method terminates after k_max iterations.
    """
    k_max::Any # maximum number of iterations
end
function solve(M::GaussSeidelValueIteration, 𝒫::MDP)
    U = [0.0 for s in 𝒮]
    for k = 1:M.k_max
        for (s, i) in enumerate(𝒫.𝒮)
            U[i] = backup(𝒫, U, s)
        end
    end
    return ValueFunctionPolicy(𝒫, U)
end
