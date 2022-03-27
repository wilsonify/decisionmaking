function branch_and_bound(𝒫::Search, s, d, Ulo, Qhi)
    """
    The branch and bound search algorithm for finding an approximately optimal action 
    for a discrete search problem 𝒫 from a current state s . 
    The search is performed to depth d with value function lower bound Ulo 
    and action value function upper bound Qhi . 
    The returned named tuple consists of the best action a and its finite-horizon expected value u .
    """

    𝒜, T, R = 𝒫.𝒜(s), 𝒫.T, 𝒫.R
    if isempty(𝒜) || d ≤ 0
    return (a=nothing, u=Ulo(s))
    end
    best = (a=nothing, u=-Inf)
    for a in sort(𝒜, by=a->Qhi(s,a), rev=true)
    if Qhi(s,a) ≤ best.u
    return best # safe to prune
    end
    u = R(s,a) + branch_and_bound(𝒫,T(s,a),d-1,Ulo,Qhi).u
    if u > best.u
    best = (a=a, u=u)
    end
    end
    return best
    end