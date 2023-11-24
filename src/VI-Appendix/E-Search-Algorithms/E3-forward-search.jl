

function forward_search(𝒫::Search, s, d, U)
    𝒜, T, R = 𝒫.𝒜(s), 𝒫.T, 𝒫.R
    if isempty(𝒜) || d ≤ 0
    return (a=nothing, u=U(s))
    end
    best = (a=nothing, u=-Inf)
    for a in 𝒜
    s′ = T(s,a)
    u = R(s,a) + forward_search(𝒫, s′, d-1, U).u
    if u > best.u
    best = (a=a, u=u)
    end
    end
    return best
    end