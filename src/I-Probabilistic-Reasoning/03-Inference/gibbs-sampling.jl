module Gibbs
struct GibbsSampling
    m_samples # number of samples
    m_burnin # number of samples
    m_skip # number of samples
    ordering # array of variable
end

function infer(M::GibbsSampling, bn, query, evidence)
    table = FactorTable()
    a = merge(rand(bn), evidence)
    gibbs_sample!(a, bn, evidence, M.ordering, M.m_burnin)
    for i in 1:(M.m_samples)
        gibbs_sample!(a, bn, evidence, M.ordering, M.m_skip)
        b = select(a, query)
        table[b] = get(table, b, 0) + 1
    end
    vars = filter(v -> v.name ∈ query, bn.vars)
    return normalize_factor!(Factor(vars, table))
end
end