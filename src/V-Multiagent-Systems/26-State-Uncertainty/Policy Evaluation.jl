
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
function lookahead(problem::POMG, U, s, a)
    𝒮, 𝒪, T, O, R, γ = problem.𝒮, joint(problem.𝒪), problem.T, problem.O, problem.R, problem.γ
    u′ = sum(T(s, a, s′) * sum(O(a, s′, o) * U(o, s′) for o in 𝒪) for s′ in 𝒮)
    return R(s, a) + γ * u′
end
function evaluate_plan(problem::POMG, π, s)
    a = Tuple(πi() for πi in π)
    U(o, s′) = evaluate_plan(problem, [πi(oi) for (πi, oi) in zip(π, o)], s′)
    return isempty(first(π).subplans) ? problem.R(s, a) : lookahead(problem, U, s, a)
end
function utility(problem::POMG, b, π)
    u = [evaluate_plan(problem, π, s) for s in problem.𝒮]
    return sum(bs * us for (bs, us) in zip(b, u))
end
