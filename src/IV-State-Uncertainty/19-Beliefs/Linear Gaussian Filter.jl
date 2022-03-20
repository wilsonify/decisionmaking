"""
A method that
updates a discrete belief based on
equation (19.7), where b is a vector and problem is the POMDP model. If
the given observation has a zero
likelihood, a uniform distribution
is returned.
"""
function update(b::Vector{Float64}, problem, a, o)
    𝒮, T, O = problem.𝒮, problem.T, problem.O
    b′ = similar(b)
    for (i′, s′) in enumerate(𝒮)
        po = O(a, s′, o)
        b′[i′] = po * sum(T(s, a, s′) * b[i] for (i, s) in enumerate(𝒮))
    end
    if sum(b′) ≈ 0.0
        fill!(b′, 1)
    end
    return normalize_factor!(b′, 1)
end
