struct NaturalPolicyUpdate
    """
    The update func-
    tion for the natural policy gradi-
    ent given policy π(θ, s) for an
    MDP 𝒫 with initial state distribu-
    tion b . The natural gradient with
    respect to the parameter vector θ is
    estimated from m rollouts to depth
    d using the log policy gradients
    ∇logπ . The natural_update helper
    method conducts an update ac-
    cording to equation (12.12) given
    an objective gradient ∇f(τ) and a
    Fisher matrix F(τ) for a list of tra-
    jectories.
    """
    𝒫::Any # problem
    b::Any # initial state distribution
    d::Any # depth
    m::Any # number of samples
    ∇logπ::Any # gradient of log likelihood
    π::Any # policy
    ϵ::Any # divergence bound
end

function natural_update(θ, ∇f, F, ϵ, τs)
    ∇fθ = mean(∇f(τ) for τ in τs)
    u = mean(F(τ) for τ in τs) \ ∇fθ
    return θ + u * sqrt(2ϵ / dot(∇fθ, u))
end


function update(M::NaturalPolicyUpdate, θ)
    𝒫, b, d, m, ∇logπ, π, γ = M.𝒫, M.b, M.d, M.m, M.∇logπ, M.π, M.𝒫.γ
    πθ(s) = π(θ, s)
    R(τ) = sum(r * γ^(k - 1) for (k, (s, a, r)) in enumerate(τ))
    ∇log(τ) = sum(∇logπ(θ, a, s) for (s, a) in τ)
    ∇U(τ) = ∇log(τ) * R(τ)
    F(τ) = ∇log(τ) * ∇log(τ)'
    τs = [simulate(𝒫, rand(b), πθ, d) for i = 1:m]
    return natural_update(θ, ∇U, F, M.ϵ, τs)
end
