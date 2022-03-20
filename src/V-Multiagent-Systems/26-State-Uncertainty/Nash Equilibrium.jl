
struct POMGNashEquilibrium
    """
    A Nash equilibrium is computed for a POMG problem
    with initial state distribution b by
    creating a simple game of all conditional plans to some depth d . We
    solve for a Nash equilibrium in this
    simple game using algorithm 24.5.
    For simplicity, we select the most
    probable joint policy. Alternatively,
    we can randomly select the joint
    policy at the start of execution.
    """
    b::Any # initial belief
    d::Any # depth of conditional plans
end
function create_conditional_plans(problem, d)
    ℐ, 𝒜, 𝒪 = problem.ℐ, problem.𝒜, problem.𝒪
    Π = [[ConditionalPlan(ai) for ai in 𝒜[i]] for i in ℐ]
    for t = 1:d
        Π = expand_conditional_plans(problem, Π)
    end
    return Π
end

function expand_conditional_plans(problem, Π)
    ℐ, 𝒜, 𝒪 = problem.ℐ, problem.𝒜, problem.𝒪
    return [
        [ConditionalPlan(ai, Dict(oi => πi for oi in 𝒪[i])) for πi in Π[i] for ai in 𝒜[i]]
        for i in ℐ
    ]
end
function solve(M::POMGNashEquilibrium, problem::POMG)
    ℐ, γ, b, d = problem.ℐ, problem.γ, M.b, M.d
    Π = create_conditional_plans(problem, d)
    U = Dict(π => utility(problem, b, π) for π in joint(Π))
    𝒢 = SimpleGame(γ, ℐ, Π, π -> U[π])
    π = solve(NashEquilibrium(), 𝒢)
    return Tuple(argmax(πi.p) for πi in π)
end
