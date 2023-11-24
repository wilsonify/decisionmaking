
"""
A function for
    randomly sampling the next belief
    b′ and reward r given the current
    belief b and action a in problem problem .
"""
function randstep(problem::POMDP, b, a)
    s = rand(SetCategorical(problem.𝒮, b))
    s′, r, o = problem.TRO(s, a)
    b′ = update(b, problem, a, o)
    return b′, r
end

"""
An algorithm for
    randomly expanding a finite set
    of beliefs B used in point-based
    value iteration based on reachable
    beliefs.
"""

function random_belief_expansion(problem, B)
    B′ = copy(B)
    for b in B
        a = rand(problem.𝒜)
        b′, r = randstep(problem, b, a)
        push!(B′, b′)
    end
    return unique!(B′)
end

"""
An algorithm for
    expanding a finite set of beliefs B
    used in point-based value iteration
    by exploring the reachable beliefs
    and adding those that are furthest
    from the current beliefs.
"""
function exploratory_belief_expansion(problem, B)
    B′ = copy(B)
    for b in B
        best = (b = copy(b), d = 0.0)
        for a in problem.𝒜
            b′, r = randstep(problem, b, a)
            d = minimum(norm(b - b′, 1) for b in B′)
            if d > best.d
                best = (b = b′, d = d)
            end
        end
        push!(B′, best.b)
    end
    return unique!(B′)
end
