struct DecPOMDPNonlinearProgramming
    """
    Nonlinear programming (NLP) computes the optimal joint controller policy π for
    a Dec-POMDP problem , given an initial
    belief b and number of controller
    nodes ℓ for each agent. This generalizes the NLP solution in algorithm 23.5.
    """
    b::Any # initial belief
    ℓ::Any # number of nodes for each agent
end
function tensorform(problem::DecPOMDP)
    ℐ, 𝒮, 𝒜, 𝒪, R, T, O = problem.ℐ, problem.𝒮, problem.𝒜, problem.𝒪, problem.R, problem.T, problem.O
    ℐ′ = eachindex(ℐ)
    𝒮′ = eachindex(𝒮)
    𝒜′ = [eachindex(𝒜i) for 𝒜i in 𝒜]
    𝒪′ = [eachindex(𝒪i) for 𝒪i in 𝒪]
    R′ = [R(s, a) for s in 𝒮, a in joint(𝒜)]
    T′ = [T(s, a, s′) for s in 𝒮, a in joint(𝒜), s′ in 𝒮]
    O′ = [O(a, s′, o) for a in joint(𝒜), s′ in 𝒮, o in joint(𝒪)]
    return ℐ′, 𝒮′, 𝒜′, 𝒪′, R′, T′, O′
end

function solve(M::DecPOMDPNonlinearProgramming, problem::DecPOMDP)
    problem, γ, b = problem, problem.γ, M.b
    ℐ, 𝒮, 𝒜, 𝒪, R, T, O = tensorform(problem)
    X = [collect(1:M.ℓ) for i in ℐ]
    jointX, joint𝒜, joint𝒪 = joint(X), joint(𝒜), joint(𝒪)
    x1 = jointX[1]
    model = Model(Ipopt.Optimizer)
    @variable(model, U[jointX, 𝒮])
    @variable(model, ψ[i = ℐ, X[i], 𝒜[i]] ≥ 0)
    @variable(model, η[i = ℐ, X[i], 𝒜[i], 𝒪[i], X[i]] ≥ 0)
    @objective(model, Max, b ⋅ U[x1, :])
    @NLconstraint(
        model,
        [x = jointX, s = 𝒮],
        U[x, s] == (sum(
            prod(ψ[i, x[i], a[i]] for i in ℐ) * (
                R[s, y] +
                γ * sum(
                    T[s, y, s′] * sum(
                        O[y, s′, z] * sum(
                            prod(η[i, x[i], a[i], o[i], x′[i]] for i in ℐ) * U[x′, s′] for
                            x′ in jointX
                        ) for (z, o) in enumerate(joint𝒪)
                    ) for s′ in 𝒮
                )
            ) for (y, a) in enumerate(joint𝒜)
        ))
    )
    @constraint(model, [i = ℐ, xi = X[i]], sum(ψ[i, xi, ai] for ai in 𝒜[i]) == 1)
    @constraint(
        model,
        [i = ℐ, xi = X[i], ai = 𝒜[i], oi = 𝒪[i]],
        sum(η[i, xi, ai, oi, xi′] for xi′ in X[i]) == 1
    )
    optimize!(model)
    ψ′, η′ = value.(ψ), value.(η)
    return [
        ControllerPolicy(
            problem,
            X[i],
            Dict((xi, problem.𝒜[i][ai]) => ψ′[i, xi, ai] for xi in X[i], ai in 𝒜[i]),
            Dict(
                (xi, problem.𝒜[i][ai], problem.𝒪[i][oi], xi′) => η′[i, xi, ai, oi, xi′] for xi in X[i],
                ai in 𝒜[i], oi in 𝒪[i], xi′ in X[i]
            ),
        ) for i in ℐ
    ]
end
