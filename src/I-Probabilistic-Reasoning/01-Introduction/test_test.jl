using Test
@testset "Disassembler tests" begin
    @testset "add numbers" begin
        @test 1+1==2

    end

    @testset "add strings" begin
        @test "A"+"B"=="AB"
    end
end