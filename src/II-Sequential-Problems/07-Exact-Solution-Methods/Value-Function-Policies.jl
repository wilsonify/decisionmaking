struct ValueFunctionPolicy
    """
    A value function
    policy extracted from a value func    tion U for an MDP 𝒫 . The greedy
    function will be used in other al    gorithms. This two-argument ver    sion of findmax is defined in ap    pendix G.5.
    """
    𝒫::Any # problem
    U::Any # utility function
end

function greedy(𝒫::MDP, U, s)
    u, a = findmax(a -> lookahead(𝒫, U, s, a), 𝒫.𝒜)
    return (a = a, u = u)
end

(π::ValueFunctionPolicy)(s) = greedy(π.𝒫, π.U, s).a

