# We can apply ǫ-greedy exploration to maximum likelihood model estimates constructed while interacting with the environment. 
# The code below initializes the counts, rewards, and utilities to zero. 
# It uses full updates to the value function with each step. 
# For exploration, we choose a random action with probability 0.1 without decay. 
# The last line runs a simulation (algorithm 15.9) of problem 𝒫 for 100 steps.
𝒮=[]
N = zeros(length(𝒮), length(𝒜), length(𝒮))
ρ = zeros(length(𝒮), length(𝒜))
U = zeros(length(𝒮))
planner = FullUpdate()
model = MaximumLikelihoodMDP(𝒮, 𝒜, N, ρ, γ, U, planner)
π = EpsilonGreedyExploration(0.1, 1)
simulate(problem, model, π, 100)

# Alternatively, we can use R-MAX with an exploration threshold of m = 3.
# We can act greedily with respect to the R-MAX model.

rmax = maximum(problem.R(s, a) for s in 𝒮, a in 𝒜)
m = 3
model = RmaxMDP(𝒮, 𝒜, N, ρ, γ, U, planner, m, rmax)
π = EpsilonGreedyExploration
