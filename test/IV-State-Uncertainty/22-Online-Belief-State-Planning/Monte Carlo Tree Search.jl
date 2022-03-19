struct HistoryMonteCarloTreeSearch
    """
    Monte Carlo tree
    search for POMDPs from belief
    b . The initial history h is optional.
    This implementation is similar to
    the one in algorithm 9.5.
    """
    𝒫::Any # problem
    N::Any # visit counts
    Q::Any # action value estimates
    d::Any # depth
    m::Any # number of simulations
    c::Any # exploration constant
    U::Any # value function estimate
end

function explore(π::HistoryMonteCarloTreeSearch, h)
    𝒜, N, Q, c = π.𝒫.𝒜, π.N, π.Q, π.c
    Nh = sum(get(N, (h, a), 0) for a in 𝒜)
    return argmax(a -> Q[(h, a)] + c * bonus(N[(h, a)], Nh), 𝒜)
end
function simulate(π::HistoryMonteCarloTreeSearch, s, h, d)
    if d ≤ 0
        return π.U(s)
    end
    𝒫, N, Q, c = π.𝒫, π.N, π.Q, π.c
    𝒮, 𝒜, TRO, γ = 𝒫.𝒮, 𝒫.𝒜, 𝒫.TRO, 𝒫.γ
    if !haskey(N, (h, first(𝒜)))
        for a in 𝒜
            N[(h, a)] = 0
            Q[(h, a)] = 0.0
        end
        return π.U(s)
    end
    a = explore(π, h)
    s′, r, o = TRO(s, a)
    q = r + γ * simulate(π, s′, vcat(h, (a, o)), d - 1)
    N[(h, a)] += 1
    Q[(h, a)] += (q - Q[(h, a)]) / N[(h, a)]
    return q
end
function (π::HistoryMonteCarloTreeSearch)(b, h = [])
    for i = 1:π.m
        s = rand(SetCategorical(π.𝒫.𝒮, b))
        simulate(π, s, h, π.d)
    end
    return argmax(a -> π.Q[(h, a)], π.𝒫.𝒜)
end
