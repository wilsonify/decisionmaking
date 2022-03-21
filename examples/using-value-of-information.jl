using DecisionMakingAlgorithms

B = Variable(:b, 2)
S = Variable(:s, 2)
E = Variable(:e, 2)
D = Variable(:d, 2)
C = Variable(:c, 2)
vars = [B, S, E, D, C]
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
graph = SimpleDiGraph(5)
add_edge!(graph, 1, 3);
add_edge!(graph, 2, 3);
add_edge!(graph, 3, 4);
add_edge!(graph, 3, 5);
bn = BayesianNetwork(vars, factors, graph)


chance_vars=vars
decision_vars=vars
utility_vars=vars
utilities=Dict(pairs((c = [1], e = [1])))
problem = SimpleProblem(bn,chance_vars,decision_vars,utility_vars,utilities)
query = [var.name for var in problem.utility_vars]
evidence = assignments(problem.decision_vars)
ei=ExactInference()
value = value_of_information(problem, query, evidence, ei)
display(value)