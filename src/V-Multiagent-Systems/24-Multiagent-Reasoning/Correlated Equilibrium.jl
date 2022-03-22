

struct CorrelatedEquilibrium end
function solve(M::CorrelatedEquilibrium, problem::SimpleGame)
    ℐ, 𝒜, R = problem.ℐ, problem.𝒜, problem.R
    model = Model(Ipopt.Optimizer)
    @variable(model, π[joint(𝒜)] ≥ 0)
    @objective(model, Max, sum(sum(π[a] * R(a) for a in joint(𝒜))))
    @constraint(
        model,
        [i = ℐ, ai = 𝒜[i], ai′ = 𝒜[i]],
        sum(R(a)[i] * π[a] for a in joint(𝒜) if a[i] == ai) ≥
        sum(R(joint(a, ai′, i))[i] * π[a] for a in joint(𝒜) if a[i] == ai)
    )
    @constraint(model, sum(π) == 1)
    optimize!(model)
    return JointCorrelatedPolicy(a => value(π[a]) for a in joint(𝒜))
end
