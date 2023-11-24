"""
Linear regression
value function approximation, defined by a basis vector function β
and a vector of parameters θ .
"""
mutable struct LinearRegressionValueFunction
    β::Any # basis vector function
    θ::Any # vector of parameters
end


function (Uθ::LinearRegressionValueFunction)(s)
    return Uθ.β(s) ⋅ Uθ.θ
end

function fit!(Uθ::LinearRegressionValueFunction, S, U)
    X = hcat([Uθ.β(s) for s in S]...)'
    Uθ.θ = pinv(X) * U
    return Uθ
end
