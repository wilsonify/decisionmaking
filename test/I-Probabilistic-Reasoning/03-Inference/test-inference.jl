using Test
paths_to_here=dirname(@__DIR__)
include("$paths_to_here/02-Representation/representation-library.jl")
include("$paths_to_here/02-Representation/bayesian-networks.jl")

a = Dict(pairs((b = 1, s = 1, e = 1, d = 2, c = 1)))

@testset "BayesianNetwork" begin
    @testset "probability of an assignment" begin
        @test (probability(bn, Assignment(a)) == 0.034228655999999996)

    end
end