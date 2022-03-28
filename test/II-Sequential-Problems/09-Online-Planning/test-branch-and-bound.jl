 
using DecisionMakingAlgorithms
"""
In this example, we apply branch and bound to the crying baby problem with a depth of 5. 
The upper bound comes from the fast informed bound and the lower bound comes from point-based value iteration. 
We compute the action from belief [ 0.4, 0.6 ] .
"""

""" An application of branch and bound to the crying baby problem. """
k_max = 10 # maximum number of iterations for bounds
πFIB = solve(FastInformedBound(k_max), problem)
d = 5 # depth
Ulo(b) = utility(πFIB, b)
B = [[p, 1 - p] for p = 0.0:0.2:1.0]
πPBVI = solve(PointBasedValueIteration(B, k_max), problem)
Uhi(b) = utility(πPBVI, b)
Qhi(b, a) = lookahead(problem, Uhi, b, a)
π = BranchAndBound(problem, d, Ulo, Qhi)
π([0.4, 0.6])
