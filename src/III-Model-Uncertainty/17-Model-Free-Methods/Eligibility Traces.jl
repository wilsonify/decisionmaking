""" The Sarsa ( λ ) update, which uses eligibility traces to
propagate reward back in time to
speed learning of sparse rewards.
The matrix Q contains the stateaction values, the matrix N contains exponentially decaying stateaction visit counts, α is a constant
learning rate, λ is an exponential
decay parameter, and ℓ is the most
recent experience tuple.
"""
mutable struct SarsaLambda
    𝒮::Any # state space (assumes 1:nstates)
    𝒜::Any # action space (assumes 1:nactions)
    γ::Any # discount
    Q::Any # action value function
    N::Any # trace
    α::Any # learning rate
    λ::Any # trace decay rate
    ℓ::Any # most recent experience tuple (s,a,r)
end

lookahead(model::SarsaLambda, s, a) = model.Q[s, a]

function update!(model::SarsaLambda, s, a, r, s′)
    if model.ℓ != nothing
        γ, λ, Q, α, ℓ = model.γ, model.λ, model.Q, model.α, model.ℓ
        model.N[ℓ.s, ℓ.a] += 1
        δ = ℓ.r + γ * Q[s, a] - Q[ℓ.s, ℓ.a]
        for s in model.𝒮
            for a in model.𝒜
                model.Q[s, a] += α * δ * model.N[s, a]
                model.N[s, a] *= γ * λ
            end
        end
    else
        model.N[:, :] .= 0.0
    end
    model.ℓ = (s = s, a = a, r = r)
    return model
end
