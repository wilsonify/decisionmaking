"""
    The Q-learning
    update with action value function
    approximation. With each new ex    perience tuple s , a , r , s′ , we up    date our vector θ with constant
    learning rate α . Our parameter    ized action value function is given
    by Q(θ,s,a) and its gradient is
    ∇Q(θ,s,a) .
    """
struct GradientQLearning
    𝒜::Any # action space (assumes 1:nactions)
    γ::Any # discount
    Q::Any # parameterized action value function Q(θ,s,a)
    ∇Q::Any # gradient of action value function
    θ::Any # action value function parameter
    α::Any # learning rate
end

function lookahead(model::GradientQLearning, s, a)
    return model.Q(model.θ, s, a)
end

function update!(model::GradientQLearning, s, a, r, s′)
    𝒜, γ, Q, θ, α = model.𝒜, model.γ, model.Q, model.θ, model.α
    u = maximum(Q(θ, s′, a′) for a′ in 𝒜)
    Δ = (r + γ * u - Q(θ, s, a)) * model.∇Q(θ, s, a)
    θ[:] += α * scale_gradient(Δ, 1)
    return model
end
