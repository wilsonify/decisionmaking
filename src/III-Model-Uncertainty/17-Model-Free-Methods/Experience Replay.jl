"""
    Q-learning with
    function approximation and ex    perience replay. The update de    pends on a parameterized policy
    Q(θ,s,a) and gradient ∇Q(θ,s,a) .
    It updates the parameter vector θ
    and the circular memory buffer
    provided by DataStructures.jl .
    It updates θ every m steps using
    a gradient estimated from m_grad
    samples from the buffer.
"""
struct ReplayGradientQLearning

    𝒜::Any # action space (assumes 1:nactions)
    γ::Any     # discount
    Q::Any     # parameterized action value funciton Q(θ,s,a)
    ∇Q::Any     # gradient of action value function
    θ::Any     # action value function parameter
    α::Any     # learning rate
    buffer::Any # circular memory buffer
    m::Any     # number of steps between gradient updates
    m_grad::Any # batch size
end

function lookahead(model::ReplayGradientQLearning, s, a)
    return model.Q(model.θ, s, a)
end
function update!(model::ReplayGradientQLearning, s, a, r, s′)
    𝒜, γ, Q, θ, α = model.𝒜, model.γ, model.Q, model.θ, model.α
    buffer, m, m_grad = model.buffer, model.m, model.m_grad
    if isfull(buffer)
        U(s) = maximum(Q(θ, s, a) for a in 𝒜)
        ∇Q(s, a, r, s′) = (r + γ * U(s′) - Q(θ, s, a)) * model.∇Q(θ, s, a)
        Δ = mean(∇Q(s, a, r, s′) for (s, a, r, s′) in rand(buffer, m_grad))
        θ[:] += α * scale_gradient(Δ, 1)
        for i = 1:m # discard oldest experiences
            popfirst!(buffer)
        end
    else
        push!(buffer, (s, a, r, s′))
    end
    return model
end
