struct DeterminizedSparseTreeSearch
    """
    An implementation of determinized sparse
    tree search, a modification of
    forward search, for POMDPs.
    The policy takes a belief b in the
    form of a vector of probabilities,
    which is approximated by a
    vector of determized particles by
    determized_approximate_belief .
    """
    problem::Any # problem
    d::Any # depth
    Φ::Any # m×d determinizing matrix
    U::Any # value function to use at leaf nodes
end
function determinized_sparse_tree_search(problem, b, d, Φ, U)
    𝒮, 𝒜, 𝒪, T, R, O, γ = problem.𝒮, problem.𝒜, problem.𝒪, problem.T, problem.R, problem.O, problem.γ
    if d == 0
        return (a = nothing, u = U(b))
    end
    best = (a = nothing, u = -Inf)
    for a in 𝒜
        u = sum(R(ϕ.s, a) for ϕ in b) / length(b)
        for o in possible_observations(problem, Φ, b, a)
            Poba = sum(sum(O(a, s′, o) * T(ϕ.s, a, s′) for s′ in 𝒮) for ϕ in b) / length(b)
            b′ = update(b, Φ, problem, a, o)
            u′ = determinized_sparse_tree_search(problem, b′, d - 1, Φ, U).u
            u += γ * Poba * u′
        end
        if u > best.u
            best = (a = a, u = u)
        end
    end
    return best
end


function determized_approximate_belief(b, problem, m)
    particles = []
    for i = 1:m
        s = rand(SetCategorical(problem.𝒮, b))
        push!(particles, DeterminizedParticle(s, i, 1))
    end
    return particles
end
function (π::DeterminizedSparseTreeSearch)(b)
    particles = determized_approximate_belief(b, π.problem, size(π.Φ, 1))
    return determinized_sparse_tree_search(π.problem, particles, π.d, π.Φ, π.U).a
end
