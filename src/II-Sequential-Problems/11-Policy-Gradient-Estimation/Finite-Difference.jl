function simulate(𝒫::MDP, s, π, d)
    """
    A method for gen-
        erating a trajectory associated with
        problem 𝒫 starting in state s and
        executing policy π to depth d . It
        creates a vector τ containing state-
        action-reward tuples.
    """
    τ = []
    for i = 1:d
        a = π(s)
        s′, r = 𝒫.TR(s, a)
        push!(τ, (s, a, r))
        s = s′
    end
    return τ
end

struct FiniteDifferenceGradient
    """
    A method for es-
        timating a policy gradient using
        finite differences for problem 𝒫 , a
        parameterized policy π(θ, s) , and
        policy parameterization vector θ .
        Utility estimates are made from m
        rollouts to depth d . The step size is
        given by δ .
    """
    𝒫::Any # problem
    b::Any # initial state distribution
    d::Any # depth
    m::Any # number of samples
    δ::Any # step size
end

function gradient(M::FiniteDifferenceGradient, π, θ)
    𝒫, b, d, m, δ, γ, n = M.𝒫, M.b, M.d, M.m, M.δ, M.𝒫.γ, length(θ)
    Δθ(i) = [i == k ? δ : 0.0 for k in 1:n]
    R(τ) = sum(r*γ^(k-1) for (k, (s,a,r)) in enumerate(τ))
    U(θ) = mean(R(simulate(𝒫, rand(b), s->π(θ, s), d)) for i in 1:m)
    ΔU = [U(θ + Δθ(i)) - U(θ) for i in 1:n]
    return ΔU ./ δ
    end