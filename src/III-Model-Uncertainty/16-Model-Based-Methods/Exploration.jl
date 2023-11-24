"""
    The prioritized
    sweeping algorithm maintains a
    priority queue pq of states that determines which are to be updated.
    With each update, we set the previous state to have infinite priority. We then perform m Bellman updates of the value function U at the
    highest priority states.
"""
struct PrioritizedUpdate
    m::Any # number of updates
    pq::Any # priority queue
end
function update!(planner::PrioritizedUpdate, model, s)
    N, U, pq = model.N, model.U, planner.pq
    𝒮, 𝒜 = model.𝒮, model.𝒜
    u = U[s]
    U[s] = backup(model, U, s)
    for s⁻ in 𝒮
        for a⁻ in 𝒜
            n_sa = sum(N[s⁻, a⁻, s′] for s′ in 𝒮)
            if n_sa > 0
                T = N[s⁻, a⁻, s] / n_sa
                priority = T * abs(U[s] - u)
                pq[s⁻] = max(get(pq, s⁻, -Inf), priority)
            end
        end
    end
    return planner
end


function update!(planner::PrioritizedUpdate, model, s, a, r, s′)
    planner.pq[s] = Inf
    for i = 1:planner.m
        if isempty(planner.pq)
            break
        end
        update!(planner, model, dequeue!(planner.pq))
    end
    return planner
end

"""
The ǫ-greedy
exploration strategy for maximum
likelihood model estimates. It
chooses a random action with
probability ϵ , otherwise it uses the
model to extract the greedy action.
"""
function (π::EpsilonGreedyExploration)(model, s)
    𝒜, ϵ = model.𝒜, π.ϵ
    if rand() < ϵ
        return rand(𝒜)
    end
    Q(s, a) = lookahead(model, s, a)
    return argmax(a -> Q(s, a), 𝒜)
end


mutable struct RmaxMDP
    """
    The R-MAX
    exploration strategy modifies the
    transition and reward model from
    maximum likelihood estimation.
    It assigns maximum reward
    rmax to any underexplored
    state-action pair, defined as being
    those that have been tried fewer
    than m times. In addition, all
    underexplored state-action pairs
    are modeled as transitioning
    to the same state. This RmaxMDP
    can be used as a replacement
    for the MaximumLikelihoodMDP
    introduced in algorithm 16.1.
    """
    𝒮::Any # state space (assumes 1:nstates)
    𝒜::Any # action space (assumes 1:nactions)
    N::Any # transition count N(s,a,s′)
    ρ::Any # reward sum ρ(s, a)
    γ::Any # discount
    U::Any # value function
    planner::Any
    # count threshold
    m::Any
    rmax::Any # maximum reward
end
function lookahead(model::RmaxMDP, s, a)
    𝒮, U, γ = model.𝒮, model.U, model.γ
    n = sum(model.N[s, a, :])
    if n < model.m
        return model.rmax / (1 - γ)
    end
    r = model.ρ[s, a] / n
    T(s, a, s′) = model.N[s, a, s′] / n
    return r + γ * sum(T(s, a, s′) * U[s′] for s′ in 𝒮)
end

function backup(model::RmaxMDP, U, s)
    return maximum(lookahead(model, s, a) for a in model.𝒜)
end
function update!(model::RmaxMDP, s, a, r, s′)
    model.N[s, a, s′] += 1
    model.ρ[s, a] += r
    update!(model.planner, model, s, a, r, s′)
    return model
end
function MDP(model::RmaxMDP)
    N, ρ, 𝒮, 𝒜, γ = model.N, model.ρ, model.𝒮, model.𝒜, model.γ
    T, R, m, rmax = similar(N), similar(ρ), model.m, model.rmax
    for s in 𝒮
        for a in 𝒜
            n = sum(N[s, a, :])
            if n < m
                T[s, a, :] .= 0.0
                T[s, a, s] = 1.0
                R[s, a] = rmax
            else
                T[s, a, :] = N[s, a, :] / n
                R[s, a] = ρ[s, a] / n
            end
        end
    end
    return MDP(T, R, γ)
end
