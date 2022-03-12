Packages
A package is a collection of Julia code and possibly other external libraries that
can be imported to provide additional functionality. This section briefly reviews
a few of the key packages that we build upon. To add a registered package like
Distributions.jl , we can run:
using Pkg
Pkg.add("Distributions")

To update packages, we use:
Pkg.update()
To use a package, we use the keyword using :
using Distributions

G.4.1 LightGraphs.jl
We use the LightGraphs.jl package (version 1.3) to represent graphs and per-
form operations on them:
julia> using LightGraphs
julia> G = SimpleDiGraph(3); # create a directed graph with three nodes
julia> add_edge!(G, 1, 3);
# add edge from node 1 to 3
julia> add_edge!(G, 1, 2);
# add edge from node 1 to 2
julia> rem_edge!(G, 1, 3);
# remove edge from node 1 to 3
julia> add_edge!(G, 2, 3);
# add edge from node 2 to 3
julia> typeof(G)
LightGraphs.SimpleGraphs.SimpleDiGraph{Int64}
julia> nv(G)
# number of nodes (also called vertices)
3
julia> outneighbors(G, 1)
# list of outgoing neighbors for node 1
1-element Vector{Int64}:
2
julia> inneighbors(G, 1)
# list of incoming neighbors for node 1
Int64[]
G.4.2 Distributions.jl
We use the Distributions.jl package (version 0.24) to represent, fit, and sample
from probability distributions:
julia> using Distributions
julia> μ, σ = 5.0, 2.5;
julia> dist = Normal(μ, σ)
# create a normal distribution
Distributions.Normal{Float64}(μ=5.0, σ=2.5)
julia> rand(dist)
# sample from the distribution
5.117978726180487
julia> data = rand(dist, 3)
# generate three samples
3-element Vector{Float64}:
5.570124983332562
7.203738396019297
8.048744493431254
julia> data = rand(dist, 1000);
# generate many samples

julia> Distributions.fit(Normal, data) # fit a normal distribution to the samples
Distributions.Normal{Float64}(μ=4.950462223235077, σ=2.489854041557098)
julia> μ = [1.0, 2.0];
julia> Σ = [1.0 0.5; 0.5 2.0];
julia> dist = MvNormal(μ, Σ)
# create a multivariate normal distribution
FullNormal(
dim: 2
μ: [1.0, 2.0]
Σ: [1.0 0.5; 0.5 2.0]
)
julia> rand(dist, 3)
# generate three samples
2×3 Matrix{Float64}:
2.04439 2.2624
1.29307
5.00066 3.01087 3.38062
julia> dist = Dirichlet(ones(3))
# create a Dirichlet distribution Dir(1,1,1)
Distributions.Dirichlet{Float64, Vector{Float64}, Float64}(alpha=[1.0, 1.0, 1.0])
julia> rand(dist)
# sample from the distribution
3-element Vector{Float64}:
0.10367763155036062
0.3042377800786831
0.5920845883709565
G.4.3 JuMP.jl
We use the JuMP.jl package (version 0.21) to specify optimization problems that
we can then solve using a variety of different solvers, such as those included in
GLPK.jl and Ipopt.jl :
julia> using JuMP
julia> using GLPK
julia> model = Model(GLPK.Optimizer)
# create model and use GLPK as solver
A JuMP Model
Feasibility problem with:
Variables: 0
Model mode: AUTOMATIC
CachingOptimizer state: EMPTY_OPTIMIZER
Solver name: GLPK
julia> @variable(model, x[1:3])
# define variables x[1], x[2], and x[3]
3-element Vector{JuMP.VariableRef}:
x[1]
x[2]
x[3]
julia> @objective(model, Max, sum(x) - x[2]) # define maximization objective
x[1] + 0 x[2] + x[3]


julia> @constraint(model, x[1] + x[2] ≤ 3)
x[1] + x[2] ≤ 3.0
julia> @constraint(model, x[2] + x[3] ≤ 2)
x[2] + x[3] ≤ 2.0
julia> @constraint(model, x[2] ≥ 0)
x[2] ≥ 0.0
julia> optimize!(model)
julia> value.(x)
3-element Vector{Float64}:
3.0
0.0
2.0
# add constraint
# add another constraint
# add another constraint
# solve
# extract optimal values for elements in x