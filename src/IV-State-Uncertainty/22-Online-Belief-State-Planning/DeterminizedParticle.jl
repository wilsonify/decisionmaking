struct DeterminizedParticle
    """
    The determinized
    particle belief update used in determinized sparse tree search for a
    POMDP problem . Each belief b consists of
    particles ϕ that each encode a particular scenario and depth along
    the scenario. Their scenario’s trajectory is determinized through a
    matrix Φ containing random values
    in [ 0, 1 ] . Each particle ϕ represents
    a particular scenario i at a particular depth j , referring to the i th row
    and j th column of Φ .
    """
    s::Any # state
    i::Any # scenario index
    j::Any # depth index
end
function successor(problem, Φ, ϕ, a)
    𝒮, 𝒪, T, O = problem.𝒮, problem.𝒪, problem.T, problem.O
    p = 0.0
    for (s′, o) in product(𝒮, 𝒪)
        p += T(ϕ.s, a, s′) * O(a, s′, o)
        if p ≥ Φ[ϕ.i, ϕ.j]
            return (s′, o)
        end
    end
    return last(𝒮), last(𝒪)
end

function possible_observations(problem, Φ, b, a)
    𝒪 = []
    for ϕ in b
        s′, o = successor(problem, Φ, ϕ, a)
        push!(𝒪, o)
    end
    return unique(𝒪)
end
function update(b, Φ, problem, a, o)
    b′ = []
    for ϕ in b
        s′, o′ = successor(problem, Φ, ϕ, a)
        if o == o′
            push!(b′, DeterminizedParticle(s′, ϕ.i, ϕ.j + 1))
        end
    end
    return b′
end
