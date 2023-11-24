using Distributions
using DecisionMakingAlgorithms

D = MvNormal([0.0,1.0],[3.0 1.0; 1.0 2.0])


using Test
@testset "infer tests" begin
    @testset "infer numbers" begin
        @test length(infer(D, [1], [2], [2.0])) == length(MvNormal([0.5], [2.5]))
    end
    
end