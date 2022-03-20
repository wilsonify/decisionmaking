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
    problem::Any
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
    problem, Uhi, Ulo, δ = π.problem, π.Uhi, π.Ulo, π.δ
    𝒮, 𝒜, 𝒪, R, γ = problem.𝒮, problem.𝒜, problem.𝒪, problem.R, problem.γ
    B = Dict((a, o) => update(b, problem, a, o) for (a, o) in product(𝒜, 𝒪))
    B = merge(B, Dict(() => copy(b)))
    Rmax = maximum(R(s, a) for (s, a) in product(𝒮, 𝒜))
    for (ao, b′) in B
        if !haskey(Uhi, b′)
            Uhi[b′], Ulo[b′] = Rmax / (1.0 - γ), rollout(problem, b′, π.π, d)
        end
    end
    if d == 0 || Uhi[b] - Ulo[b] ≤ δ
        return
    end
    a = argmax(a -> lookahead(problem, b′ -> Uhi[b′], b, a), 𝒜)
    o = argmax(o -> Uhi[B[(a, o)]] - Ulo[B[(a, o)]], 𝒪)
    b′ = update(b, problem, a, o)
    heuristic_search(π, b′, d - 1)
    Uhi[b] = maximum(lookahead(problem, b′ -> Uhi[b′], b, a) for a in 𝒜)
    Ulo[b] = maximum(lookahead(problem, b′ -> Ulo[b′], b, a) for a in 𝒜)
end

function (π::GapHeuristicSearch)(b)
    Uhi, Ulo, k_max, d_max, δ = π.Uhi, π.Ulo, π.k_max, π.d_max, M.δ
    for i = 1:k_max
        heuristic_search(π, b, d_max)
        if Uhi[b] - Ulo[b] < δ
            break
        end
    end
    return argmax(a -> lookahead(problem, b′ -> Ulo[b′], b, a), problem.𝒜)
end
