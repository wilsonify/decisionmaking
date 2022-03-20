using LightGraphs

struct BayesianNetwork
    vars::Vector{Variable}
    factors::Vector{Factor}
    graph::SimpleDiGraph{Int64}
end


function probability(bn::BayesianNetwork, assignment::Assignment)
    """
    A function for evaluating the probability of an assignment given a Bayesian network bn . 
    For example, if bn is as defined in example 2.5, then 
    a = (b=1,s=1,e=1,d=2,c=1)
    probability(bn, Assignment(a))
    returns 0.034228655999999996 .
    """

    subassignment(ϕ) = select(assignment, variablenames(ϕ))
    probability(ϕ) = get(ϕ.table, subassignment(ϕ), 0.0)
    return prod(probability(ϕ) for ϕ in bn.factors)
end


function Base.rand(bn::BayesianNetwork)
    """
    A method for sampling an assignment from a Bayesian network bn .
    """
    a = Assignment()
    for i in topological_sort(bn.graph)
        name, ϕ = bn.vars[i].name, bn.factors[i]
        a[name] = rand(conditioning(ϕ, a))[name]
    end
    return a
end

function blanket(bn::BayesianNetwork, a, i)
    """
    A method for obtaining P ( X_i | x - i ) 
    for a Bayesian network bn given a current assignment a .
    """
    name = bn.vars[i].name
    val = a[name]
    a = delete!(copy(a), name)
    Φ = filter(ϕ -> in_scope(name, ϕ), bn.factors)
    ϕ = prod(conditioning(ϕ, a) for ϕ in Φ)
    return normalize_factor!(ϕ)
end

function update_gibbs_sample!(a::Assignment, bn::BayesianNetwork, evidence::NamedTuple, ordering::Vector{Variable})
    """
    Gibbs sampling implemented for a Bayesian network bn with evidence in the form of a NamedTuple
    and an ordering in the form of an array of Variable(s).
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
