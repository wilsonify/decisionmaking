include("Bayes-adaptive MDPs.jl")
"""
The update method for posterior sampling.
After updating the parameters of the Bayesian posterior, 
we sample an MDP problem from that posterior. 
This implementation assumes a discrete state and action space with a 
Dirichlet modeling our uncertainty in the transition probabilities from each state-action pair. 
To generate the transition model, we iterate over every state and action and sample 
from the associated Dirichlet distribution. 
Once we have a sampled problem 𝒫 , 
we solve it using the linear programming formulation and store the resulting value function U .
"""
struct PosteriorSamplingUpdate end
function Base.rand(model::BayesianMDP)
    𝒮, 𝒜 = model.𝒮, model.𝒜
    T = zeros(length(𝒮), length(𝒜), length(𝒮))
    for s in 𝒮
        for a in 𝒜
            T[s, a, :] = rand(model.D[s, a])
        end
    end
    return MDP(T, model.R, model.γ)
end
function update!(planner::PosteriorSamplingUpdate, model, s, a, r, s′)
    𝒫 = rand(model)
    U = solve(𝒫).U
    copy!(model.U, U)
end

