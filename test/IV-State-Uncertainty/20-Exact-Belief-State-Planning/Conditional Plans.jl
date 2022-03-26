
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
    MDP 𝒫 starting at state s . Plans are
    represented as tuples consisting of
    an action and a dictionary mapping observations to subplans.
"""

function lookahead(𝒫::POMDP, U, s, a)
    𝒮, 𝒪, T, O, R, γ = 𝒫.𝒮, 𝒫.𝒪, 𝒫.T, 𝒫.O, 𝒫.R, 𝒫.γ
    u′ = sum(T(s, a, s′) * sum(O(a, s′, o) * U(o, s′) for o in 𝒪) for s′ in 𝒮)
    return R(s, a) + γ * u′
end
function evaluate_plan(𝒫::POMDP, π::ConditionalPlan, s)
    U(o, s′) = evaluate_plan(𝒫, π(o), s′)
    return isempty(π.subplans) ? 𝒫.R(s, π()) : lookahead(𝒫, U, s, π())
end
