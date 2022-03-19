"""
Locally weighted
value function approximation defined by a kernel function k and a
vector of utilities θ at states in S .
"""

mutable struct LocallyWeightedValueFunction
    k::Any # kernel function k(s, s′)
    S::Any # set of discrete states
    θ::Any # vector of values at states in S

end

function (Uθ::LocallyWeightedValueFunction)(s)
    w = normalize([Uθ.k(s, s′) for s′ in Uθ.S], 1)
    return Uθ.θ ⋅ w
end
function fit!(Uθ::LocallyWeightedValueFunction, S, U)
    Uθ.θ = U
    return Uθ
end
