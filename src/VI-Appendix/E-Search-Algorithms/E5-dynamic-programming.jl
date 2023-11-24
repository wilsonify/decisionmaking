function dynamic_programming(𝒫::Search, s, d, U, M=Dict())
    """
    Dynamic program-
ming applied to forward search,
which includes a tranposition table
M . Here, M is a dictionary that stores
depth-state tuples from previous
evaluations, allowing the method
to return previously computed re-
sults. The search is performed to
depth d , at which point the termi-
nal value is estimated with an ap-
proximate value function U . The re-
turned named tuple consists of the
best action a and its finite-horizon
expected value u .
    """
    if haskey(M, (d,s))
    return M[(d,s)]
    end
    𝒜, T, R = 𝒫.𝒜(s), 𝒫.T, 𝒫.R
    if isempty(𝒜) || d ≤ 0
    best = (a=nothing, u=U(s))
    else
    best = (a=first(𝒜), u=-Inf)
    for a in 𝒜
    s′ = T(s,a)
    u = R(s,a) + dynamic_programming(𝒫, s′, d-1, U, M).u
    if u > best.u
    best = (a=a, u=u)
    end
    end
    end
    M[(d,s)] = best
    return best
    end