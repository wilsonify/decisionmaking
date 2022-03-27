using DecisionMakingAlgorithms

"""
An example of how to use an exploration strategy with Q-learning with action value function approximation in simulation. 
The parameter settings are notional.

We are interesting in applying Q-learning with a linear action value approximation to the simple regulator problem with γ = 1. 
Our action value approximation is Q θ ( s, a ) = θ ⊤ β ( s, a ) , 
where our basis function is β ( s, a ) = [ s, s 2 , a, a 2 , 1 ]

An example of how to use an exploration strategy with Q-learning with action value function approximation in simulation. 
The parameter settings are notional. 
With this linear model, ∇ θ Q θ ( s, a ) = β ( s, a )
We can implement this as follows for problem problem :
"""

β(s, a) = [s, s^2, a, a^2, 1]
Q(θ, s, a) = dot(θ, β(s, a))
∇Q(θ, s, a) = β(s, a)
θ = [0.1, 0.2, 0.3, 0.4, 0.5] # initial parameter vector
α = 0.5 # learning rate
model = GradientQLearning(problem.𝒜, problem.γ, Q, ∇Q, θ, α)
ϵ = 0.1 # probability of random action
α = 1.0 # exploration decay factor
π = EpsilonGreedyExploration(ϵ, α)
k = 20 # number of steps to simulate
s = 0.0 # initial state
simulate(problem, model, π, k, s)