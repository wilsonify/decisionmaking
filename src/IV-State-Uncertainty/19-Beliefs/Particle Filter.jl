struct ParticleFilter
    """
    A belief updater
for particle filters, which updates
a vector of states representing the
belief based on the agent’s action a and its observation o . Appendix G.5 provides an implementation of SetCategorical for defining distributions over discrete sets.
    """
    states::Any # vector of state samples
end
function update(b::ParticleFilter, problem, a, o)
    T, O = problem.T, problem.O
    states = [rand(T(s, a)) for s in b.states]
    weights = [O(a, s′, o) for s′ in states]
    D = SetCategorical(states, weights)
    return ParticleFilter(rand(D, length(states)))
end


struct RejectionParticleFilter
    """
    Updating a particle filter with rejection, which
forces sampled states to match the
input observation o .
    """
    states::Any # vector of state samples
end
function update(b::RejectionParticleFilter, problem, a, o)
    T, O = problem.T, problem.O
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
