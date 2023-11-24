using Test
using DecisionMakingAlgorithms

a = Dict(pairs((b = 1, s = 1, e = 1, d = 2, c = 1)))

@testset "BayesianNetwork" begin
    @testset "probability of an assignment" begin
        
        @test a == Dict{Symbol,Integer}((b = 1, s = 1, e = 1, d = 2, c = 1))

    end
end