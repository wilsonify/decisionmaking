struct RolloutLookahead
    """
    A function that
        runs a rollout of policy π in prob        lem 𝒫 from state s to depth d . It re        turns the total discounted reward.
        This function can be used with
        the greedy function (introduced in
        algorithm 7.5) to generate an ac        tion that is likely to be an improve        ment over the original rollout pol        icy. We will use this algorithm later
        for problems other than MDPs, re        quiring us to only have to modify
        randstep appropriately.
    """
    𝒫::Any # problem
    π::Any # rollout policy
    d::Any # depth
end
randstep(𝒫::MDP, s, a) = 𝒫.TR(s, a)
function rollout(𝒫, s, π, d)
    ret = 0.0
    for t = 1:d
        a = π(s)
        s, r = randstep(𝒫, s, a)
        ret += 𝒫.γ^(t - 1) * r
    end
    return ret
end
function (π::RolloutLookahead)(s)
    U(s) = rollout(π.𝒫, s, π.π, π.d)
    return greedy(π.𝒫, U, s).a
end
