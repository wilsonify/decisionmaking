
"""
The simulation of a joint policy in simple game problem for k_max iterations. 
The joint policy π is a vector of policies that can be individually updated through calls to update!(πi, a) .
"""
function simulate(problem::SimpleGame, π, k_max)
    for k = 1:k_max
        a = [πi() for πi in π]
        for πi in π
            update!(πi, a)
        end
    end
    return π
end


mutable struct FictitiousPlay
    """
    Fictitious play is
    a simple learning algorithm for an
    agent i of a simple game problem that
    maintains counts of other agent action selections over time and averages them assuming this is their
    stochastic policy. It then computes
    a best response to this policy and
    performs the corresponding utilitymaximizing action.
    (πi::FictitiousPlay)() = πi.πi()
    (πi::FictitiousPlay)(ai) = πi.πi(ai)
    """
    problem::Any # simple game
    i::Any # agent index
    N::Any # array of action count dictionaries
    πi::Any # current policy
end
function FictitiousPlay(problem::SimpleGame, i)
    N = [Dict(aj => 1 for aj in problem.𝒜[j]) for j in problem.ℐ]
    πi = SimpleGamePolicy(ai => 1.0 for ai in problem.𝒜[i])
    return FictitiousPlay(problem, i, N, πi)
end

function update!(πi::FictitiousPlay, a)
    N, problem, ℐ, i = πi.N, πi.problem, πi.problem.ℐ, πi.i
    for (j, aj) in enumerate(a)
        N[j][aj] += 1
    end
    p(j) = SimpleGamePolicy(aj => u / sum(values(N[j])) for (aj, u) in N[j])
    π = [p(j) for j in ℐ]
    πi.πi = best_response(problem, π, i)
end
