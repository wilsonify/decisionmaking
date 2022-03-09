struct BaselineSubtractionGradient
    """
    Likelihood ratio
gradient estimation with reward-
to-go and baseline subtraction for
an MDP 𝒫 , policy π , and initial state
distribution b . The gradient with
respect to the parameterization vec-
tor θ is estimated from m rollouts to
depth d using the log policy gradi-
ents ∇logπ .
    """
    𝒫::Any # problem
    b::Any # initial state distribution
    d::Any # depth
    m::Any # number of samples
    ∇logπ::Any # gradient of log likelihood
end
function gradient(M::BaselineSubtractionGradient, π, θ)
    𝒫, b, d, m, ∇logπ, γ = M.𝒫, M.b, M.d, M.m, M.∇logπ, M.𝒫.γ
    πθ(s) = π(θ, s)
    ℓ(a, s, k) = ∇logπ(θ, a, s) * γ^(k - 1)
    R(τ, k) = sum(r * γ^(j - 1) for (j, (s, a, r)) in enumerate(τ[k:end]))
    numer(τ) = sum(ℓ(a, s, k) .^ 2 * R(τ, k) for (k, (s, a, r)) in enumerate(τ))
    denom(τ) = sum(ℓ(a, s, k) .^ 2 for (k, (s, a)) in enumerate(τ))
    base(τ) = numer(τ) ./ denom(τ)
    trajs = [simulate(𝒫, rand(b), πθ, d) for i = 1:m]
    rbase = mean(base(τ) for τ in trajs)
    ∇U(τ) = sum(ℓ(a, s, k) .* (R(τ, k) .- rbase) for (k, (s, a, r)) in enumerate(τ))
    return mean(∇U(τ) for τ in trajs)
end
