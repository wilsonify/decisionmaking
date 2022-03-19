"""
A finite state controller policy representation for a
POMDP 𝒫 . The nodes in X are an abstract representation of reachable
beliefs. Actions and controller successor nodes are selected stochastically. Given a node x , actions are selected following the distribution ψ .
The function π(x) implements this
mechanism to stochastically select
actions. After performing action a
in node x and observing observation o , the successor is selected following the distribution η . The function update implements this mechanism to stochastically select successor nodes.
"""
mutable struct ControllerPolicy
    𝒫::Any # problem
    X::Any # set of controller nodes
    ψ::Any # action selection distribution
    η::Any # successor selection distribution
end

function (π::ControllerPolicy)(x)
    𝒜, ψ = π.𝒫.𝒜, π.ψ
    dist = [ψ[x, a] for a in 𝒜]
    return rand(SetCategorical(𝒜, dist))
end
function update(π::ControllerPolicy, x, a, o)
    X, η = π.X, π.η
    dist = [η[x, a, o, x′] for x′ in X]
    return rand(SetCategorical(X, dist))
end


"""
An algorithm for
    performing iterative policy evaluation to compute the utility of a finite state controller π with k_max
    iterations. The utility function performs a single step evaluation for
    the current controller node x and
    state s following equation (23.1).
    This algorithm was adapted from
    algorithm 7.3, which applies iterative policy evaluation to MDPs.
"""
function utility(π::ControllerPolicy, U, x, s)
    𝒮, 𝒜, 𝒪 = π.𝒫.𝒮, π.𝒫.𝒜, π.𝒫.𝒪
    T, O, R, γ = π.𝒫.T, π.𝒫.O, π.𝒫.R, π.𝒫.γ
    X, ψ, η = π.X, π.ψ, π.η
    U′(a, s′, o) = sum(η[x, a, o, x′] * U[x′, s′] for x′ in X)
    U′(a, s′) = T(s, a, s′) * sum(O(a, s′, o) * U′(a, s′, o) for o in 𝒪)
    U′(a) = R(s, a) + γ * sum(U′(a, s′) for s′ in 𝒮)
    return sum(ψ[x, a] * U′(a) for a in 𝒜)
end
function iterative_policy_evaluation(π::ControllerPolicy, k_max)
    𝒮, X = π.𝒫.𝒮, π.X
    U = Dict((x, s) => 0.0 for x in X, s in 𝒮)
    for k = 1:k_max
        U = Dict((x, s) => utility(π, U, x, s) for x in X, s in 𝒮)
    end
    return U
end
