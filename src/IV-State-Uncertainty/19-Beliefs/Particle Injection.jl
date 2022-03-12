struct InjectionParticleFilter
    """
    Particle filter
update with injection, in which
m_inject particles are sampled
from the injection distribution
D_inject to reduce the risk of par-
ticle deprivation.
    """
    states::Any # vector of state samples
    m_inject::Any # number of samples to inject
    D_inject::Any # injection distribution
end
function update(b::InjectionParticleFilter, 𝒫, a, o)
    T, O, m_inject, D_inject = 𝒫.T, 𝒫.O, b.m_inject, b.D_inject
    states = [rand(T(s, a)) for s in b.states]
    weights = [O(a, s′, o) for s′ in states]
    D = SetCategorical(states, weights)
    m = length(states)
    states = vcat(rand(D, m - m_inject), rand(D_inject, m_inject))
    return InjectionParticleFilter(states, m_inject, D_inject)
end
