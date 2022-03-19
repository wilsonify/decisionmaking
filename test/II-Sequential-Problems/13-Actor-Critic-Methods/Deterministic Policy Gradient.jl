struct DeterministicPolicyGradient
    """
    The deterministic
policy gradient method for computing a policy gradient ∇θ for a
deterministic policy π and a value
function gradient ∇ϕ for a continuous action MDP 𝒫 with initial state
distribution b . The policy is parameterized by θ and has a gradient
∇π that produces a matrix where
each column is the gradient with
respect to that continuous action
component. The value function Q is
parameterized by ϕ and has a gradient ∇Qϕ with respect to the parameterization and gradient ∇Qa with
respect to the action. This method
runs m rollouts to depth d , and performs exploration using 0-mean
Gaussian noise with standard deviation σ .
    """
    # problem
    𝒫
    b
    # initial state distribution
    d
    # depth
    m
    # number of samples
    ∇π
    # gradient of deterministic policy π(θ, s)
    Q
    # parameterized value function Q(ϕ,s,a)
    ∇Qϕ
    # gradient of value function with respect to ϕ
    ∇Qa
    # gradient of value function with respect to a
    σ
    # policy noise
    end
    function gradient(M::DeterministicPolicyGradient, π, θ, ϕ)
    𝒫, b, d, m, ∇π = M.𝒫, M.b, M.d, M.m, M.∇π
    Q, ∇Qϕ, ∇Qa, σ, γ = M.Q, M.∇Qϕ, M.∇Qa, M.σ, M.𝒫.γ
    π_rand(s) = π(θ, s) + σ*randn()*I
    ∇Uθ(τ) = sum(∇π(θ,s)*∇Qa(ϕ,s,π(θ,s))*γ^(j-1) for (j,(s,a,r))
    in enumerate(τ))
    ∇ℓϕ(τ,j) = begin
    s, a, r = τ[j]
    s′ = τ[j+1][1]
    a′ = π(θ,s′)
    δ = r + γ*Q(ϕ,s′,a′) - Q(ϕ,s,a)
    return δ*(γ*∇Qϕ(ϕ,s′,a′) - ∇Qϕ(ϕ,s,a))
    end
    ∇ℓϕ(τ) = sum(∇ℓϕ(τ,j) for j in 1:length(τ)-1)
    trajs = [simulate(𝒫, rand(b), π_rand, d) for i in 1:m]
    return mean(∇Uθ(τ) for τ in trajs), mean(∇ℓϕ(τ) for τ in trajs)
    end