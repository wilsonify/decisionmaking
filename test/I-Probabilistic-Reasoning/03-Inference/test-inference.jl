using Test
path_to_top = dirname(dirname(dirname(@__DIR__)))
include("$path_to_top/src/02-Representation/representation-library.jl")
include("$path_to_top/src/02-Representation/bayesian-networks.jl")

a = Dict(pairs((b = 1, s = 1, e = 1, d = 2, c = 1)))

@testset "BayesianNetwork" begin
    @testset "probability of an assignment" begin
        @test (probability(bn, Assignment(a)) == 0.034228655999999996)

    end
end