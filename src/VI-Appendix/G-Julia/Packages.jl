#Packages
"""
A package is a collection of Julia code and possibly other external libraries that
can be imported to provide additional functionality. This section briefly reviews
a few of the key packages that we build upon. To add a registered package like
Distributions.jl , we can run:
using Pkg
"""
Pkg.add("Distributions")
Pkg.update()#To update packages


# To use a package, we use the keyword using
using Distributions

# LightGraphs.jl
"""
We use the LightGraphs.jl package (version 1.3) to represent graphs and per-
form operations on them:
"""
using LightGraphs
G = SimpleDiGraph(3); # create a directed graph with three nodes
add_edge!(G, 1, 3); # add edge from node 1 to 3
add_edge!(G, 1, 2); # add edge from node 1 to 2
rem_edge!(G, 1, 3); # remove edge from node 1 to 3
add_edge!(G, 2, 3); # add edge from node 2 to 3
@assert(typeof(G) == LightGraphs.SimpleGraphs.SimpleDiGraph{Int64})
@assert(nv(G) == 3)# number of nodes (also called vertices)
@assert(outneighbors(G, 1) == [2]) # list of outgoing neighbors for node 1
@assert(inneighbors(G, 1) == []) # list of incoming neighbors for node 1

# Distributions.jl
"""
We use the Distributions.jl package (version 0.24) to represent, fit, and sample
from probability distributions:
"""
using Distributions
μ, σ = 5.0, 2.5;
dist = Normal(μ, σ) # create a normal distribution
@assert(dist == Distributions.Normal{Float64}(μ = 5.0, σ = 2.5))

rand(dist) # sample from the distribution e.g. 5.117978726180487
data = rand(dist, 3) # generate three samples #e.g. [5.570124983332562,7.203738396019297,8.048744493431254]
data = rand(dist, 1000); # generate many samples

Distributions.fit(Normal, data) # fit a normal distribution to the samples
# Distributions.Normal{Float64}(μ=4.950462223235077, σ=2.489854041557098)
μ = [1.0, 2.0];
Σ = [1.0 0.5; 0.5 2.0];
dist = MvNormal(μ, Σ) # create a multivariate normal distribution
@assert(dist == FullNormal(dim:2, μ:[1.0, 2.0], Σ:[1.0 0.5; 0.5 2.0]))

rand(dist, 3) # generate three samples
# 2×3 Matrix{Float64}: [[2.04439, 2.2624,1.29307],[5.00066, 3.01087, 3.38062]]

dist = Dirichlet(ones(3)) # create a Dirichlet distribution Dir(1,1,1)
Distributions.Dirichlet{Float64,Vector{Float64},Float64}(alpha = [1.0, 1.0, 1.0])
rand(dist) # sample from the distribution
# 3-element Vector{Float64}: [0.10367763155036062,0.3042377800786831,0.5920845883709565]

# JuMP.jl
"""
We use the JuMP.jl package (version 0.21) to specify optimization problems that
we can then solve using a variety of different solvers, such as those included in
GLPK.jl and Ipopt.jl :
"""
using JuMP
using GLPK

model = Model(GLPK.Optimizer) # create model and use GLPK as solver
# A JuMP Model Feasibility problem with:
#Variables: 0
#Model mode: AUTOMATIC
#CachingOptimizer state: EMPTY_OPTIMIZER
#Solver name: GLPK

@variable(model, x[1:3]) # define variables x[1], x[2], and x[3]
#3-element Vector{JuMP.VariableRef}:
#x[1]
#x[2]
#x[3]

@objective(model, Max, sum(x) - x[2]) # define maximization objective
# x[1] + 0 x[2] + x[3]


@constraint(model, x[1] + x[2] ≤ 3)# add constraint
# x[1] + x[2] ≤ 3.0

@constraint(model, x[2] + x[3] ≤ 2) # add another constraint
# x[2] + x[3] ≤ 2.0

@constraint(model, x[2] ≥ 0) # add another constraint
# x[2] ≥ 0.0

optimize!(model) # solve
value.(x) # extract optimal values for elements in x
# 3-element Vector{Float64}: [3.0,0.0,2.0]
