"""
An example of how
to use an exploration strategy with
Q-learning in simulation. The parameter settings are notional.

Suppose we want to apply Q-learning to an MDP problem problem . We can construct an exploration policy, such as the ǫ-greedy policy implemented in
algorithm 16.6 from the previous chapter. The Q-learning model comes from
algorithm 17.2 and the simulate function is implemented in algorithm 15.9.
"""

Q = zeros(length(problem.𝒮), length(problem.𝒜))
α = 0.2 # learning rate
model = QLearning(problem.𝒮, problem.𝒜, problem.γ, Q, α)
ϵ = 0.1 # probability of random action
α = 1.0 # exploration decay factor
π = EpsilonGreedyExploration(ϵ, α)
k = 20 # number of steps to simulate
s = 1 # initial state
simulate(problem, model, π, k, s)