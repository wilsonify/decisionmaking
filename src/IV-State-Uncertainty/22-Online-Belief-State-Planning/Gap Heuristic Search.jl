struct GapHeuristicSearch
    """
    An implementation of heuristic search that uses
    bounds, a gap criterion, and a rollout policy as its heuristic. The upper and lower bounds are maintained by Uhi and Ulo , respectively.
    The rollout policy π must be a function that returns an action given
    a belief π(b) . At belief b , the gap
    is Uhi[b] - Ulo[b] . Exploration
    stops when the gap is smaller than
    the threshold δ or the maximum
    depth d_max is reached. A maximum number of iterations k_max
    is allotted to search.
    """
    # problem
    𝒫::Any
    Uhi::Any
    # upper bound on value function
    Ulo::Any
    # lower bound on value function
    π::Any
    # rollout policy
    δ::Any
    # gap threshold
    k_max::Any # maximum number of simulations
    d_max::Any # maximum depth
end
function heuristic_search(π::GapHeuristicSearch, b, d)
    𝒫, Uhi, Ulo, δ = π.𝒫, π.Uhi, π.Ulo, π.δ
    𝒮, 𝒜, 𝒪, R, γ = 𝒫.𝒮, 𝒫.𝒜, 𝒫.𝒪, 𝒫.R, 𝒫.γ
    B = Dict((a, o) => update(b, 𝒫, a, o) for (a, o) in product(𝒜, 𝒪))
    B = merge(B, Dict(() => copy(b)))
    Rmax = maximum(R(s, a) for (s, a) in product(𝒮, 𝒜))
    for (ao, b′) in B
        if !haskey(Uhi, b′)
            Uhi[b′], Ulo[b′] = Rmax / (1.0 - γ), rollout(𝒫, b′, π.π, d)
        end
    end
    if d == 0 || Uhi[b] - Ulo[b] ≤ δ
        return
    end
    a = argmax(a -> lookahead(𝒫, b′ -> Uhi[b′], b, a), 𝒜)
    o = argmax(o -> Uhi[B[(a, o)]] - Ulo[B[(a, o)]], 𝒪)
    b′ = update(b, 𝒫, a, o)
    heuristic_search(π, b′, d - 1)
    Uhi[b] = maximum(lookahead(𝒫, b′ -> Uhi[b′], b, a) for a in 𝒜)
    Ulo[b] = maximum(lookahead(𝒫, b′ -> Ulo[b′], b, a) for a in 𝒜)
end

function (π::GapHeuristicSearch)(b)
    Uhi, Ulo, k_max, d_max, δ = π.Uhi, π.Ulo, π.k_max, π.d_max, M.δ
    for i = 1:k_max
        heuristic_search(π, b, d_max)
        if Uhi[b] - Ulo[b] < δ
            break
        end
    end
    return argmax(a -> lookahead(𝒫, b′ -> Ulo[b′], b, a), 𝒫.𝒜)
end
