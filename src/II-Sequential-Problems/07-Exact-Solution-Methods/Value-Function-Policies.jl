struct ValueFunctionPolicy
    """
    A value function
    policy extracted from a value function U for an MDP problem . 
    The greedy function will be used in other algorithms. 
    This two-argument version of findmax is defined in appendix G.5.
    """
    problem::Any # problem
    U::Any # utility function
end

function greedy(problem::MDP, U, s)
    u, a = findmax(a -> lookahead(problem, U, s, a), problem.𝒜)
    return (a = a, u = u)
end

(π::ValueFunctionPolicy)(s) = greedy(π.problem, π.U, s).a

