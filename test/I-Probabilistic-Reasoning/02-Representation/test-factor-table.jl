using DecisionMakingAlgorithms
using Test

@testset "Factor Table" begin
    @testset "create Variable" begin
        X = Variable(:x, 2)
        Y = Variable(:y, 2)
        Z = Variable(:z, 2)
        @test X == Variable(:x, 2)
    end

    @testset "create Factor" begin
        X = Variable(:x, 2)
        Y = Variable(:y, 2)
        Z = Variable(:z, 2)
        ϕ = Factor(
            [X, Y, Z],
            FactorTable(
                Dict(pairs((x = 1, y = 1, z = 1))) => 0.08,
                Dict(pairs((x = 1, y = 1, z = 2))) => 0.31,
                Dict(pairs((x = 1, y = 2, z = 1))) => 0.09,
                Dict(pairs((x = 1, y = 2, z = 2))) => 0.37,
                Dict(pairs((x = 2, y = 1, z = 1))) => 0.01,
                Dict(pairs((x = 2, y = 1, z = 2))) => 0.05,
                Dict(pairs((x = 2, y = 2, z = 1))) => 0.02,
                Dict(pairs((x = 2, y = 2, z = 2))) => 0.07,
            ),
        )
        @show ϕ
    end    
end

