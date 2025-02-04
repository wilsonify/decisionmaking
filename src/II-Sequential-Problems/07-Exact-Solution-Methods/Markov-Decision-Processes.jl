struct MDP
    """
    Data structure for an MDP. 
    We will use the TR field later to sample the next state and reward given the current state
    and action: s′, r = TR(s, a) . 
    In mathematical writing, 
    MDPs are sometimes defined in terms of a tuple consisting of the various components of the MDP, written
    """
    y::Any # discount factor
    S::Any # state space
    A::Any # action space
    T::Any # transition function
    R::Any # reward function
    TR::Any # sample transition and reward
end


function lookahead(problem::MDP, U, s, a)
    """
    Functions for computing the lookahead state-action
        value from a state s given an action
        a using an estimate of the value
        function U for the MDP problem . The second version handles the case when
        U is a vector.
    """
    𝒮, T, R, γ = problem.𝒮, problem.T, problem.R, problem.γ
    return R(s, a) + γ * sum(T(s, a, s′) * U(s′) for s′ in 𝒮)
end

function lookahead(problem::MDP, U::Vector, s, a)
    𝒮, T, R, γ = problem.𝒮, problem.T, problem.R, problem.γ
    return R(s, a) + γ * sum(T(s, a, s′) * U[i] for (i, s′) in enumerate(𝒮))
end

function backup(problem::MDP, U, s)
    """ 
    the backup procedure applied to an MDP problem , 
    which improves a value function U at state s .
    """
    return maximum(lookahead(problem, U, s, a) for a in problem.𝒜)
end

function iterative_policy_evaluation(problem::MDP, π, k_max)
    """
    Iterative policy
evaluation, which iteratively computes the value function for a policy π for MDP problem with discrete state
and action spaces using k_max iterations.
    """
    𝒮, T, R, γ = problem.𝒮, problem.T, problem.R, problem.γ
    U = [0.0 for s in 𝒮]
    for k = 1:k_max
        U = [lookahead(problem, U, s, π(s)) for s in 𝒮]
    end
    return U
end

function policy_evaluation(problem::MDP, π)
    """
    Exact policy evaluation, which computes the value
function for a policy π for an MDP
problem with discrete state and action
spaces.
    """
    𝒮, R, T, γ = problem.𝒮, problem.R, problem.T, problem.γ
    R′ = [R(s, π(s)) for s in 𝒮]
    T′ = [T(s, π(s), s′) for s in 𝒮, s′ in 𝒮]
    return (I - γ*T′)\R′
    end



