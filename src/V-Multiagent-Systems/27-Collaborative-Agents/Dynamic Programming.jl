struct DecPOMDPDynamicProgramming
    """
    Dynamic programming computes the optimal
joint policy π for a Dec-POMDP 𝒫 ,
given an initial belief b and horizon
depth d . We can directly use the
POMG algorithm as Dec-POMDPs
are a special collaborative class of
POMGs.
    """

    b::Any # initial belief
    d::Any # depth of conditional plans
end
function solve(M::DecPOMDPDynamicProgramming, 𝒫::DecPOMDP)
    ℐ, 𝒮, 𝒜, 𝒪, T, O, R, γ = 𝒫.ℐ, 𝒫.𝒮, 𝒫.𝒜, 𝒫.𝒪, 𝒫.T, 𝒫.O, 𝒫.R, 𝒫.γ
    R′(s, a) = [R(s, a) for i in ℐ]
    𝒫′ = POMG(γ, ℐ, 𝒮, 𝒜, 𝒪, T, O, R′)
    M′ = POMGDynamicProgramming(M.b, M.d)
    return solve(M′, 𝒫′)
end
