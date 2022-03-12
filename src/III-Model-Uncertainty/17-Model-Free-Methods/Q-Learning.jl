"""
The Q-learning
update for model-free reinforcement learning, which can be applied to problems with unknown
transition and reward functions.
The update modifies Q , which is a
matrix of state-action values. This
update function can be used together with an exploration strategy,
such as ǫ-greedy in the simulate
function in algorithm 15.9.
"""
mutable struct QLearning
    𝒮::Any #     state space (assumes 1:nstates)
    𝒜::Any #     action space (assumes 1:nactions)
    γ::Any #     discount
    Q::Any #     action value function
    α::Any #     learning rate
end


lookahead(model::QLearning, s, a) = model.Q[s, a]
function update!(model::QLearning, s, a, r, s′)
    γ, Q, α = model.γ, model.Q, model.α
    Q[s, a] += α * (r + γ * maximum(Q[s′, :]) - Q[s, a])
    return model
end


"""
An example of how
to use an exploration strategy with
Q-learning in simulation. The parameter settings are notional.

Suppose we want to apply Q-learning to an MDP problem 𝒫 . We can construct an exploration policy, such as the ǫ-greedy policy implemented in
algorithm 16.6 from the previous chapter. The Q-learning model comes from
algorithm 17.2 and the simulate function is implemented in algorithm 15.9.
"""

Q = zeros(length(𝒫.𝒮), length(𝒫.𝒜))
α = 0.2 # learning rate
model = QLearning(𝒫.𝒮, 𝒫.𝒜, 𝒫.γ, Q, α)
ϵ = 0.1 # probability of random action
α = 1.0 # exploration decay factor
π = EpsilonGreedyExploration(ϵ, α)
k = 20 # number of steps to simulate
s = 1 # initial state
simulate(𝒫, model, π, k, s)