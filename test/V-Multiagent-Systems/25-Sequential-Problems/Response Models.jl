include("Markov Games.jl")
"""
For a Markov game 𝒫, 
we can compute a deterministic best response policy 
for agent i given that the other agents are playing policies in π . 
We can solve the MDP exactly using one of the methods from "Exact Solution Methods".
"""
function best_response(𝒫::MG, π, i)
    𝒮, 𝒜, R, T, γ = 𝒫.𝒮, 𝒫.𝒜, 𝒫.R, 𝒫.T, 𝒫.γ
    T′(s, ai, s′) = transition(𝒫, s, joint(π, SimpleGamePolicy(ai), i), s′)
    R′(s, ai) = reward(𝒫, s, joint(π, SimpleGamePolicy(ai), i), i)
    πi = solve(MDP(γ, 𝒮, 𝒜[i], T′, R′))
    return MGPolicy(s => SimpleGamePolicy(πi(s)) for s in 𝒮)
end

"""
The softmax response of agent i to joint policy π
with precision parameter λ .
"""
function softmax_response(𝒫::MG, π, i, λ)
    𝒮, 𝒜, R, T, γ = 𝒫.𝒮, 𝒫.𝒜, 𝒫.R, 𝒫.T, 𝒫.γ
    T′(s, ai, s′) = transition(𝒫, s, joint(π, SimpleGamePolicy(ai), i), s′)
    R′(s, ai) = reward(𝒫, s, joint(π, SimpleGamePolicy(ai), i), i)
    mdp = MDP(γ, 𝒮, joint(𝒜), T′, R′)
    πi = solve(mdp)
    Q(s, a) = lookahead(mdp, πi.U, s, a)
    p(s) = SimpleGamePolicy(a => exp(λ * Q(s, a)) for a in 𝒜[i])
    return MGPolicy(s => p(s) for s in 𝒮)
end
