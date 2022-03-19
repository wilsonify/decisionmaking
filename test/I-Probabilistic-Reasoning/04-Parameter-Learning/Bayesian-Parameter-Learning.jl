using LightGraphs
include("../02-Representation/representation-library.jl")
"""
Using the statistics function for extracting the statistics from a data set. 
Bayesian parameter learning can be used to avoid n a n values,
but we must specify a prior
"""
G = SimpleDiGraph(3)
add_edge!(G, 1, 2)
add_edge!(G, 3, 2)
vars = [Variable(:A,2), Variable(:B,2), Variable(:C,2)]
D = [1 2 2 1; 1 2 2 1; 2 2 2 2]

# The output is an array M consisting of these three count matrices, each of size q i × r i :
M = statistics(vars, G, D)

# We can compute the maximum likelihood estimate by normalizing the rows in the matrices in M :
θ = [mapslices(x->normalize(x,1), Mi, dims=2) for Mi in M]

"""



As we can see, the first and second parental instantiations of the second
variable B leads to n a n (‘‘not a number’’) estimates. 

Because there are no observations of those two parental instantiations in the data, 
the denominator equals zero, making the parameter estimate undefined.

Most of the other parameters are not nan. 
For example, the parameter θ_112 = 0.5 means that the maximum likelihood estimate of P ( a_2 ) is 0.5.
"""