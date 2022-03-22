"""
An evolution strategies method for updating a search distribution D(ψ) over policy parameterizations for policy π(θ, s) .
This implementation also takes an initial search distribution parameterization ψ , 
the log search likelihood gradient ∇logp(ψ, θ) , 
a policy evaluation function U ,
and an iteration count k_max . 
In each iteration, 
m parameterization samples are drawn and are used to estimate the search gradient. 
This gradient is then applied with a step factor α . 
We can use Distributions.jl to define D(ψ) .
For example, 
if we want to define D to construct a Gaussian with a given mean ψ and fixed covariance Σ , 
we can use D(ψ) = MvNormal(ψ, Σ) .
"""
struct EvolutionStrategies
    
    D::Any # distribution constructor
    ψ::Any # initial distribution parameterization
    ∇logp::Any # log search likelihood gradient
    m::Any # number of samples
    α::Any # step factor
    k_max::Any # number of iterations
end

function evolution_strategy_weights(m)
    ws = [max(0, log(m / 2 + 1) - log(i)) for i = 1:m]
    ws ./= sum(ws)
    ws .-= 1 / m
    return ws
end

function optimize_dist(M::EvolutionStrategies, π, U)
    D, ψ, m, ∇logp, α = M.D, M.ψ, M.m, M.∇logp, M.α
    ws = evolution_strategy_weights(m)
    for k = 1:M.k_max
        θs = rand(D(ψ), m)
        us = [U(π, θs[:, i]) for i = 1:m]
        sp = sortperm(us, rev = true)
        ∇ = sum(w .* ∇logp(ψ, θs[:, i]) for (w, i) in zip(ws, sp))
        ψ += α .* ∇
    end
    return D(ψ)
end

struct IsotropicEvolutionStrategies
    """
    An evolution strategies method for updating an isotropic multivariate Gaussian
    search distribution with mean ψ and covariance σ 2 I over policy parameterizations for policy π(θ, s) .
    This implementation also takes a policy evaluation function U , a step factor α , and an iteration count k_max . 
    In each iteration, m/2 parameterization samples are drawn and mirrored,
    and are then used to estimate the search gradient.
    """
    ψ::Any # initial mean
    σ::Any # initial standard devidation
    m::Any # number of samples
    α::Any # step factor
    k_max::Any # number of iterations
end
function optimize_dist(M::IsotropicEvolutionStrategies, π, U)
    ψ, σ, m, α, k_max = M.ψ, M.σ, M.m, M.α, M.k_max
    n = length(ψ)
    ws = evolution_strategy_weights(2 * div(m, 2))
    for k = 1:k_max
        ϵs = [randn(n) for i = 1:div(m, 2)]
        append!(ϵs, -ϵs) # weight mirroring
        us = [U(π, ψ + σ .* ϵ) for ϵ in ϵs]
        sp = sortperm(us, rev = true)
        ∇ = sum(w .* ϵs[i] for (w, i) in zip(ws, sp)) / σ
        ψ += α .* ∇
    end
    return MvNormal(ψ, σ)
end
