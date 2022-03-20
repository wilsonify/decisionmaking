
struct SawtoothHeuristicSearch
    """
    The sawtooth
    heuristic search policy. The solver
    starts from belief b and explores to
    a depth d for no more than k_max
    iterations. It uses an upper bound
    obtained through the fast informed
    bound computed with k_fib iterations.
    The lower bound is obtained from the best-action worststate bound. The gap threshold is
    δ .
    """

    b::Any # initial belief
    δ::Any # gap threshold
    d::Any # depth
    k_max::Any # maximum number of iterations
    k_fib::Any # number of iterations for fast informed bound
end
function explore!(M::SawtoothHeuristicSearch, problem, πhi, πlo, b, d = 0)
    𝒮, 𝒜, 𝒪, γ = problem.𝒮, problem.𝒜, problem.𝒪, problem.γ
    ϵ(b′) = utility(πhi, b′) - utility(πlo, b′)
    if d ≥ M.d || ϵ(b) ≤ M.δ / γ^d
        return
    end
    a = πhi(b)
    o = argmax(o -> ϵ(update(b, problem, a, o)), 𝒪)
    b′ = update(b, problem, a, o)
    explore!(M, problem, πhi, πlo, b′, d + 1)
    if b′ ∉ basis(problem)
        πhi.V[b′] = greedy(πhi, b′).u
    end
    push!(πlo.Γ, backup(problem, πlo.Γ, b′))
end

function solve(M::SawtoothHeuristicSearch, problem::POMDP)
    πfib = solve(FastInformedBound(M.k_fib), problem)
    Vhi = Dict(e => utility(πfib, e) for e in basis(problem))
    πhi = SawtoothPolicy(problem, Vhi)
    πlo = LookaheadAlphaVectorPolicy(problem, [baws_lowerbound(problem)])
    for i = 1:M.k_max
        explore!(M, problem, πhi, πlo, M.b)
        if utility(πhi, M.b) - utility(πlo, M.b) < M.δ
            break
        end
    end
    return πlo
end
