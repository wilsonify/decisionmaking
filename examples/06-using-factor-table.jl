using DecisionMakingAlgorithms
println("Example joint distribution involving binary variables X, Y, and Z.")
println("| X | Y | Z | P(X,Y,Z) |")
println("|---|---|---|----------|")
println("| 0 | 0 | 0 | 0.08     |")
println("| 0 | 0 | 1 | 0.31     |")
println("| 0 | 1 | 0 | 0.09     |")
println("| 0 | 1 | 1 | 0.37     |")
println("| 1 | 0 | 0 | 0.01     |")
println("| 1 | 0 | 1 | 0.05     |")
println("| 1 | 1 | 0 | 0.02     |")
println("| 1 | 1 | 1 | 0.07     |")

println("We can instantiate the table from table 2.1 using the Factor type")

X = Variable(:x, 2)
Y = Variable(:y, 2)
Z = Variable(:z, 2)
ϕ = Factor(
    [X, Y, Z],
    FactorTable(
        Dict(pairs((x = 1, y = 1, z = 1))) => 0.08,
        Dict(pairs((x = 1, y = 1, z = 2))) => 0.31,
        Dict(pairs((x = 1, y = 2, z = 1))) => 0.09,
        Dict(pairs((x = 1, y = 2, z = 2))) => 0.37,
        Dict(pairs((x = 2, y = 1, z = 1))) => 0.01,
        Dict(pairs((x = 2, y = 1, z = 2))) => 0.05,
        Dict(pairs((x = 2, y = 2, z = 1))) => 0.02,
        Dict(pairs((x = 2, y = 2, z = 2))) => 0.07,
    ),
)
@show(ϕ)

