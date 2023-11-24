struct ConditionalPlan
    """
    The conditional
plan data structure consisting of an
action and a mapping from observations to subplans. The subplans
field is a Dict from observations to
conditional plans. For convenience,
we have created a special constructor for plans consisting of a single
node.
    """
    # action to take at root
    a::Any
    subplans::Any # dictionary mapping observations to subplans
end
ConditionalPlan(a) = ConditionalPlan(a, Dict())
(π::ConditionalPlan)() = π.a
(π::ConditionalPlan)(o) = π.subplans[o]

"""
A method for
    evaluating a conditional plan π for
    MDP problem starting at state s . Plans are
    represented as tuples consisting of
    an action and a dictionary mapping observations to subplans.
"""

function lookahead(problem::POMDP, U, s, a)
    𝒮, 𝒪, T, O, R, γ = problem.𝒮, problem.𝒪, problem.T, problem.O, problem.R, problem.γ
    u′ = sum(T(s, a, s′) * sum(O(a, s′, o) * U(o, s′) for o in 𝒪) for s′ in 𝒮)
    return R(s, a) + γ * u′
end
function evaluate_plan(problem::POMDP, π::ConditionalPlan, s)
    U(o, s′) = evaluate_plan(problem, π(o), s′)
    return isempty(π.subplans) ? problem.R(s, π()) : lookahead(problem, U, s, π())
end

"""
We can generate an alpha vector from a conditional plan by calling evaluate_plan from all possible initial states.
"""
function alphavector(problem::POMDP, π::ConditionalPlan)
    return [evaluate_plan(problem, π, s) for s in problem.𝒮]
end