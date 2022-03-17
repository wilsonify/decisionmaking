include("Belief Initialization.jl")
"""
Implementation of
the blind lower bound represented
as a set of alpha vectors.
"""
function blind_lowerbound(𝒫, k_max)
    𝒮, 𝒜, T, R, γ = 𝒫.𝒮, 𝒫.𝒜, 𝒫.T, 𝒫.R, 𝒫.γ
    Q(s, a, α) = R(s, a) + γ * sum(T(s, a, s′) * α[j] for (j, s′) in enumerate(𝒮))
    Γ = [baws_lowerbound(𝒫) for a in 𝒜]
    for k = 1:k_max
        Γ = [[Q(s, a, α) for s in 𝒮] for (α, a) in zip(Γ, 𝒜)]
    end
    return Γ
end


"""
A method for
    backing up a belief for a POMDP
    with discrete state and action
    spaces, where Γ is a vector of alpha vectors and b is a belief vector
    at which to apply the backup. The
    update method for vector beliefs is
    defined in algorithm 19.2.
"""
function backup(𝒫::POMDP, Γ, b)
    𝒮, 𝒜, 𝒪, γ = 𝒫.𝒮, 𝒫.𝒜, 𝒫.𝒪, 𝒫.γ
    R, T, O = 𝒫.R, 𝒫.T, 𝒫.O
    Γa = []
    for a in 𝒜
        Γao = []
        for o in 𝒪
            b′ = update(b, 𝒫, a, o)
            push!(Γao, argmax(α -> α ⋅ b′, Γ))
        end
        α = [
            R(s, a) +
            γ * sum(
                sum(T(s, a, s′) * O(a, s′, o) * Γao[i][j] for (j, s′) in enumerate(𝒮))
                for (i, o) in enumerate(𝒪)
            ) for s in 𝒮
        ]
        push!(Γa, α)
    end
    return argmax(α -> α ⋅ b, Γa)
end

struct PointBasedValueIteration
    """
    Point-based value iteration,
    which finds an approximately optimal policy for an infinite horizon POMDP with discrete state, action, and observation
    spaces, where B is a vector of beliefs and k_max is the number of iterations.
    """
    # set of belief points
    B::Any
    k_max::Any # maximum number of iterations
end
function update(𝒫::POMDP, M::PointBasedValueIteration, Γ)
    return [backup(𝒫, Γ, b) for b in M.B]
end

function solve(M::PointBasedValueIteration, 𝒫)
    Γ = fill(baws_lowerbound(𝒫), length(𝒫.𝒜))
    Γ = alphavector_iteration(𝒫, M, Γ)
    return LookaheadAlphaVectorPolicy(𝒫, Γ)
end
