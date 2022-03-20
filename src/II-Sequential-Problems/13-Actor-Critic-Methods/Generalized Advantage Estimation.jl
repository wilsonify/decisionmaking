struct GeneralizedAdvantageEstimation
    """
    Generalized advantage estimation for computing
both a policy gradient and a value
function gradient for an MDP problem
with initial state distribution b . The
policy is parameterized by θ and
has a log-gradient ∇logπ . The value
function U is parameterized by ϕ
and has a gradient ∇U . This method
runs m rollouts to depth d . The generalized advantage is computed
with exponential weighting λ using
equation (13.21) with a finite horizon. The implementation here is a
simplified version of what was presented in the original paper, which
included aspects of trust regions
when taking steps.
    """
    # problem
    problem
    b
    # initial state distribution
    d
    # depth
    m
    # number of samples
    ∇logπ # gradient of log likelihood ∇logπ(θ,a,s)
    U
    # parameterized value function U(ϕ, s)
    ∇U
    # gradient of value function ∇U(ϕ,s)
    λ
    # weight ∈ [0,1]
    end
    function gradient(M::GeneralizedAdvantageEstimation, π, θ, ϕ)
    problem, b, d, m, ∇logπ = M.problem, M.b, M.d, M.m, M.∇logπ
    U, ∇U, γ, λ = M.U, M.∇U, M.problem.γ, M.λ
    πθ(s) = π(θ, s)
    R(τ,j) = sum(r*γ^(k-1) for (k,(s,a,r)) in enumerate(τ[j:end]))
    δ(τ,j) = τ[j][3] + γ*U(ϕ,τ[j+1][1]) - U(ϕ,τ[j][1])
    A(τ,j) = sum((γ*λ)^(ℓ-1)*δ(τ, j+ℓ-1) for ℓ in 1:d-j)
    ∇Uθ(τ) = sum(∇logπ(θ,a,s)*A(τ,j)*γ^(j-1)
    for (j, (s,a,r)) in enumerate(τ[1:end-1]))
    ∇ℓϕ(τ) = sum((U(ϕ,s) - R(τ,j))*∇U(ϕ,s)
    for (j, (s,a,r)) in enumerate(τ))
    trajs = [simulate(problem, rand(b), πθ, d) for i in 1:m]
    return mean(∇Uθ(τ) for τ in trajs), mean(∇ℓϕ(τ) for τ in trajs)
    end