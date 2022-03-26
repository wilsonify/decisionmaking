
"""
A function for
    randomly sampling the next belief
    b′ and reward r given the current
    belief b and action a in problem 𝒫 .
"""
function randstep(𝒫::POMDP, b, a)
    s = rand(SetCategorical(𝒫.𝒮, b))
    s′, r, o = 𝒫.TRO(s, a)
    b′ = update(b, 𝒫, a, o)
    return b′, r
end

"""
An algorithm for
    randomly expanding a finite set
    of beliefs B used in point-based
    value iteration based on reachable
    beliefs.
"""

function random_belief_expansion(𝒫, B)
    B′ = copy(B)
    for b in B
        a = rand(𝒫.𝒜)
        b′, r = randstep(𝒫, b, a)
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
function exploratory_belief_expansion(𝒫, B)
    B′ = copy(B)
    for b in B
        best = (b = copy(b), d = 0.0)
        for a in 𝒫.𝒜
            b′, r = randstep(𝒫, b, a)
            d = minimum(norm(b - b′, 1) for b in B′)
            if d > best.d
                best = (b = b′, d = d)
            end
        end
        push!(B′, best.b)
    end
    return unique!(B′)
end
