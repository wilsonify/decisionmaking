struct HeuristicSearch
    """
    Heuristic search runs m simulations starting from an initial state s to a depth d . 
    The search is guided by a heuristic initial value function Uhi , 
    which leads to optimality in the limit of simulations if it is an upper bound on the optimal value function.
    """
    
    problem::Any # problem
    Uhi::Any # upper bound on value function
    d::Any # depth
    m::Any # number of simulations
end
function simulate!(π::HeuristicSearch, U, s)
    problem = π.problem
    for d = 1:π.d
        a, u = greedy(problem, U, s)
        U[s] = u
        s = rand(problem.T(s, a))
    end
end
function (π::HeuristicSearch)(s)
    U = [π.Uhi(s) for s in π.problem.𝒮]
    for i = 1:m
        simulate!(π, U, s)
    end
    return greedy(π.problem, U, s).a
end
