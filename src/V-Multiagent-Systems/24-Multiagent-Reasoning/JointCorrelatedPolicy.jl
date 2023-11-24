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
