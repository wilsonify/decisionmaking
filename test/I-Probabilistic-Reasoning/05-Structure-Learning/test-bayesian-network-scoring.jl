using Test
using DecisionMakingAlgorithms
using LightGraphs

A = Variable(:A, 2)
B = Variable(:B, 2)
C = Variable(:C, 2)

G = SimpleDiGraph(3); # create a directed graph with three nodes
add_edge!(G, 1, 2)
add_edge!(G, 3, 2)
vars = [A, B, C]
D = [
    1 2 2 1
    1 2 2 1
    2 2 2 2
]

@testset "bayesian scoring tests" begin
    @testset "bayesian_score" begin
        @test bayesian_score(vars, G, D) == -7.207859871432474
    end
end
