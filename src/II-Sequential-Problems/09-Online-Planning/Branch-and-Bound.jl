struct BranchAndBound
    """
    The branch and
bound algorithm for finding an
approximately optimal action online for a discrete MDP problem from a
current state s . The search is performed to depth d with value function lower bound Ulo and action
value function upper bound Qhi .
The returned named tuple consists
of the best action a and its finitehorizon expected value u . This algorithm is also used for POMDPs.
    """
    problem::Any # problem
    d::Any # depth
    Ulo::Any # lower bound on value function at depth d
    Qhi::Any # upper bound on action value function
end
function branch_and_bound(problem, s, d, Ulo, Qhi)
    if d ≤ 0
        return (a = nothing, u = Ulo(s))
    end
    U′(s) = branch_and_bound(problem, s, d - 1, Ulo, Qhi).u
    best = (a = nothing, u = -Inf)
    for a in sort(problem.𝒜, by = a -> Qhi(s, a), rev = true)
        if Qhi(s, a) < best.u
            return best # safe to prune
        end
        u = lookahead(problem, U′, s, a)
        if u > best.u
            best = (a = a, u = u)
        end
    end
    return best
end

(π::BranchAndBound)(s) = branch_and_bound(π.problem, s, π.d, π.Ulo, π.Qhi).a
