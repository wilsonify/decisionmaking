
struct ForwardSearch
    """
The forward search
algorithm for finding an approximately optimal action online for a
problem problem from a current state s .
The search is performed to depth d ,
at which point the terminal value
is estimated with an approximate
value function U . The returned
named tuple consists of the best
action a and its finite-horizon expected value u . The problem type is
not constrained to be an MDP; section 22.2 uses this same algorithm
in the context of partially observable problems with a different implementation for lookahead .
    """
    problem::Any # problem
    d::Any # depth
    U::Any # value function at depth d
end
function forward_search(problem, s, d, U)
    if d ≤ 0
        return (a = nothing, u = U(s))
    end
    best = (a = nothing, u = -Inf)
    U′(s) = forward_search(problem, s, d - 1, U).u
    for a in problem.𝒜
        u = lookahead(problem, U′, s, a)
        if u > best.u
            best = (a = a, u = u)
        end
    end
    return best
end
(π::ForwardSearch)(s) = forward_search(π.problem, s, π.d, π.U).a

"""
An example of applying forward search to a POMDP
problem.

Consider applying forward search to the machine replacement problem.
We can first obtain an approximate value function through QMDP (algorithm 21.2). We can then construct a ForwardSearch object, which was originally defined in algorithm 9.2. The call to lookahead within that function
will use the one defined for POMDPs in algorithm 20.5. The following code
applies forward search to the problem problem from belief state [ 0.5, 0.2, 0.3 ] to
depth 5 using our estimate of the utility obtained from QMDP at the leaf
nodes.
"""

k_max = 10 # maximum number of iterations of QMDP
πQMDP = solve(QMDP(k_max), problem)
d = 5 # depth
U(b) = utility(πQMDP, b)
π = ForwardSearch(problem, d, U)
π([0.5, 0.2, 0.3])
