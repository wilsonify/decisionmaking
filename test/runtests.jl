using DecisionMakingAlgorithms
using Test
using SafeTestsets


@testset "DecisionMakingAlgorithms.jl" begin
    @time @safetestset "I-Probabilistic-Reasoning Tests" begin
        @time @safetestset "01-Introduction Tests" begin
            path_to_here = @__DIR__
            path_to_there = "$path_to_here/I-Probabilistic-Reasoning/01-Introduction"
            include("$path_to_there/test-control-flow.jl")
            include("$path_to_there/test-functions.jl")
            include("$path_to_there/test-packages.jl")
            include("$path_to_there/test-types.jl")
        end

        @time @safetestset "02-Representation Tests" begin
            path_to_here = @__DIR__
            path_to_there = "$path_to_here/I-Probabilistic-Reasoning/02-Representation"

            include("$path_to_there/test-assignments.jl")
            include("$path_to_there/test-bayesian-networks.jl")
            include("$path_to_there/test-blanket.jl")
            include("$path_to_there/test-conditioning.jl")
            include("$path_to_there/test-condition.jl")
            include("$path_to_there/test-factor-table.jl")
            include("$path_to_there/test-gibbs_sample.jl")
            include("$path_to_there/test-in_scope.jl")
            include("$path_to_there/test-marginalize.jl")
            include("$path_to_there/test-normalize_factor.jl")
            include("$path_to_there/test-probability.jl")
            include("$path_to_there/test-update_gibbs_sample.jl")
            include("$path_to_there/test-variablenames.jl")

        end

        @time @safetestset "03-Inference Tests" begin
            path_to_here = @__DIR__
            path_to_there = "$path_to_here/I-Probabilistic-Reasoning/03-Inference"
            include("$path_to_there/test-gaussia-model-inference.jl")
            include("$path_to_there/test-inference.jl")
            include("$path_to_there/test-infer-direct-sampling.jl")
            include("$path_to_there/test-infer-likelihood-weighted-sampling.jl")
            include("$path_to_there/test-infer-gibbs-sampling.jl")
            include("$path_to_there/test-infer-variable-elimination.jl")
            include("$path_to_there/test-infer-exact-inference.jl")
            include("$path_to_there/test-infer-mvnormal.jl")

        end

        @time @safetestset "04-Parameter-Learning" begin
            path_to_here = @__DIR__
            path_to_there = "$path_to_here/I-Probabilistic-Reasoning/04-Parameter-Learning"
            include("$path_to_there/test-statistics.jl")
            include("$path_to_there/test-gaussian_kernel.jl")
            include("$path_to_there/test-prior.jl")
            include("$path_to_there/test-kernel_density_estimate.jl")
            include("$path_to_there/test-sub2ind.jl")

        end

        @time @safetestset "05-Structure-Learning Tests" begin
            path_to_here = @__DIR__
            path_to_there = "$path_to_here/I-Probabilistic-Reasoning/05-Structure-Learning"
            include("$path_to_there/test-bayesian-network-scoring.jl")
            include("$path_to_there/test-are_markov_equivalent.jl")
            include("$path_to_there/test-bayesian_score_component.jl")
            include("$path_to_there/test-rand_graph_neighbor.jl")
            include("$path_to_there/test-bayesian_score.jl")
            include("$path_to_there/test-fit-k2search.jl")
            include("$path_to_there/test-fit-local-directed-graph-search.jl")

        end

        @time @safetestset "06-Simple-Decisions Tests" begin
            path_to_here = @__DIR__
            path_to_there = "$path_to_here/I-Probabilistic-Reasoning/06-Simple-Decisions"
            include("$path_to_there/test-solve.jl")
            include("$path_to_there/test-value-of-information.jl")
        end

    end
    @time @safetestset "II-Sequential-Problems Tests" begin
        @time @safetestset "07-Exact-Solution-Methods Tests" begin
            path_to_here = @__DIR__
            path_to_there = "$path_to_here/II-Sequential-Problems/07-Exact-Solution-Methods"
            include("$path_to_there/test-iterative_policy_evaluation.jl")
            include("$path_to_there/test-solve-gauss-seidel-value-iteration.jl")
            include("$path_to_there/test-policy_evaluation.jl")
            include("$path_to_there/test-backup.jl")
            include("$path_to_there/test-solve-linear-program-formulation.jl")
            include("$path_to_there/test-solve-policy-iteration.jl")
            include("$path_to_there/test-tensorform.jl")
            include("$path_to_there/test-solve-value-iteration.jl")
            include("$path_to_there/test-solve-linear-quadratic-problem.jl")
            include("$path_to_there/test-greedy.jl")
            include("$path_to_there/test-iterative_policy_evaluation.jl")
            include("$path_to_there/test-lookahead.jl")
        end
        @time @safetestset "08-Approximate-Value-Functions Tests" begin
            path_to_here = @__DIR__
            path_to_there = "$path_to_here/II-Sequential-Problems/08-Approximate-Value-Functions"
            include("$path_to_there/test-fit-MultilinearValueFunction.jl")
            include("$path_to_there/test-fit-NearestNeighborValueFunction.jl")
            include("$path_to_there/test-solve-ApproximateValueIteration.jl")
            include("$path_to_there/test-fit-LocallyWeightedValueFunction.jl")
            include("$path_to_there/test-fit-LinearRegressionValueFunction.jl")
            include("$path_to_there/test-fit-SimplexValueFunction.jl")
        end
        @time @safetestset "09-Online-Planning Tests" begin
            path_to_here = @__DIR__
            path_to_there = "$path_to_here/II-Sequential-Problems/09-Online-Planning"

            include("$path_to_there/test-simulate-LabeledHeuristicSearch.jl")
            include("$path_to_there/test-sparse_sampling.jl")
            include("$path_to_there/test-forward_search.jl")
            include("$path_to_there/test-branch-and-bound.jl")
            include("$path_to_there/test-label-LabeledHeuristicSearch.jl")
            include("$path_to_there/test-simulate-MonteCarloTreeSearch.jl")
            include("$path_to_there/test-simulate-HeuristicSearch.jl")
            include("$path_to_there/test-rollout.jl")
            include("$path_to_there/test-explore-MonteCarloTreeSearch.jl")
        end
        @time @safetestset "10-Policy-Search Tests" begin
            path_to_here = @__DIR__
            path_to_there = "$path_to_here/II-Sequential-Problems/10-Policy-Search"
            include("$path_to_there/test-optimize_dist-EvolutionStrategies.jl")
            include("$path_to_there/test-optimize_dist-IsotropicEvolutionStrategies.jl")
            include("$path_to_there/test-optimize-HookeJeevesPolicySearch.jl")
            include("$path_to_there/test-optimize-M.jl")
            include("$path_to_there/test-optimize-GeneticPolicySearch.jl")
            include("$path_to_there/test-evolution_strategy_weights.jl")
            include("$path_to_there/test-optimize_dist-CrossEntropyPolicySearch.jl")

        end
        @time @safetestset "11-Policy-Gradient-Estimation Tests" begin
            path_to_here = @__DIR__
            path_to_there = "$path_to_here/II-Sequential-Problems/11-Policy-Gradient-Estimation"
            include("$path_to_there/test-gradient-BaselineSubtractionGradient.jl")
            include("$path_to_there/test-regression-gradient.jl")
            include("$path_to_there/test-gradient-FiniteDifferenceGradient.jl")
            include("$path_to_there/test-gradient-RegressionGradient.jl")
            include("$path_to_there/test-gradient-RewardToGoGradient.jl")
            include("$path_to_there/test-simulate-MDP.jl")
            include("$path_to_there/test-gradient-LikelihoodRatioGradient.jl")
        end
        @time @safetestset "12-Policy-Gradient-Optimization Tests" begin
            path_to_here = @__DIR__
            path_to_there = "$path_to_here/II-Sequential-Problems/12-Policy-Gradient-Optimization"
            include("$path_to_there/test-update-NaturalPolicyUpdate.jl")
            include("$path_to_there/test-surrogate_constraint-TrustRegionUpdate.jl")
            include("$path_to_there/test-surrogate_objective-TrustRegionUpdate.jl")
            include("$path_to_there/test-update-ClampedSurrogateUpdate.jl")
            include("$path_to_there/test-natural_update.jl")
            include("$path_to_there/test-clamped_gradient-ClampedSurrogateUpdate.jl")
            include("$path_to_there/test-update-TrustRegionUpdate.jl")
            include("$path_to_there/test-update-RestrictedPolicyUpdate.jl")
            include("$path_to_there/test-update-PolicyGradientUpdate.jl")
            include("$path_to_there/test-linesearch-TrustRegionUpdate.jl")
        end
        @time @safetestset "13-Actor-Critic-Methods Tests" begin
            path_to_here = @__DIR__
            path_to_there = "$path_to_here/II-Sequential-Problems/13-Actor-Critic-Methods"
include("$path_to_there/test-gradient-DeterministicPolicyGradient.jl")
include("$path_to_there/test-gradient-ActorCritic.jl")
include("$path_to_there/test-gradient-GeneralizedAdvantageEstimation.jl")

        end

        @time @safetestset "14-Policy-Validation Tests" begin
            path_to_here = @__DIR__
            path_to_there = "$path_to_here/II-Sequential-Problems/14-Policy-Validation"
            include("$path_to_there/test-adversarial-MDP.jl")
        end
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
