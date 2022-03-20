struct SparseSampling
    """
    The sparse sampling algorithm for finding of an
approximately optimal action online for a discrete problem problem from
a current state s to depth d with m
samples per action. The returned
named tuple consists of the best
action a and its finite-horizon expected value u .
    """
    problem::Any # problem
    d::Any # depth
    m::Any # number of samples
    U::Any # value function at depth d
end
function sparse_sampling(problem, s, d, m, U)
    if d ≤ 0
        return (a = nothing, u = U(s))
    end
    best = (a = nothing, u = -Inf)
    for a in problem.𝒜
        u = 0.0
        for i = 1:m
            s′, r = randstep(problem, s, a)
            a′, u′ = sparse_sampling(problem, s′, d - 1, m, U)
            u += (r + problem.γ * u′) / m
        end
        if u > best.u
            best = (a = a, u = u)
        end
    end
    return best
end
(π::SparseSampling)(s) = sparse_sampling(π.problem, s, π.d, π.m, π.U).a
