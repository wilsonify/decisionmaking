"""
Implementation of the best-action worst-state (BAWS)
lower bound from equation (21.5) represented as an alpha vector.
"""
function baws_lowerbound(𝒫::POMDP)
    𝒮, 𝒜, R, γ = 𝒫.𝒮, 𝒫.𝒜, 𝒫.R, 𝒫.γ
    r = maximum(minimum(R(s, a) for s in 𝒮) for a in 𝒜) / (1 - γ)
    α = fill(r, length(𝒮))
    return α
end
