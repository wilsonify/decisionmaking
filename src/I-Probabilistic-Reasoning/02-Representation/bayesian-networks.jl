"""
a Bayesian network for a satellite-monitoring problem involving five binary variables.
Fortunately, battery failure and solar panel failures are both rare, although solar panel failures are somewhat more likely than battery failures. 
Failures in either can lead to an electrical system failure.
There may be causes of electrical system failure other than battery or solar panel failure, such as a problem with the power management unit. 
An electrical system failure can result in trajectory deviation, which can be observed from the earth by telescope, as well as a communication loss that interrupts the transmission of telemetry and mission data down to various ground stations.
Other anomalies not involving the electrical system can result in trajectory deviation and communication loss.
Associated with each of the five variables are five conditional probability distributions.
Because B and S do not have any parents, we only need to
    specify P ( B ) and P ( S ) . The code below creates a Bayesian network structure
    with example values for the elements of the associated factor tables. The
    tuples in the factor tables index into the domains of the variables, which is
    { 0, 1 } for all of the variables. For example, (e=2,b=1,s=1) corresponds to
    ( e 1 , b 0 , s 0 ) .
"""


struct BayesianNetwork
    vars::Vector{Variable}
    factors::Vector{Factor}
    graph::SimpleDiGraph{Int64}
end

B = Variable(:b, 2); S = Variable(:s, 2)
E = Variable(:e, 2)
D = Variable(:d, 2); C = Variable(:c, 2)
vars = [B, S, E, D, C]
factors = [
Factor([B], FactorTable((b=1,) => 0.99, (b=2,) => 0.01)),
Factor([S], FactorTable((s=1,) => 0.98, (s=2,) => 0.02)),
Factor([E,B,S], FactorTable(
(e=1,b=1,s=1) => 0.90, (e=1,b=1,s=2) => 0.04,
(e=1,b=2,s=1) => 0.05, (e=1,b=2,s=2) => 0.01,
(e=2,b=1,s=1) => 0.10, (e=2,b=1,s=2) => 0.96,
(e=2,b=2,s=1) => 0.95, (e=2,b=2,s=2) => 0.99)),
Factor([D, E], FactorTable(
(d=1,e=1) => 0.96, (d=1,e=2) => 0.03,
(d=2,e=1) => 0.04, (d=2,e=2) => 0.97)),
Factor([C, E], FactorTable(
(c=1,e=1) => 0.98, (c=1,e=2) => 0.01,
(c=2,e=1) => 0.02, (c=2,e=2) => 0.99))
]
graph = SimpleDiGraph(5)
add_edge!(graph, 1, 3); add_edge!(graph, 2, 3)
add_edge!(graph, 3, 4); add_edge!(graph, 3, 5)
bn = BayesianNetwork(vars, factors, graph)

function probability(bn::BayesianNetwork, assignment)
    subassignment(ϕ) = select(assignment, variablenames(ϕ))
    probability(ϕ) = get(ϕ.table, subassignment(ϕ), 0.0)
    return prod(probability(ϕ) for ϕ in bn.factors)
end