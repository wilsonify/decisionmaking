
struct POMGNashEquilibrium
    """
    A Nash equilibrium is computed for a POMG 𝒫
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
function create_conditional_plans(𝒫, d)
    ℐ, 𝒜, 𝒪 = 𝒫.ℐ, 𝒫.𝒜, 𝒫.𝒪
    Π = [[ConditionalPlan(ai) for ai in 𝒜[i]] for i in ℐ]
    for t = 1:d
        Π = expand_conditional_plans(𝒫, Π)
    end
    return Π
end

function expand_conditional_plans(𝒫, Π)
    ℐ, 𝒜, 𝒪 = 𝒫.ℐ, 𝒫.𝒜, 𝒫.𝒪
    return [
        [ConditionalPlan(ai, Dict(oi => πi for oi in 𝒪[i])) for πi in Π[i] for ai in 𝒜[i]]
        for i in ℐ
    ]
end
function solve(M::POMGNashEquilibrium, 𝒫::POMG)
    ℐ, γ, b, d = 𝒫.ℐ, 𝒫.γ, M.b, M.d
    Π = create_conditional_plans(𝒫, d)
    U = Dict(π => utility(𝒫, b, π) for π in joint(Π))
    𝒢 = SimpleGame(γ, ℐ, Π, π -> U[π])
    π = solve(NashEquilibrium(), 𝒢)
    return Tuple(argmax(πi.p) for πi in π)
end
