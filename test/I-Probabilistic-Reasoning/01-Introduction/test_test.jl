using Test
path_to_top = dirname(dirname(dirname(@__DIR__)))
include("$path_to_top/src/I-Probabilistic-Reasoning/01-Introduction/foo.jl")
@testset "Disassembler tests" begin
    @testset "add numbers" begin
        @test 1 + 1 == 2

    end

    @testset "add strings" begin
        @test foo()
    end
end