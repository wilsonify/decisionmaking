
"""
The Q-learning update for model-free reinforcement learning, 
which can be applied to problems with unknown transition and reward functions.
The update modifies Q, which is a matrix of state-action values. 
This update function can be used together with an exploration strategy,
such as ǫ-greedy in the simulate function in simulate.
"""
mutable struct QLearning
    𝒮::Any # state space (assumes 1:nstates)
    𝒜::Any # action space (assumes 1:nactions)
    γ::Any # discount
    Q::Any # action value function
    α::Any # learning rate
end


lookahead(model::QLearning, s, a) = model.Q[s, a]
function update!(model::QLearning, s, a, r, s′)
    γ, Q, α = model.γ, model.Q, model.α
    Q[s, a] += α * (r + γ * maximum(Q[s′, :]) - Q[s, a])
    return model
end


