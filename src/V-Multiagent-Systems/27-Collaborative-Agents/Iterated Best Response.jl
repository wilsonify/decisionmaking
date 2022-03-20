
struct DecPOMDPIteratedBestResponse
    """
    Iterated best response for a collaborative DecPOMDP problem iteratively performs a deterministic best response to rapidly
search the space of conditional
plan policies. The solve function
executes this procedure for up to
k_max steps, maximizing the value
at an initial belief b for conditional
plans of depth d .
    """
    b::Any # initial belief
    d::Any # depth of conditional plans
    k_max::Any # number of iterations
end
function solve(M::DecPOMDPIteratedBestResponse, problem::DecPOMDP)
    ℐ, 𝒮, 𝒜, 𝒪, T, O, R, γ = problem.ℐ, problem.𝒮, problem.𝒜, problem.𝒪, problem.T, problem.O, problem.R, problem.γ
    b, d, k_max = M.b, M.d, M.k_max
    R′(s, a) = [R(s, a) for i in ℐ]
    problem′ = POMG(γ, ℐ, 𝒮, 𝒜, 𝒪, T, O, R′)
    Π = create_conditional_plans(problem, d)
    π = [rand(Π[i]) for i in ℐ]
    for k = 1:k_max
        for i in shuffle(ℐ)
            π′(πi) = Tuple(j == i ? πi : π[j] for j in ℐ)
            Ui(πi) = utility(problem′, b, π′(πi))[i]
            π[i] = argmax(Ui, Π[i])
        end
    end
    return Tuple(π)
end
