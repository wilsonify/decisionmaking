
struct ExactInference
    """
    placeholder for various infer methods 
    """
end

function infer(M::ExactInference, bn::BayesianNetwork, query, evidence)
    """
    A naive exact inference algorithm for a discrete Bayesian network bn ,
    which takes as input a set of query variable names query ,
    and evidence associating values with observed variables.
    
    The algorithm computes a joint distribution over the query variables in the form of a factor.
    We introduce the ExactInference type to allow for infer to be called with different inference methods.
    
    """
    ϕ = prod(bn.factors)
    ϕ = conditioning(ϕ, evidence)
    for name in setdiff(variablenames(ϕ), query)
        ϕ = marginalize(ϕ, name)
    end
    return normalize_factor!(ϕ)
end
