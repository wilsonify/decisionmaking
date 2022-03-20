
struct POMGDynamicProgramming
    """
    Dynamic programming computes a Nash equilibrium π for a POMG problem , given an
    initial belief b and horizon depth
    d . It iteratively computes the policy trees and their expected utilities
    at each step. The pruning phase at
    each iteration removes dominated
    policies, which are policy trees that
    result in a lower expected utility
    than at least one other available policy tree.
    """

    b::Any # initial belief
    d::Any # depth of conditional plans
end
function solve(M::POMGDynamicProgramming, problem::POMG)
    ℐ, 𝒮, 𝒜, R, γ, b, d = problem.ℐ, problem.𝒮, problem.𝒜, problem.R, problem.γ, M.b, M.d
    Π = [[ConditionalPlan(ai) for ai in 𝒜[i]] for i in ℐ]
    for t = 1:d
        Π = expand_conditional_plans(problem, Π)
        prune_dominated!(Π, problem)
    end
    𝒢 = SimpleGame(γ, ℐ, Π, π -> utility(problem, b, π))
    π = solve(NashEquilibrium(), 𝒢)
    return Tuple(argmax(πi.p) for πi in π)
end

function prune_dominated!(Π, problem::POMG)
    done = false
    while !done
        done = true
        for i in shuffle(problem.ℐ)
            for πi in shuffle(Π[i])
                if length(Π[i]) > 1 && is_dominated(problem, Π, i, πi)
                    filter!(πi′ -> πi′ ≠ πi, Π[i])
                    done = false
                    break
                end
            end
        end
    end
end
function is_dominated(problem::POMG, Π, i, πi)
    ℐ, 𝒮 = problem.ℐ, problem.𝒮
    jointΠnoti = joint([Π[j] for j in ℐ if j ≠ i])
    π(πi′, πnoti) = [j == i ? πi′ : πnoti[j > i ? j - 1 : j] for j in ℐ]
    Ui = Dict(
        (πi′, πnoti, s) => evaluate_plan(problem, π(πi′, πnoti), s)[i] for πi′ in Π[i],
        πnoti in jointΠnoti, s in 𝒮
    )
    model = Model(Ipopt.Optimizer)
    @variable(model, δ)
    @variable(model, b[jointΠnoti, 𝒮] ≥ 0)
    @objective(model, Max, δ)
    @constraint(
        model,
        [πi′ = Π[i]],
        sum(
            b[πnoti, s] * (Ui[πi′, πnoti, s] - Ui[πi, πnoti, s]) for πnoti in jointΠnoti for
            s in 𝒮
        ) ≥ δ
    )
    @constraint(model, sum(b) == 1)
    optimize!(model)
    return value(δ) ≥ 0
end
