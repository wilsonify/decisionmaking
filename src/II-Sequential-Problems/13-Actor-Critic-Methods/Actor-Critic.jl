struct ActorCritic
    """
    A basic actor-critic
method for computing both a policy gradient and a value function
gradient for an MDP problem with initial
state distribution b . The policy π
is parameterized by θ and has a
log-gradient ∇logπ . The value function U is parameterized by ϕ and the
gradient of its objective function is
∇U . This method runs m rollouts to
depth d . The results are used to update θ and ϕ . The policy parameterization is updated in the direction of ∇θ to maximize the expected
value, whereas the value function
parameterization is updated in the
negative direction of ∇ϕ to minimize the value loss.
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
    end
    function gradient(M::ActorCritic, π, θ, ϕ)
    problem, b, d, m, ∇logπ = M.problem, M.b, M.d, M.m, M.∇logπ
    U, ∇U, γ = M.U, M.∇U, M.problem.γ
    πθ(s) = π(θ, s)
    R(τ,j) = sum(r*γ^(k-1) for (k,(s,a,r)) in enumerate(τ[j:end]))
    A(τ,j) = τ[j][3] + γ*U(ϕ,τ[j+1][1]) - U(ϕ,τ[j][1])
    ∇Uθ(τ) = sum(∇logπ(θ,a,s)*A(τ,j)*γ^(j-1) for (j, (s,a,r))
    in enumerate(τ[1:end-1]))
    ∇ℓϕ(τ) = sum((U(ϕ,s) - R(τ,j))*∇U(ϕ,s) for (j, (s,a,r))
    in enumerate(τ))
    trajs = [simulate(problem, rand(b), πθ, d) for i in 1:m]
    return mean(∇Uθ(τ) for τ in trajs), mean(∇ℓϕ(τ) for τ in trajs)
    end