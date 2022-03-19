struct RestrictedPolicyUpdate
    """
    The update function for the restricted policy gradient method at θ for a problem
𝒫 with initial state distribution b .
The gradient is estimated from an
initial state distribution b to depth
d with m simulations of parameterized policy π(θ, s) with log policy
gradient ∇logπ .
    """

    𝒫::Any # problem
    b::Any # initial state distribution
    d::Any # depth
    m::Any # number of samples
    ∇logπ::Any # gradient of log likelihood
    π::Any # policy
    ϵ::Any # divergence bound
end
function update(M::RestrictedPolicyUpdate, θ)
    𝒫, b, d, m, ∇logπ, π, γ = M.𝒫, M.b, M.d, M.m, M.∇logπ, M.π, M.𝒫.γ
    πθ(s) = π(θ, s)
    R(τ) = sum(r * γ^(k - 1) for (k, (s, a, r)) in enumerate(τ))
    τs = [simulate(𝒫, rand(b), πθ, d) for i = 1:m]
    ∇log(τ) = sum(∇logπ(θ, a, s) for (s, a) in τ)
    ∇U(τ) = ∇log(τ) * R(τ)
    u = mean(∇U(τ) for τ in τs)
    return θ + u * sqrt(2 * M.ϵ / dot(u, u))
end
