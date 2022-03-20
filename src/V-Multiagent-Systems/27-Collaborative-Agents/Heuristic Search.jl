
struct DecPOMDPHeuristicSearch
    """
    Memory bounded
    heuristic search uses a heuristic
    function to search the space of conditional plans for a Dec-POMDP
    problem . The solve function tries to maximize the value at an initial belief b for joint conditional plans
    of depth d . The explore function
    generates a belief t steps into the
    future by taking random actions
    and simulating actions and observations. The algorithm is memorybounded, only keeping π_max conditional plans per agent.
    """

    b::Any # initial belief
    d::Any # depth of conditional plans
    π_max::Any # number of policies
end
function solve(M::DecPOMDPHeuristicSearch, problem::DecPOMDP)
    ℐ, 𝒮, 𝒜, 𝒪, T, O, R, γ = problem.ℐ, problem.𝒮, problem.𝒜, problem.𝒪, problem.T, problem.O, problem.R, problem.γ
    b, d, π_max = M.b, M.d, M.π_max
    R′(s, a) = [R(s, a) for i in ℐ]
    problem′ = POMG(γ, ℐ, 𝒮, 𝒜, 𝒪, T, O, R′)
    Π = [[ConditionalPlan(ai) for ai in 𝒜[i]] for i in ℐ]
    for t = 1:d
        allΠ = expand_conditional_plans(problem, Π)
        Π = [[] for i in ℐ]
        for z = 1:π_max
            b′ = explore(M, problem, t)
            π = argmax(π -> first(utility(problem′, b′, π)), joint(allΠ))
            for i in ℐ
                push!(Π[i], π[i])
                filter!(πi -> πi != π[i], allΠ[i])
            end
        end
    end
    return argmax(π -> first(utility(problem′, b, π)), joint(Π))
end

function explore(M::DecPOMDPHeuristicSearch, problem::DecPOMDP, t)
    ℐ, 𝒮, 𝒜, 𝒪, T, O, R, γ = problem.ℐ, problem.𝒮, problem.𝒜, problem.𝒪, problem.T, problem.O, problem.R, problem.γ
    b = copy(M.b)
    b′ = similar(b)
    s = rand(SetCategorical(𝒮, b))
    for τ = 1:t
        a = Tuple(rand(𝒜i) for 𝒜i in 𝒜)
        s′ = rand(SetCategorical(𝒮, [T(s, a, s′) for s′ in 𝒮]))
        o = rand(SetCategorical(joint(𝒪), [O(a, s′, o) for o in joint(𝒪)]))
        for (i′, s′) in enumerate(𝒮)
            po = O(a, s′, o)
            b′[i′] = po * sum(T(s, a, s′) * b[i] for (i, s) in enumerate(𝒮))
        end
        normalize!(b′, 1)
        b, s = b′, s′
    end
    return b′
end
