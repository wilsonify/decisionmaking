"""
    Maximum
    margin inverse reinforcement
    learning, which computes a
    mixed policy whose feature
    expectations match those of given
    expert demonstrations. We use
    JuMP.jl to solve our constrained
    optimization problems. This
    implementation requires that the
    provided reinforcement learning
    struct has a weight vector ϕ that
    can be updated with new values.
    The method returns the stochastic
    weightings λ and parameteri    zations θs for the component
    policies.
"""
function calc_weighting(M::InverseReinforcementLearning, μs)
    μE = M.μE
    k = length(μE)
    model = Model(Ipopt.Optimizer)
    @variable(model, t)
    @variable(model, ϕ[1:k] ≥ 0)
    @objective(model, Max, t)
    for μ in μs
        @constraint(model, ϕ ⋅ μE ≥ ϕ ⋅ μ + t)
    end
    @constraint(model, ϕ ⋅ ϕ ≤ 1)
    optimize!(model)
    return (value(t), value.(ϕ))
end
function calc_policy_mixture(M::InverseReinforcementLearning, μs)
    μE = M.μE
    k = length(μs)
    model = Model(Ipopt.Optimizer)
    @variable(model, λ[1:k] ≥ 0)
    @objective(
        model,
        Min,
        (μE - sum(λ[i] * μs[i] for i = 1:k)) ⋅ (μE - sum(λ[i] * μs[i] for i = 1:k))
    )
    @constraint(model, sum(λ) == 1)
    optimize!(model)
    return value.(λ)
end

function optimize(M::InverseReinforcementLearning, θ)
    π, ϵ, RL = M.π, M.ϵ, M.RL
    θs = [θ]
    μs = [feature_expectations(M, s -> π(θ, s))]
    while true
        t, ϕ = calc_weighting(M, μs)
        if t ≤ ϵ
            break
        end
        copyto!(RL.ϕ, ϕ) # R(s,a) = ϕ⋅β(s,a)
        θ = optimize(RL, π, θ)
        push!(θs, θ)
        push!(μs, feature_expectations(M, s -> π(θ, s)))
    end
    λ = calc_policy_mixture(M, μs)
    return λ, θs
end
