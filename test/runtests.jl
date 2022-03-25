using DecisionMakingAlgorithms
using Test
using SafeTestsets


@testset "DecisionMakingAlgorithms.jl" begin
    @time @safetestset "01-Introduction Tests" begin
        path_to_here=@__DIR__
        include("$path_to_here/I-Probabilistic-Reasoning/01-Introduction/test-control-flow.jl")
        include("$path_to_here/I-Probabilistic-Reasoning/01-Introduction/test-functions.jl")
        include("$path_to_here/I-Probabilistic-Reasoning/01-Introduction/test-packages.jl")
        include("$path_to_here/I-Probabilistic-Reasoning/01-Introduction/test-types.jl")
    end
    
    @time @safetestset "02-Representation Tests" begin
        path_to_here=@__DIR__
        include("$path_to_here/I-Probabilistic-Reasoning/02-Representation/test-bayesian-networks.jl")
        
    end

    @time @safetestset "03-Inference Tests" begin
        path_to_here=@__DIR__
        include("$path_to_here/I-Probabilistic-Reasoning/03-Inference/test-inference.jl")
    end

    @time @safetestset "03-Inference Tests" begin
        path_to_here=@__DIR__
        include("$path_to_here/I-Probabilistic-Reasoning/03-Inference/test-gaussia-model-inference.jl")
    end

    @time @safetestset "05-Structure-Learning Tests" begin
        path_to_here=@__DIR__
        include("$path_to_here/I-Probabilistic-Reasoning/05-Structure-Learning/test-bayesian-network-scoring.jl")
    end

end
