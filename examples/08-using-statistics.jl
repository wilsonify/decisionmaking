using LightGraphs
using LinearAlgebra
using DecisionMakingAlgorithms
println("Using the statistics function for extracting the statistics from a data set.") 
println("Bayesian parameter learning can be used to avoid nan values, but we must specify a prior")

G = SimpleDiGraph(3)
add_edge!(G, 1, 2)
add_edge!(G, 3, 2)

@show(G)

vars = [Variable(:A,2), Variable(:B,2), Variable(:C,2)]
@show(vars)

D = [1 2 2 1; 1 2 2 1; 2 2 2 2]
@show(D)

println("The output is an array M consisting of these three count matrices, each of size q_i × r_i :")
M = statistics(vars, G, D)
@show(M)

println("We can compute the maximum likelihood estimate by normalizing the rows in the matrices in M :")
θ = [mapslices(x->normalize(x,1), Mi, dims=2) for Mi in M]
@show(θ)

println("As we can see, the first and second parental instantiations of the second")
println("variable B leads to nan (not a number) estimates. ")
println("Because there are no observations of those two parental instantiations in the data,")
println("the denominator equals zero, making the parameter estimate undefined.")
println("Most of the other parameters are not nan.")
println("For example, the parameter θ_112 = 0.5 means that the maximum likelihood estimate of P ( a_2 ) is 0.5.")