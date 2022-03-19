using Test
include("../03-Inference/inference-library.jl")
@testset "bayesian scoreing tests" begin
    @testset "bayesian_score_component" begin
        M = statistics(vars, G, D)
        α = prior(vars, G)
        @test bayesian_score_component(M, α)==2

    end

    @testset "bayesian_score" begin
        @test bayesian_score(vars, G, D)==2
    end
end
