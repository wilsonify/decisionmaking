struct NonlinearProgramming
    """
    A nonlinear programming approach to compute
    the optimal fixed-size controller
    policy for POMDP 𝒫 starting at initial belief b . The size of the finite
    state controller is specified by the
    number of nodes ℓ .
    """
    b::Any # initial belief
    ℓ::Any # number of nodes
end
function tensorform(𝒫::POMDP)
    𝒮, 𝒜, 𝒪, R, T, O = 𝒫.𝒮, 𝒫.𝒜, 𝒫.𝒪, 𝒫.R, 𝒫.T, 𝒫.O
    𝒮′ = eachindex(𝒮)
    𝒜′ = eachindex(𝒜)
    𝒪′ = eachindex(𝒪)
    R′ = [R(s, a) for s in 𝒮, a in 𝒜]
    T′ = [T(s, a, s′) for s in 𝒮, a in 𝒜, s′ in 𝒮]
    O′ = [O(a, s′, o) for a in 𝒜, s′ in 𝒮, o in 𝒪]
    return 𝒮′, 𝒜′, 𝒪′, R′, T′, O′
end

function solve(M::NonlinearProgramming, 𝒫::POMDP)
    x1, X = 1, collect(1:M.ℓ)
    𝒫, γ, b = 𝒫, 𝒫.γ, M.b
    𝒮, 𝒜, 𝒪, R, T, O = tensorform(𝒫)
    model = Model(Ipopt.Optimizer)
    @variable(model, U[X, 𝒮])
    @variable(model, ψ[X, 𝒜] ≥ 0)
    @variable(model, η[X, 𝒜, 𝒪, X] ≥ 0)
    @objective(model, Max, b ⋅ U[x1, :])
    @NLconstraint(
        model,
        [x = X, s = 𝒮],
        U[x, s] == (sum(
            ψ[x, a] * (
                R[s, a] +
                γ * sum(
                    T[s, a, s′] * sum(
                        O[a, s′, o] * sum(η[x, a, o, x′] * U[x′, s′] for x′ in X) for o in 𝒪
                    ) for s′ in 𝒮
                )
            ) for a in 𝒜
        ))
    )
    @constraint(model, [x = X], sum(ψ[x, :]) == 1)
    @constraint(model, [x = X, a = 𝒜, o = 𝒪], sum(η[x, a, o, :]) == 1)
    optimize!(model)
    ψ′, η′ = value.(ψ), value.(η)
    return ControllerPolicy(
        𝒫,
        X,
        Dict((x, 𝒫.𝒜[a]) => ψ′[x, a] for x in X, a in 𝒜),
        Dict(
            (x, 𝒫.𝒜[a], 𝒫.𝒪[o], x′) => η′[x, a, o, x′] for x in X, a in 𝒜, o in 𝒪, x′ in X
        ),
    )
end
