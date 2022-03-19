"""
Monte Carlo policy evaluation of a policy π . The
method runs m rollouts to depth d
according to the dynamics specified by the problem 𝒫 . Each rollout
is run from an initial state sampled
from state distribution b . The final
line in this algorithm block evaluates a policy π parameterized by
θ , which will be useful in the algorithms in this chapter that attempt
to find a θ that maximizes U .
"""
struct MonteCarloPolicyEvaluation
    𝒫::Any # problem
    b::Any # initial state distribution
    d::Any # depth
    m::Any # number of samples
end
function (U::MonteCarloPolicyEvaluation)(π)
    R(π) = rollout(U.𝒫, rand(U.b), π, U.d)
    return mean(R(π) for i = 1:U.m)
end
(U::MonteCarloPolicyEvaluation)(π, θ) = U(s -> π(θ, s))


struct HookeJeevesPolicySearch
    """
    Policy search
using the Hooke-Jeeves method,
which returns a θ that has been optimized with respect to U . The policy π takes as input a parameter θ
and state s . This implementation
starts with an initial θ . The step size
α is reduced by a factor of c if no
neighbor improves the objective. Iterations are run until the step size
is less than ϵ .
    """
    θ::Any # initial parameterization
    α::Any # step size
    c::Any # step size reduction factor
    ϵ::Any # termination step size
end
function optimize(M::HookeJeevesPolicySearch, π, U)
    θ, θ′, α, c, ϵ = copy(M.θ), similar(M.θ), M.α, M.c, M.ϵ
    u, n = U(π, θ), length(θ)
    while α > ϵ
        copyto!(θ′, θ)
        best = (i = 0, sgn = 0, u = u)
        for i = 1:n
            for sgn in (-1, 1)
                θ′[i] = θ[i] + sgn * α
                u′ = U(π, θ′)
                if u′ > best.u
                    best = (i = i, sgn = sgn, u = u′)
                end
            end
            θ′[i] = θ[i]
        end
        if best.i != 0
            θ[best.i] += best.sgn * α
            u = best.u
        else
            α *= c
        end
    end
    return θ
end

struct GeneticPolicySearch
    """
    A genetic policy
search method for iteratively updating a population of policy parameterizations θs , which takes a
policy evaluation function U , a policy π(θ, s) , a perturbation standard deviation σ , an elite sample
count m_elite , and an iteration
count k_max . The best m_elite samples from each iteration are used to
generate the samples for the subsequent iteration.
    """
    # initial population
    θs::Any
    σ::Any
    # initial standard devidation
    m_elite::Any # number of elite samples
    k_max::Any
    # number of iterations
end
function optimize(M::GeneticPolicySearch, π, U)
    θs, σ = M.θs, M.σ
    n, m = length(first(θs)), length(θs)
    for k = 1:M.k_max
        us = [U(π, θ) for θ in θs]
        sp = sortperm(us, rev = true)
        θ_best = θs[sp[1]]
        rand_elite() = θs[sp[rand(1:M.m_elite)]]
        θs = [rand_elite() + σ .* randn(n) for i = 1:(m-1)]
        push!(θs, θ_best)
    end
    return last(θs)
end
