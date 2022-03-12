
function blanket(bn, a, i)
    """
    A method for obtaining P ( X i | x − i ) 
    for a Bayesian network bn given a current assignment a .
    """
    name = bn.vars[i].name
    val = a[name]
    a = delete!(copy(a), name)
    Φ = filter(ϕ -> in_scope(name, ϕ), bn.factors)
    ϕ = prod(condition(ϕ, a) for ϕ in Φ)
    return normalize!(ϕ)
end

function update_gibbs_sample!(a, bn, evidence, ordering)
    """
    Gibbs sampling implemented for a Bayesian network bn with evidence evidence and an ordering ordering.
    The method iteratively updates the assignment a for m iterations.
    to use
    to discard during burn-in
    to skip for thinning indices    
    """
    for i in ordering
        name = bn.vars[i].name
        if !haskey(evidence, name)
            b = blanket(bn, a, i)
            a[name] = rand(b)[name]
        end
    end
end

function gibbs_sample!(a, bn, evidence, ordering, m)
    for j in 1:m
        update_gibbs_sample!(a, bn, evidence, ordering)
    end
end
struct GibbsSampling
    m_samples # number of samples
    m_burnin # number of samples
    m_skip
    # number of samples
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
    return normalize!(Factor(vars, table))
end