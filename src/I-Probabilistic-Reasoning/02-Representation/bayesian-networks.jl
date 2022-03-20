using LightGraphs
path_to_here=@__DIR__
include("$path_to_here/variable.jl")
include("$path_to_here/factor.jl")
struct BayesianNetwork
    vars::Vector{Variable}
    factors::Vector{Factor}
    graph::SimpleDiGraph{Int64}
end


function probability(bn::BayesianNetwork, assignment)
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


