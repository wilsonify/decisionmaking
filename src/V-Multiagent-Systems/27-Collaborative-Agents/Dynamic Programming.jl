

struct DecPOMDPDynamicProgramming
    """
    Dynamic programming computes the optimal joint policy π for a Dec-POMDP problem ,
    given an initial belief b and horizon depth d . 
    We can directly use the POMG algorithm as 
    Dec-POMDPs are a special collaborative class of POMGs.
    """

    b::Any # initial belief
    d::Any # depth of conditional plans
end
function solve(M::DecPOMDPDynamicProgramming, problem::DecPOMDP)
    ℐ, 𝒮, 𝒜, 𝒪, T, O, R, γ = problem.ℐ, problem.𝒮, problem.𝒜, problem.𝒪, problem.T, problem.O, problem.R, problem.γ
    R′(s, a) = [R(s, a) for i in ℐ]
    problem′ = POMG(γ, ℐ, 𝒮, 𝒜, 𝒪, T, O, R′)
    M′ = POMGDynamicProgramming(M.b, M.d)
    return solve(M′, problem′)
end
