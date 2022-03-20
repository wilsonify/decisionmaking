

"""
Nash Q-learning 
for an agent i in an MG problem .
The algorithm performs joint-action Qlearning to learn a state-action
value function for all agents. 
A simple game is built with Q , and we compute a Nash equilibrium using algorithm 24.5. 
The equilibrium is then used to update the value function. 
This implementation also uses a variable learning rate proportional to the number of times
state-joint-action pairs are visited, which is stored in N . 
Additionally, it uses ǫ-greedy exploration to ensure all states and actions are explored.
"""
mutable struct NashQLearning
    problem::Any # Markov game
    i::Any # agent index
    Q::Any # state-action value estimates
    N::Any # history of actions performed
end





function NashQLearning(problem::MG, i)
    ℐ, 𝒮, 𝒜 = problem.ℐ, problem.𝒮, problem.𝒜
    Q = Dict((j, s, a) => 0.0 for j in ℐ, s in 𝒮, a in joint(𝒜))
    N = Dict((s, a) => 1.0 for s in 𝒮, a in joint(𝒜))
    return NashQLearning(problem, i, Q, N)
end
function (πi::NashQLearning)(s)
    problem, i, Q, N = πi.problem, πi.i, πi.Q, πi.N
    ℐ, 𝒮, 𝒜, 𝒜i, γ = problem.ℐ, problem.𝒮, problem.𝒜, problem.𝒜[πi.i], problem.γ
    M = NashEquilibrium()
    𝒢 = SimpleGame(γ, ℐ, 𝒜, a -> [Q[j, s, a] for j in ℐ])
    π = solve(M, 𝒢)
    ϵ = 1 / sum(N[s, a] for a in joint(𝒜))
    πi′(ai) = ϵ / length(𝒜i) + (1 - ϵ) * π[i](ai)
    return SimpleGamePolicy(ai => πi′(ai) for ai in 𝒜i)
end


function update!(πi::NashQLearning, s, a, s′)
    problem, ℐ, 𝒮, 𝒜, R, γ = πi.problem, πi.problem.ℐ, πi.problem.𝒮, πi.problem.𝒜, πi.problem.R, πi.problem.γ
    i, Q, N = πi.i, πi.Q, πi.N
    M = NashEquilibrium()
    𝒢 = SimpleGame(γ, ℐ, 𝒜, a′ -> [Q[j, s′, a′] for j in ℐ])
    π = solve(M, 𝒢)
    πi.N[s, a] += 1
    α = 1 / sqrt(N[s, a])
    for j in ℐ
        πi.Q[j, s, a] += α * (R(s, a)[j] + γ * utility(𝒢, π, j) - Q[j, s, a])
    end
end
