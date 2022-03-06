struct SimpleProblem
    """
    simple problem
    as a decision network. A decision
    network is a Bayesian network with
    chance, decision, and utility vari    ables. Utility variables are treated
    as deterministic. Because variables
    in our Bayesian network take val    ues from 1 : ri , the utility variables
    are mapped to real values by the
    utilities field. For example, if we
    have a utility variable :u1, the ith
    utility associated with that variable
    is utilities[:u1][i]. The solve
    function takes as input the prob    lem, evidence, and an inference
    method. It returns the best assign    ment to the decision variables and
    its associated expected utility.
    """
    bn::BayesianNetwork
    chance_vars::Vector{Variable}
    decision_vars::Vector{Variable}
    utility_vars::Vector{Variable}
    utilities::Dict{Symbol,Vector{Float64}}
end
function solve(𝒫::SimpleProblem, evidence, M)
    query = [var.name for var in 𝒫.utility_vars]
    U(a) = sum(𝒫.utilities[uname][a[uname]] for uname in query)
    best = (a = nothing, u = -Inf)
    for assignment in assignments(𝒫.decision_vars)
        evidence = merge(evidence, assignment)
        φ = infer(M, 𝒫.bn, query, evidence)
        u = sum(p * U(a) for (a, p) in φ.table)
        if u > best.u
            best = (a = assignment, u = u)
        end
    end
    return best
end
