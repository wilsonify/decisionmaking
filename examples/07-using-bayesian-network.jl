using LightGraphs
using DecisionMakingAlgorithms

println("a Bayesian network for a satellite-monitoring problem involving five binary variables.")
println("Fortunately, battery failure and solar panel failures are both rare, although solar panel failures are somewhat more likely than battery failures. ")
println("Failures in either can lead to an electrical system failure.")
println("There may be causes of electrical system failure other than battery or solar panel failure, ")
println("such as a problem with the power management unit. ")
println("An electrical system failure can result in trajectory deviation, ")
println("which can be observed from the earth by telescope, ")
println("as well as a communication loss that interrupts the transmission of telemetry and mission data down to various ground stations.")
println("Other anomalies not involving the electrical system can result in trajectory deviation and communication loss.")
println("Associated with each of the five variables are five conditional probability distributions.")

println("Because B and S do not have any parents, ")
println("we only need to specify P ( B ) and P ( S ) . ")
println("The code below creates a Bayesian network structure with example values for the elements of the associated factor tables. ")
println("The tuples in the factor tables index into the domains of the variables, ")
println("which is { 0, 1 } for all of the variables. ")
println("For example, (e=2,b=1,s=1) corresponds to ( e1 , b0 , s0 ) .")


B = Variable(:b, 2)
@show(B)
S = Variable(:s, 2)
@show(S)
E = Variable(:e, 2)
@show(E)
D = Variable(:d, 2)
@show(D)
C = Variable(:c, 2)
@show(C)

vars = [B, S, E, D, C]
@show(vars)

factors = [
    Factor([B], FactorTable(
        Dict(pairs((b = 1,))) => 0.99,
        Dict(pairs((b = 2,))) => 0.01)),
    Factor([S], FactorTable(
        Dict(pairs((s = 1,))) => 0.98,
        Dict(pairs((s = 2,))) => 0.02)),
    Factor([E, B, S], FactorTable(
        Dict(pairs((e = 1, b = 1, s = 1))) => 0.90,
        Dict(pairs((e = 1, b = 1, s = 2))) => 0.04,
        Dict(pairs((e = 1, b = 2, s = 1))) => 0.05,
        Dict(pairs((e = 1, b = 2, s = 2))) => 0.01,
        Dict(pairs((e = 2, b = 1, s = 1))) => 0.10,
        Dict(pairs((e = 2, b = 1, s = 2))) => 0.96,
        Dict(pairs((e = 2, b = 2, s = 1))) => 0.95,
        Dict(pairs((e = 2, b = 2, s = 2))) => 0.99)),
    Factor([D, E], FactorTable(
        Dict(pairs((d = 1, e = 1))) => 0.96,
        Dict(pairs((d = 1, e = 2))) => 0.03,
        Dict(pairs((d = 2, e = 1))) => 0.04,
        Dict(pairs((d = 2, e = 2))) => 0.97)),
    Factor([C, E], FactorTable(
        Dict(pairs((c = 1, e = 1))) => 0.98,
        Dict(pairs((c = 1, e = 2))) => 0.01,
        Dict(pairs((c = 2, e = 1))) => 0.02,
        Dict(pairs((c = 2, e = 2))) => 0.99))
]

@show(factors)

graph = SimpleDiGraph(5)
add_edge!(graph, 1, 3);
add_edge!(graph, 2, 3);
add_edge!(graph, 3, 4);
add_edge!(graph, 3, 5);
@show(graph)

bn = BayesianNetwork(vars, factors, graph)
@show(bn)

display(bn)
