mutable struct MaximumLikelihoodMDP
    """
    A method for updating the transition and reward
    model for maximum likelihood reinforcement learning with discrete
    state and action spaces. We increment N[s,a,s′] after observing a
    transition from s to s′ after taking
    action a , and we add r to ρ[s,a] .
    The model also contains an estimate of the value function U and
    a planner. This algorithm block
    also includes methods for performing backup and lookahead with respect to this model.
    """
    𝒮::Any # state space (assumes 1:nstates)
    𝒜::Any # action space (assumes 1:nactions)
    N::Any # transition count N(s,a,s′)
    ρ::Any # reward sum ρ(s, a)
    γ::Any # discount
    U::Any # value function
    planner::Any
end
function lookahead(model::MaximumLikelihoodMDP, s, a)
    𝒮, U, γ = model.𝒮, model.U, model.γ
    n = sum(model.N[s, a, :])
    if n == 0
        return 0.0
    end
    r = model.ρ[s, a] / n
    T(s, a, s′) = model.N[s, a, s′] / n
    return r + γ * sum(T(s, a, s′) * U[s′] for s′ in 𝒮)
end


function backup(model::MaximumLikelihoodMDP, U, s)
    return maximum(lookahead(model, s, a) for a in model.𝒜)
end
function update!(model::MaximumLikelihoodMDP, s, a, r, s′)
    model.N[s, a, s′] += 1
    model.ρ[s, a] += r
    update!(model.planner, model, s, a, r, s′)
    return model
end

function MDP(model::MaximumLikelihoodMDP)
    """
    A method for
    converting a maximum likelihood
    model to an MDP problem.
    """
    N, ρ, 𝒮, 𝒜, γ = model.N, model.ρ, model.𝒮, model.𝒜, model.γ
    T, R = similar(N), similar(ρ)
    for s in 𝒮
        for a in 𝒜
            n = sum(N[s, a, :])
            if n == 0
                T[s, a, :] .= 0.0
                R[s, a] = 0.0
            else
                T[s, a, :] = N[s, a, :] / n
                R[s, a] = ρ[s, a] / n
            end
        end
    end
    return MDP(T, R, γ)
end
