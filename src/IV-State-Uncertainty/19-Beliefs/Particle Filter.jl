struct ParticleFilter
    """
    A belief updater
for particle filters, which updates
a vector of states representing the
belief based on the agent’s ac-
tion a and its observation o . Ap-
pendix G.5 provides an implemen-
tation of SetCategorical for defin-
ing distributions over discrete sets.
    """
    states::Any # vector of state samples
end
function update(b::ParticleFilter, 𝒫, a, o)
    T, O = 𝒫.T, 𝒫.O
    states = [rand(T(s, a)) for s in b.states]
    weights = [O(a, s′, o) for s′ in states]
    D = SetCategorical(states, weights)
    return ParticleFilter(rand(D, length(states)))
end


struct RejectionParticleFilter
    """
    Updating a par-
ticle filter with rejection, which
forces sampled states to match the
input observation o .
    """
    states::Any # vector of state samples
end
function update(b::RejectionParticleFilter, 𝒫, a, o)
    T, O = 𝒫.T, 𝒫.O
    states = similar(b.states)
    i = 1
    while i ≤ length(states)
        s = rand(b.states)
        s′ = rand(T(s, a))
        if rand(O(a, s′)) == o
            states[i] = s′
            i += 1
        end
    end
    return RejectionParticleFilter(states)
end
