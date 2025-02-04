
"""
This nonlinear program computes a Nash equilibrium for a simple game problem . 
"""
struct NashEquilibrium end
function tensorform(problem::SimpleGame)
    ℐ, 𝒜, R = problem.ℐ, problem.𝒜, problem.R
    ℐ′ = eachindex(ℐ)
    𝒜′ = [eachindex(𝒜[i]) for i in ℐ]
    R′ = [R(a) for a in joint(𝒜)]
    return ℐ′, 𝒜′, R′
end


function solve(M::NashEquilibrium, problem::SimpleGame)
    ℐ, 𝒜, R = tensorform(problem)
    model = Model(Ipopt.Optimizer)
    @variable(model, U[ℐ])
    @variable(model, π[i = ℐ, 𝒜[i]] ≥ 0)
    @NLobjective(
        model,
        Min,
        sum(
            U[i] - sum(prod(π[j, a[j]] for j in ℐ) * R[y][i] for (y, a) in enumerate(joint(𝒜))) for
            i in ℐ
        )
    )
    @NLconstraint(
        model,
        [i = ℐ, ai = 𝒜[i]],
        U[i] ≥ sum(
            prod(j == i ? (a[j] == ai ? 1.0 : 0.0) : π[j, a[j]] for j in ℐ) * R[y][i] for
            (y, a) in enumerate(joint(𝒜))
        )
    )
    @constraint(model, [i = ℐ], sum(π[i, ai] for ai in 𝒜[i]) == 1)
    optimize!(model)
    πi′(i) = SimpleGamePolicy(problem.𝒜[i][ai] => value(π[i, ai]) for ai in 𝒜[i])
    return [πi′(i) for i in ℐ]
end
