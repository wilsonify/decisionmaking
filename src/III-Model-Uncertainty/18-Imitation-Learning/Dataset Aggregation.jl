"""
The DAgger
method of dataset aggregation for
learning a stochastic parameterized policy from expert demonstrations. This method takes an initial dataset of state-action tuples D ,
a stochastic parameterized policy
πθ(θ, s) , an MDP 𝒫 that defines
a transition function, and an initial state distribution b . Behavioral
cloning, algorithm 18.1, is used in
each iteration to improve the policy.
An expert policy πE labels trajectories sampled from the latest
learned policy to augment the
dataset. The original paper generated trajectories by stochastically
mixing in the expert policy. This
implementation is thus the original DAgger with an extreme mixing value of zero.
In practice an expert policy
would not exist, and calls to this
policy would be replaced with
queries to a human expert.
"""
struct DatasetAggregation
    𝒫::Any     # problem with unknown reward function
    bc::Any     # behavioral cloning struct
    k_max::Any # number of iterations
    m::Any     # number of rollouts per iteration
    d::Any     # rollout depth
    b::Any     # initial state distribution
    πE::Any     # expert
    πθ::Any     # parameterized policy
end
function optimize(M::DatasetAggregation, D, θ)
    𝒫, bc, k_max, m = M.𝒫, M.bc, M.k_max, M.m
    d, b, πE, πθ = M.d, M.b, M.πE, M.πθ
    θ = optimize(bc, D, θ)
    for k = 2:k_max
        for i = 1:m
            s = rand(b)
            for j = 1:d
                push!(D, (s, πE(s)))
                a = rand(πθ(θ, s))
                s = rand(𝒫.T(s, a))
            end
        end
        θ = optimize(bc, D, θ)
    end
    return θ
end
