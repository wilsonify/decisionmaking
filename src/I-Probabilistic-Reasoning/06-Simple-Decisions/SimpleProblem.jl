
struct SimpleProblem
    """
    simple problem as a decision network. 
    A decision network is a Bayesian network with chance, decision, and utility variables. 
    Utility variables are treated as deterministic. 
    Because variables in our Bayesian network take values from 1 : ri , 
    the utility variables are mapped to real values by the utilities field. 
    For example, if we have a utility variable :u1, the ith utility associated with that variable is utilities[:u1][i]. 
    """
    bn::BayesianNetwork
    chance_vars::Vector{Variable}
    decision_vars::Vector{Variable}
    utility_vars::Vector{Variable}
    utilities::Dict{Symbol,Vector{Float64}}
end
function solve(problem::SimpleProblem, evidence, M)
    """
    The solve function takes as input the problem, evidence, and an inference method. 
    It returns the best assignment to the decision variables and its associated expected utility.    
    """
    query = [var.name for var in problem.utility_vars]
    U(a) = sum(problem.utilities[uname][a[uname]] for uname in query)
    best = (a = nothing, u = -Inf)
    for assignment in assignments(problem.decision_vars)
        evidence = merge(evidence, assignment)
        φ = infer(M, problem.bn, query, evidence)
        u = sum(p * U(a) for (a, p) in φ.table)
        if u > best.u
            best = (a = assignment, u = u)
        end
    end
    return best
end
