struct RewardToGoGradient
    """
    A method that
uses reward-to-go for estimating
a policy gradient of a policy π(s)
for an MDP 𝒫 with initial state dis-
tribution b . The gradient with re-
spect to the parameterization vec-
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
function gradient(M::RewardToGoGradient, π, θ)
    𝒫, b, d, m, ∇logπ, γ = M.𝒫, M.b, M.d, M.m, M.∇logπ, M.𝒫.γ
    πθ(s) = π(θ, s)
    R(τ, j) = sum(r * γ^(k - 1) for (k, (s, a, r)) in zip(j:d, τ[j:end]))
    ∇U(τ) = sum(∇logπ(θ, a, s) * R(τ, j) for (j, (s, a, r)) in enumerate(τ))
    return mean(∇U(simulate(𝒫, rand(b), πθ, d)) for i = 1:m)
end

