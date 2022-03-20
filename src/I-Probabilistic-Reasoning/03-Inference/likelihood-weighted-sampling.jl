path_to_parent=dirname(@__DIR__)
include("$path_to_parent/02-Representation/representation-library.jl")
include("$path_to_parent/04-Parameter-Learning/Maximum-Likelihood-Estimates-for-Bayesian-Networks.jl")

struct LikelihoodWeightedSampling
    """
    The likelihood weighted sampling inference method,
    which takes a Bayesian network bn ,
    a list of query variables query ,
    and evidence evidence .

    The method draws m samples from the Bayesian network 
    but sets values from evidence when possible, 
    keeping track of the conditional probability when doing so.
    These probabilities are used to weight the samples such that 
    the final inference estimate is accurate. 
    A factor over the query variables is returned.
    """
    m::Any # number of samples
end
function infer(M::LikelihoodWeightedSampling, bn, query, evidence)
    table = FactorTable()
    ordering = topological_sort(bn.graph)
    for i = 1:(M.m)
        a, w = Assignment(), 1.0
        for j in ordering
            name, ϕ = bn.vars[j].name, bn.factors[j]
            if haskey(evidence, name)
                a[name] = evidence[name]
                w *= ϕ.table[select(a, variablenames(ϕ))]
            else
                a[name] = rand(condition(ϕ, a))[name]
            end
        end
        b = select(a, query)
        table[b] = get(table, b, 0) + w
    end
    vars = filter(v -> v.name ∈ query, bn.vars)
    return normalize!(Factor(vars, table))
end


