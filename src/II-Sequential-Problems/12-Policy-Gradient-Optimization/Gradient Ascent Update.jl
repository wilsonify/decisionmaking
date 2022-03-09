struct PolicyGradientUpdate
    """
    The gradient ascent method for policy optimization. It takes a step from a point
θ in the direction of the gradient
∇U with step factor α . We can use
one of the methods in the previous
chapter to compute ∇U .
    """
    ∇U::Any # policy gradient estimate
    α::Any # step factor
end
function update(M::PolicyGradientUpdate, θ)
    return θ + M.α * M.∇U(θ)
end

"""
Methods for gra    dient scaling and clipping. Gradi    ent scaling limits the magnitude
    of the provided gradient vector ∇
    to L2_max . Gradient clipping pro    vides elementwise clamping of the
    provided gradient vector ∇ to be    tween a and b .
"""
scale_gradient(∇, L2_max) = min(L2_max / norm(∇), 1) * ∇
clip_gradient(∇, a, b) = clamp.(∇, a, b)
