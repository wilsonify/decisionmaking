
"""
Conditional plans
represent policies in a finite horizon POMG. They are defined for
a single agent in algorithm 20.1.
We can compute the utility associated with executing a joint policy π represented by conditional
plans when starting from a state
s . Computing the utility from an
initial state distribution b involves
taking a weighted average of utilities when starting from different
states.
"""
function lookahead(𝒫::POMG, U, s, a)
    𝒮, 𝒪, T, O, R, γ = 𝒫.𝒮, joint(𝒫.𝒪), 𝒫.T, 𝒫.O, 𝒫.R, 𝒫.γ
    u′ = sum(T(s, a, s′) * sum(O(a, s′, o) * U(o, s′) for o in 𝒪) for s′ in 𝒮)
    return R(s, a) + γ * u′
end
function evaluate_plan(𝒫::POMG, π, s)
    a = Tuple(πi() for πi in π)
    U(o, s′) = evaluate_plan(𝒫, [πi(oi) for (πi, oi) in zip(π, o)], s′)
    return isempty(first(π).subplans) ? 𝒫.R(s, a) : lookahead(𝒫, U, s, a)
end
function utility(𝒫::POMG, b, π)
    u = [evaluate_plan(𝒫, π, s) for s in 𝒫.𝒮]
    return sum(bs * us for (bs, us) in zip(b, u))
end
