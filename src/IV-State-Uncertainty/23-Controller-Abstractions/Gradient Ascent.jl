
struct ControllerGradient
    """
    An implementation of a controller gradient ascent
    algorithm for POMDP 𝒫 at initial
    belief b . The controller itself has a
    fixed size of ℓ nodes. It is improved
    over k_max iterations by following
    the gradient of the controller, with
    a step size of α , to maximally improve the value of the initial belief.
    """

    b::Any # initial belief
    ℓ::Any # number of nodes
    α::Any # gradient step
    k_max::Any # maximum iterations
end
function solve(M::ControllerGradient, 𝒫::POMDP)
    𝒜, 𝒪, ℓ, k_max = 𝒫.𝒜, 𝒫.𝒪, M.ℓ, M.k_max
    X = collect(1:ℓ)
    ψ = Dict((x, a) => rand() for x in X, a in 𝒜)
    η = Dict((x, a, o, x′) => rand() for x in X, a in 𝒜, o in 𝒪, x′ in X)
    π = ControllerPolicy(𝒫, X, ψ, η)
    for i = 1:k_max
        improve!(π, M, 𝒫)
    end
    return π
end

function improve!(π::ControllerPolicy, M::ControllerGradient, 𝒫::POMDP)
    𝒮, 𝒜, 𝒪, X, x1, ψ, η = 𝒫.𝒮, 𝒫.𝒜, 𝒫.𝒪, π.X, 1, π.ψ, π.η
    n, m, z, b, ℓ, α = length(𝒮), length(𝒜), length(𝒪), M.b, M.ℓ, M.α
    ∂U′∂ψ, ∂U′∂η = gradient(π, M, 𝒫)
    UIndex(x, s) = (s - 1) * ℓ + (x - 1) + 1
    E(U, x1, b) = sum(b[s] * U[UIndex(x1, s)] for s = 1:n)
    ψ′ = Dict((x, a) => 0.0 for x in X, a in 𝒜)
    η′ = Dict((x, a, o, x′) => 0.0 for x in X, a in 𝒜, o in 𝒪, x′ in X)
    for x in X
        ψ′x = [ψ[x, a] + α * E(∂U′∂ψ(x, a), x1, b) for a in 𝒜]
        ψ′x = project_to_simplex(ψ′x)
        for (aIndex, a) in enumerate(𝒜)
            ψ′[x, a] = ψ′x[aIndex]
        end
        for (a, o) in product(𝒜, 𝒪)
            η′x = [(η[x, a, o, x′] + α * E(∂U′∂η(x, a, o, x′), x1, b)) for x′ in X]
            η′x = project_to_simplex(η′x)
            for (x′Index, x′) in enumerate(X)
                η′[x, a, o, x′] = η′x[x′Index]
            end
        end
    end
    π.ψ, π.η = ψ′, η′
end
function project_to_simplex(y)
    u = sort(copy(y), rev = true)
    i = maximum([j for j in eachindex(u) if u[j] + (1 - sum(u[1:j])) / j > 0.0])
    δ = (1 - sum(u[j] for j = 1:i)) / i
    return [max(y[j] + δ, 0.0) for j in eachindex(u)]
end

"""
The gradient step
of the controller gradient ascent
method. It constructs the gradients
of the utility U with respect to the
policy ∂U′∂ψ and ∂U′∂η .
"""
function gradient(π::ControllerPolicy, M::ControllerGradient, 𝒫::POMDP)
    𝒮, 𝒜, 𝒪, T, O, R, γ = 𝒫.𝒮, 𝒫.𝒜, 𝒫.𝒪, 𝒫.T, 𝒫.O, 𝒫.R, 𝒫.γ
    X, x1, ψ, η = π.X, 1, π.ψ, π.η
    n, m, z = length(𝒮), length(𝒜), length(𝒪)
    X𝒮 = vec(collect(product(X, 𝒮)))
    T′ = [
        sum(
            ψ[x, a] * T(s, a, s′) * sum(O(a, s′, o) * η[x, a, o, x′] for o in 𝒪) for a in 𝒜
        ) for (x, s) in X𝒮, (x′, s′) in X𝒮
    ]
    R′ = [sum(ψ[x, a] * R(s, a) for a in 𝒜) for (x, s) in X𝒮]
    Z = 1.0I(length(X𝒮)) - γ * T′
    invZ = inv(Z)
    ∂Z∂ψ(hx, ha) = [
        x == hx ?
        (-γ * T(s, ha, s′) * sum(O(ha, s′, o) * η[hx, ha, o, x′] for o in 𝒪)) : 0.0 for
        (x, s) in X𝒮, (x′, s′) in X𝒮
    ]
    ∂Z∂η(hx, ha, ho, hx′) = [
        x == hx && x′ == hx′ ? (-γ * ψ[hx, ha] * T(s, ha, s′) * O(ha, s′, ho)) : 0.0 for
        (x, s) in X𝒮, (x′, s′) in X𝒮
    ]
    ∂R′∂ψ(hx, ha) = [x == hx ? R(s, ha) : 0.0 for (x, s) in X𝒮]
    ∂R′∂η(hx, ha, ho, hx′) = [0.0 for (x, s) in X𝒮]
    ∂U′∂ψ(hx, ha) = invZ * (∂R′∂ψ(hx, ha) - ∂Z∂ψ(hx, ha) * invZ * R′)
    ∂U′∂η(hx, ha, ho, hx′) =
        invZ * (∂R′∂η(hx, ha, ho, hx′) - ∂Z∂η(hx, ha, ho, hx′) * invZ * R′)
    return ∂U′∂ψ, ∂U′∂η
end
