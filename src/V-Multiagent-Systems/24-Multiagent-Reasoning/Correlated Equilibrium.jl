"""
A joint correlated
policy is represented by a dictionary mapping joint actions to probabilities. If π is a joint correlated
policy, evaluating π(a) will return
the probability associated with the
joint action a .
"""
mutable struct JointCorrelatedPolicy
    p::Any # dictionary mapping from joint actions to probabilities
    JointCorrelatedPolicy(p::Base.Generator) = new(Dict(p))
end
(π::JointCorrelatedPolicy)(a) = get(π.p, a, 0.0)
function (π::JointCorrelatedPolicy)()
    D = SetCategorical(collect(keys(π.p)), collect(values(π.p)))
    return rand(D)
end


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
