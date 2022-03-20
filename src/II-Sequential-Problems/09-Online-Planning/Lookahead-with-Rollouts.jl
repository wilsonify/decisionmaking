struct RolloutLookahead
    """
    A function that
        runs a rollout of policy π in problem problem from state s to depth d . It returns the total discounted reward.
        This function can be used with
        the greedy function (introduced in
        algorithm 7.5) to generate an action that is likely to be an improvement over the original rollout policy. We will use this algorithm later
        for problems other than MDPs, requiring us to only have to modify
        randstep appropriately.
    """
    problem::Any # problem
    π::Any # rollout policy
    d::Any # depth
end
randstep(problem::MDP, s, a) = problem.TR(s, a)
function rollout(problem, s, π, d)
    ret = 0.0
    for t = 1:d
        a = π(s)
        s, r = randstep(problem, s, a)
        ret += problem.γ^(t - 1) * r
    end
    return ret
end
function (π::RolloutLookahead)(s)
    U(s) = rollout(π.problem, s, π.π, π.d)
    return greedy(π.problem, U, s).a
end
