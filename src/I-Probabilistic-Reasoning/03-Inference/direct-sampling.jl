
"""
A. B. Kahn, “Topological Sorting of Large Networks,” 
Communications of the ACM, vol. 5, no. 11, pp. 558-562, 1962. 
An implementation of topological sorting is provided by the LightGraphs.jl package.
"""
struct DirectSampling
    """
    The direct sampling inference method, 
    which takes a Bayesian network bn , 
    a list of query variables query , 
    and evidence evidence .

    The method m samples from the Bayesian network and retains those samples
    that are consistent with the evidence. 
    A factor over the query variables is returned. 
    This method can fail if no samples that satisfy the evidence are found.
    """
    m::Int # number of samples
end

function infer(M::DirectSampling, bn, query, evidence)
    table = FactorTable()
    for i = 1:(M.m)
        a = rand(bn)
        if all(a[k] == v for (k, v) in pairs(evidence))
            b = select(a, query)
            table[b] = get(table, b, 0) + 1
        end
    end
    vars = filter(v -> v.name ∈ query, bn.vars)
    return normalize_factor!(Factor(vars, table))
end
