"""
Implementation of
the blind lower bound represented
as a set of alpha vectors.
"""
function blind_lowerbound(problem, k_max)
    𝒮, 𝒜, T, R, γ = problem.𝒮, problem.𝒜, problem.T, problem.R, problem.γ
    Q(s, a, α) = R(s, a) + γ * sum(T(s, a, s′) * α[j] for (j, s′) in enumerate(𝒮))
    Γ = [baws_lowerbound(problem) for a in 𝒜]
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
function backup(problem::POMDP, Γ, b)
    𝒮, 𝒜, 𝒪, γ = problem.𝒮, problem.𝒜, problem.𝒪, problem.γ
    R, T, O = problem.R, problem.T, problem.O
    Γa = []
    for a in 𝒜
        Γao = []
        for o in 𝒪
            b′ = update(b, problem, a, o)
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
function update(problem::POMDP, M::PointBasedValueIteration, Γ)
    return [backup(problem, Γ, b) for b in M.B]
end

function solve(M::PointBasedValueIteration, problem)
    Γ = fill(baws_lowerbound(problem), length(problem.𝒜))
    Γ = alphavector_iteration(problem, M, Γ)
    return LookaheadAlphaVectorPolicy(problem, Γ)
end
