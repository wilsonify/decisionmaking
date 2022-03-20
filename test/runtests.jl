using DecisionMakingAlgorithms
using Test


@testset "DecisionMakingAlgorithms.jl" begin
    @time @safetestset "01-Introduction Tests" begin
        include("I-Probabilistic-Reasoning/01-Introduction/test_test.jl")
    end
    
    @time @safetestset "02-Representation Tests" begin
        include("I-Probabilistic-Reasoning/02-Representation/test-bayesian-networks.jl")
    end

    @time @safetestset "03-Inference Tests" begin
        include("I-Probabilistic-Reasoning/03-Inference/test-inference.jl")
    end

    @time @safetestset "03-Inference Tests" begin
        include("I-Probabilistic-Reasoning/03-Inference/test-gaussia-model-inference.jl")
    end

    @time @safetestset "05-Structure-Learning Tests" begin
        include("I-Probabilistic-Reasoning/05-Structure-Learning/test-bayesian-network-scoring.jl")
    end

end
