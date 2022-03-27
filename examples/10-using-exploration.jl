using DecisionMakingAlgorithms
# We can apply ǫ-greedy exploration to maximum likelihood model estimates constructed while interacting with the environment. 
# The code below initializes the counts, rewards, and utilities to zero. 
# It uses full updates to the value function with each step. 
# For exploration, we choose a random action with probability 0.1 without decay. 
# The last line runs a simulation (algorithm 15.9) of problem 𝒫 for 100 steps.

B = Variable(:b, 2)
S = Variable(:s, 2)
E = Variable(:e, 2)
D = Variable(:d, 2)
C = Variable(:c, 2)
vars = [B, S, E, D, C]
factors = [
    Factor([B], FactorTable(Dict(pairs((b = 1,))) => 0.99, Dict(pairs((b = 2,))) => 0.01)),
    Factor([S], FactorTable(Dict(pairs((s = 1,))) => 0.98, Dict(pairs((s = 2,))) => 0.02)),
    Factor(
        [E, B, S],
        FactorTable(
            Dict(pairs((e = 1, b = 1, s = 1))) => 0.90,
            Dict(pairs((e = 1, b = 1, s = 2))) => 0.04,
            Dict(pairs((e = 1, b = 2, s = 1))) => 0.05,
            Dict(pairs((e = 1, b = 2, s = 2))) => 0.01,
            Dict(pairs((e = 2, b = 1, s = 1))) => 0.10,
            Dict(pairs((e = 2, b = 1, s = 2))) => 0.96,
            Dict(pairs((e = 2, b = 2, s = 1))) => 0.95,
            Dict(pairs((e = 2, b = 2, s = 2))) => 0.99,
        ),
    ),
    Factor(
        [D, E],
        FactorTable(
            Dict(pairs((d = 1, e = 1))) => 0.96,
            Dict(pairs((d = 1, e = 2))) => 0.03,
            Dict(pairs((d = 2, e = 1))) => 0.04,
            Dict(pairs((d = 2, e = 2))) => 0.97,
        ),
    ),
    Factor(
        [C, E],
        FactorTable(
            Dict(pairs((c = 1, e = 1))) => 0.98,
            Dict(pairs((c = 1, e = 2))) => 0.01,
            Dict(pairs((c = 2, e = 1))) => 0.02,
            Dict(pairs((c = 2, e = 2))) => 0.99,
        ),
    ),
]
graph = SimpleDiGraph(5)
add_edge!(graph, 1, 3);
add_edge!(graph, 2, 3);
add_edge!(graph, 3, 4);
add_edge!(graph, 3, 5);
bn = BayesianNetwork(vars, factors, graph)


chance_vars = [B, S]
decision_vars = [D]
utility_vars = [C, E]
utilities = Dict{Symbol,Vector{Float64}}([(:c , [0.1,0.9]), (:e , [0.9,0.1])])
problem = SimpleProblem(bn, chance_vars, decision_vars, utility_vars, utilities) # simple problem


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
