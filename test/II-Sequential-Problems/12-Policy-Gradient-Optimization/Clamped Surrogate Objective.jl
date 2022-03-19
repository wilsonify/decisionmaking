struct ClampedSurrogateUpdate
    """
    an implementation of clamped surrogate policy
optimization, which returns a new
policy parameterization for policy
π(s) of an MDP 𝒫 with initial state
distribution b . This implementation samples m trajectories to depth
d , and then uses them to estimate
the policy gradient in k_max subsequent updates. The policy gradient
using the clamped objective is constructed using the policy gradients
∇p with clamping parameter ϵ .
    """
    𝒫::Any # problem
    b::Any # initial state distribution
    d::Any # depth
    m::Any # number of trajectories
    π::Any # policy
    p::Any # policy likelihood
    ∇π::Any # policy likelihood gradient
    ϵ::Any # divergence bound
    α::Any # step size
    k_max::Any # number of iterations per update
end
function clamped_gradient(M::ClampedSurrogateUpdate, θ, θ′, τs)
    d, p, ∇π, ϵ, γ = M.d, M.p, M.∇π, M.ϵ, M.𝒫.γ
    R(τ, j) = sum(r * γ^(k - 1) for (k, (s, a, r)) in zip(j:d, τ[j:end]))
    ∇f(a, s, r_togo) = begin
        P = p(θ, a, s)
        w = p(θ′, a, s) / P
        if (r_togo > 0 && w > 1 + ϵ) || (r_togo < 0 && w < 1 - ϵ)
            return zeros(length(θ))
        end
        return ∇π(θ′, a, s) * r_togo / P
    end
    ∇f(τ) = mean(∇f(a, s, R(τ, k)) for (k, (s, a, r)) in enumerate(τ))
    return mean(∇f(τ) for τ in τs)
end
function update(M::ClampedSurrogateUpdate, θ)
    𝒫, b, d, m, π, α, k_max = M.𝒫, M.b, M.d, M.m, M.π, M.α, M.k_max
    πθ(s) = π(θ, s)
    τs = [simulate(𝒫, rand(b), πθ, d) for i = 1:m]
    θ′ = copy(θ)
    for k = 1:k_max
        θ′ += α * clamped_gradient(M, θ, θ′, τs)
    end
    return θ′
end
