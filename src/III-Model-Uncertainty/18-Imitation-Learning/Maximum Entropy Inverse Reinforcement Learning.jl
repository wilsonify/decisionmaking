
struct MaximumEntropyIRL
    """
    Maximum en    tropy inverse reinforcement learn    ing, which finds a stochastic pol    icy that maximizes the likelihood
    of the expert demonstrations un    der a maximum-entropy trajectory
    distribution. This implementation
    computes the expected visitations
    using dynamic programming over
    all states, which requires that the
    problem be discrete.
    """

    𝒫::Any # problem
    b::Any     # initial state distribution
    d::Any    # depth
    π::Any     # parameterized policy π(θ,s)
    Pπ::Any     # parameterized policy likelihood π(θ, a, s)
    ∇R::Any     # reward function gradient
    RL::Any    # reinforcement learning method
    α::Any    # step size
    k_max::Any # number of iterations
end

function discounted_state_visitations(M::MaximumEntropyIRL, θ)
    𝒫, b, d, Pπ = M.𝒫, M.b, M.d, M.Pπ
    𝒮, 𝒜, T, γ = 𝒫.𝒮, 𝒫.𝒜, 𝒫.T, 𝒫.γ
    b_sk = zeros(length(𝒫.𝒮), d)
    b_sk[:, 1] = [pdf(b, s) for s in 𝒮]
    for k = 2:d
        for (si′, s′) in enumerate(𝒮)
            b_sk[si′, k] =
                γ * sum(
                    sum(
                        b_sk[si, k-1] * Pπ(θ, a, s) * T(s, a, s′) for
                        (si, s) in enumerate(𝒮)
                    ) for a in 𝒜
                )
        end
    end
    return normalize!(vec(mean(b_sk, dims = 2)), 1)
end
function optimize(M::MaximumEntropyIRL, D, ϕ, θ)
    𝒫, π, Pπ, ∇R, RL, α, k_max = M.𝒫, M.π, M.Pπ, M.∇R, M.RL, M.α, M.k_max
    𝒮, 𝒜, γ, nD = 𝒫.𝒮, 𝒫.𝒜, 𝒫.γ, length(D)
    for k = 1:k_max
        copyto!(RL.ϕ, ϕ) # update parameters
        θ = optimize(RL, π, θ)
        b = discounted_state_visitations(M, θ)
        ∇Rτ = τ -> sum(γ^(i - 1) * ∇R(ϕ, s, a) for (i, (s, a)) in enumerate(τ))
        ∇f =
            sum(∇Rτ(τ) for τ in D)             nD * sum(
                b[si] * sum(Pπ(θ, a, s) * ∇R(ϕ, s, a) for (ai, a) in enumerate(𝒜)) for
                (si, s) in enumerate(𝒮)
            )
        ϕ += α * ∇f
    end
    return ϕ, θ
end
