mutable struct BayesianMDP
    """
    A Bayesian update method when the posterior
    distribution over transition models is represented as a product of
    Dirichlet distributions. We assume
    in this implementation that the reward model R is known, though
    we can use Bayesian methods to
    estimate expected reward from experience. The matrix D associates
    Dirichlet distributions with every
    state-action pair to model uncertainty in the transition to their successor states.
    """
    𝒮::Any # state space (assumes 1:nstates)
    𝒜::Any # action space (assumes 1:nactions)
    D::Any # Dirichlet distributions D[s,a]
    R::Any # reward function as matrix (not estimated)
    γ::Any # discount
    U::Any # value function
    planner::Any
end
function lookahead(model::BayesianMDP, s, a)
    𝒮, U, γ = model.𝒮, model.U, model.γ
    n = sum(model.D[s, a].alpha)
    if n == 0
        return 0.0
    end
    r = model.R(s, a)
    T(s, a, s′) = model.D[s, a].alpha[s′] / n
    return r + γ * sum(T(s, a, s′) * U[s′] for s′ in 𝒮)
end


function update!(model::BayesianMDP, s, a, r, s′)
    α = model.D[s, a].alpha
    α[s′] += 1
    model.D[s, a] = Dirichlet(α)
    update!(model.planner, model, s, a, r, s′)
    return model
end
