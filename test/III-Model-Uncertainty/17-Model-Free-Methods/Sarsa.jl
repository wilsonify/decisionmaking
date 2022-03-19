"""
The Sarsa update
for model-free reinforcement learning. We update the matrix Q containing the state-action values, α is
a constant learning rate, and ℓ is
the most recent experience tuple.
"""

mutable struct Sarsa
    𝒮::Any # state space (assumes 1:nstates)
    𝒜::Any # action space (assumes 1:nactions)
    γ::Any # discount
    Q::Any # action value function
    α::Any # learning rate
    ℓ::Any # most recent experience tuple (s,a,r)
end


lookahead(model::Sarsa, s, a) = model.Q[s, a]

function update!(model::Sarsa, s, a, r, s′)
    if model.ℓ != nothing
        γ, Q, α, ℓ = model.γ, model.Q, model.α, model.ℓ
        model.Q[ℓ.s, ℓ.a] += α * (ℓ.r + γ * Q[s, a] - Q[ℓ.s, ℓ.a])
    end
    model.ℓ = (s = s, a = a, r = r)
    return model
end
