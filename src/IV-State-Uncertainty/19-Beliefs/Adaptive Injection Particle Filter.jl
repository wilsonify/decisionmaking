"""
A particle filter with adaptive injection, which
maintains fast and slow exponential moving averages w_fast
and w_slow of the mean particle weight with smoothness factors α_fast and α_slow , respectively. Particles are only injected
if the fast moving average of the
mean particle weight is less than
1/ν of the slow moving average.
Recommended values from the
original paper are α_fast = 0.1 ,
α_slow = 0.001 , and ν = 2 .
"""
mutable struct AdaptiveInjectionParticleFilter
    states::Any # vector of state samples
    w_slow::Any # slow moving average
    w_fast::Any # fast moving average
    α_slow::Any# slow moving average parameter
    α_fast::Any# fast moving average parameter
    ν::Any# injection parameter
    D_inject::Any # injection distribution
end

function update(b::AdaptiveInjectionParticleFilter, problem, a, o)
    T, O = problem.T, problem.O
    w_slow, w_fast, α_slow, α_fast, ν, D_inject =
        b.w_slow, b.w_fast, b.α_slow, b.α_fast, b.ν, b.D_inject
    states = [rand(T(s, a)) for s in b.states]
    weights = [O(a, s′, o) for s′ in states]
    w_mean = mean(weights)
    w_slow += α_slow * (w_mean - w_slow)
    w_fast += α_fast * (w_mean - w_fast)
    m = length(states)
    m_inject = round(Int, m * max(0, 1.0 - ν * w_fast / w_slow))
    D = SetCategorical(states, weights)
    states = vcat(rand(D, m - m_inject), rand(D_inject, m_inject))
    b.w_slow, b.w_fast = w_slow, w_fast
    return AdaptiveInjectionParticleFilter(
        states,
        w_slow,
        w_fast,
        α_slow,
        α_fast,
        ν,
        D_inject,
    )
end
