using DecisionMakingAlgorithms
using Test
using SafeTestsets


@testset "DecisionMakingAlgorithms.jl" begin
    @time @safetestset "I-Probabilistic-Reasoning Tests" begin
        @time @safetestset "01-Introduction Tests" begin
            path_to_here = @__DIR__
            include(
                "$path_to_here/I-Probabilistic-Reasoning/01-Introduction/test-control-flow.jl",
            )
            include(
                "$path_to_here/I-Probabilistic-Reasoning/01-Introduction/test-functions.jl",
            )
            include(
                "$path_to_here/I-Probabilistic-Reasoning/01-Introduction/test-packages.jl",
            )
            include("$path_to_here/I-Probabilistic-Reasoning/01-Introduction/test-types.jl")
        end

        @time @safetestset "02-Representation Tests" begin
            path_to_here = @__DIR__
            
            include("$path_to_here/I-Probabilistic-Reasoning/02-Representation/test-assignments.jl")
            include("$path_to_here/I-Probabilistic-Reasoning/02-Representation/test-bayesian-networks.jl")
            include("$path_to_here/I-Probabilistic-Reasoning/02-Representation/test-blanket.jl")
            include("$path_to_here/I-Probabilistic-Reasoning/02-Representation/test-conditioning.jl")
            include("$path_to_here/I-Probabilistic-Reasoning/02-Representation/test-condition.jl")
            include("$path_to_here/I-Probabilistic-Reasoning/02-Representation/test-factor-table.jl")
            include("$path_to_here/I-Probabilistic-Reasoning/02-Representation/test-gibbs_sample.jl")
            include("$path_to_here/I-Probabilistic-Reasoning/02-Representation/test-in_scope.jl")
            include("$path_to_here/I-Probabilistic-Reasoning/02-Representation/test-marginalize.jl")
            include("$path_to_here/I-Probabilistic-Reasoning/02-Representation/test-normalize_factor.jl")
            include("$path_to_here/I-Probabilistic-Reasoning/02-Representation/test-probability.jl")
            include("$path_to_here/I-Probabilistic-Reasoning/02-Representation/test-update_gibbs_sample.jl")
            include("$path_to_here/I-Probabilistic-Reasoning/02-Representation/test-variablenames.jl")
            
        end

        @time @safetestset "03-Inference Tests" begin
            path_to_here = @__DIR__
            include("$path_to_here/I-Probabilistic-Reasoning/03-Inference/test-gaussia-model-inference.jl")
            include("$path_to_here/I-Probabilistic-Reasoning/03-Inference/test-inference.jl")
            include("$path_to_here/I-Probabilistic-Reasoning/03-Inference/test-infer-direct-sampling.jl")
            include("$path_to_here/I-Probabilistic-Reasoning/03-Inference/test-infer-likelihood-weighted-sampling.jl")
            include("$path_to_here/I-Probabilistic-Reasoning/03-Inference/test-infer-gibbs-sampling.jl")
            include("$path_to_here/I-Probabilistic-Reasoning/03-Inference/test-infer-variable-elimination.jl")
            include("$path_to_here/I-Probabilistic-Reasoning/03-Inference/test-infer-exact-inference.jl")
            include("$path_to_here/I-Probabilistic-Reasoning/03-Inference/test-infer-mvnormal.jl")
            
        end

        @time @safetestset "04-Parameter-Learning" begin
            path_to_here = @__DIR__
            include("$path_to_here/I-Probabilistic-Reasoning/04-Parameter-Learning//test-statistics.jl")
            include("$path_to_here/I-Probabilistic-Reasoning/04-Parameter-Learning//test-gaussian_kernel.jl")
            include("$path_to_here/I-Probabilistic-Reasoning/04-Parameter-Learning//test-prior.jl")
            include("$path_to_here/I-Probabilistic-Reasoning/04-Parameter-Learning//packages.jl")
            include("$path_to_here/I-Probabilistic-Reasoning/04-Parameter-Learning//Nonparametric-Learning.jl")
            include("$path_to_here/I-Probabilistic-Reasoning/04-Parameter-Learning//test-kernel_density_estimate.jl")
            include("$path_to_here/I-Probabilistic-Reasoning/04-Parameter-Learning//test-sub2ind.jl")
            
        end

        @time @safetestset "05-Structure-Learning Tests" begin
            path_to_here = @__DIR__
            include("$path_to_here/I-Probabilistic-Reasoning/05-Structure-Learning//test-bayesian-network-scoring.jl")
            include("$path_to_here/I-Probabilistic-Reasoning/05-Structure-Learning//test-are_markov_equivalent.jl")
            include("$path_to_here/I-Probabilistic-Reasoning/05-Structure-Learning//test-bayesian_score_component.jl")
            include("$path_to_here/I-Probabilistic-Reasoning/05-Structure-Learning//test-rand_graph_neighbor.jl")
            include("$path_to_here/I-Probabilistic-Reasoning/05-Structure-Learning//test-bayesian_score.jl")
            include("$path_to_here/I-Probabilistic-Reasoning/05-Structure-Learning//test-fit-k2search.jl")
            include("$path_to_here/I-Probabilistic-Reasoning/05-Structure-Learning//test-fit-local-directed-graph-search.jl")
            
        end

        @time @safetestset "06-Simple-Decisions Tests" begin
            include("$path_to_here/I-Probabilistic-Reasoning/06-Simple-Decisions/test-solve.jl")
            include("$path_to_here/I-Probabilistic-Reasoning/06-Simple-Decisions/test-value-of-information.jl")            
        end

    end
    @time @safetestset "II-Sequential-Problems Tests" begin
        @time @safetestset "07-Exact-Solution-Methods Tests" begin end
        @time @safetestset "08-Approximate-Value-Functions Tests" begin end
        @time @safetestset "09-Online-Planning Tests" begin end
        @time @safetestset "10-Policy-Search Tests" begin end
        @time @safetestset "11-Policy-Gradient-Estimation Tests" begin end
        @time @safetestset "12-Policy-Gradient-Optimization Tests" begin end
        @time @safetestset "13-Actor-Critic-Methods Tests" begin end
        @time @safetestset "14-Policy-Validation Tests" begin end
    end
    @time @safetestset "III-Model-Uncertainty Tests" begin
        @time @safetestset "15-Exploration-and-Exploitation Tests" begin end
        @time @safetestset "16-Model-Based-Methods Tests" begin end
        @time @safetestset "17-Model-Free-Methods Tests" begin end
        @time @safetestset "18-Imitation-Learning Tests" begin end
    end
    @time @safetestset "IV-State-Uncertainty Tests" begin
        @time @safetestset "19-Beliefs Tests" begin end
        @time @safetestset "20-Exact-Belief-State-Planning Tests" begin end
        @time @safetestset "21-Offline-Belief-State-Planning Tests" begin end
        @time @safetestset "22-Online-Belief-State-Planning Tests" begin end
        @time @safetestset "23-Controller-Abstractions Tests" begin end
    end
    @time @safetestset "V-Multiagent-Systems Tests" begin
        @time @safetestset "24-Multiagent-Reasoning Tests" begin end
        @time @safetestset "25-Sequential-Problems Tests" begin end
        @time @safetestset "26-State-Uncertainty Tests" begin end
        @time @safetestset "27-Collaborative-Agents Tests" begin end
    end
end
