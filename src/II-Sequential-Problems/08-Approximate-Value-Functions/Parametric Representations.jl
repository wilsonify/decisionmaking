struct ApproximateValueIteration
    """
    Approximate value
iteration for an MDP with parameterized value function approximation Uθ . We perform backups (defined in algorithm 7.7) at the states
in S to obtain a vector of utilities
U . We then call fit!(Uθ, S, U) ,
which modifies the parametric representation Uθ to better match the
value of the states in S to the utilities in U . Different parametric approximations have different implementations for fit!
    """
    # initial parameterized value function that supports fit!
    Uθ::Any
    S::Any
    # set of discrete states for performing backups
    k_max::Any # maximum number of iterations
end
function solve(M::ApproximateValueIteration, problem::MDP)
    Uθ, S, k_max = M.Uθ, M.S, M.k_max
    for k = 1:k_max
        U = [backup(problem, Uθ, s) for s in S]
        fit!(Uθ, S, U)
    end
    return ValueFunctionPolicy(problem, Uθ)
end
