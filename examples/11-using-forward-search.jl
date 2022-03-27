using DecisionMakingAlgorithms
"""
An example of applying forward search to a POMDP problem.

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
