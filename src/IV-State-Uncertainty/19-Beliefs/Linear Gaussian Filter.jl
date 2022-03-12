"""
A method that
updates a discrete belief based on
equation (19.7), where b is a vec-
tor and 𝒫 is the POMDP model. If
the given observation has a zero
likelihood, a uniform distribution
is returned.
"""
function update(b::Vector{Float64}, 𝒫, a, o)
    𝒮, T, O = 𝒫.𝒮, 𝒫.T, 𝒫.O
    b′ = similar(b)
    for (i′, s′) in enumerate(𝒮)
    po = O(a, s′, o)
    b′[i′] = po * sum(T(s, a, s′) * b[i] for (i, s) in enumerate(𝒮))
    end
    if sum(b′) ≈ 0.0
    fill!(b′, 1)
    end
    return normalize!(b′, 1)
    end