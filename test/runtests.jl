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
        @time @safetestset "07-Exact-Solution-Methods Tests" begin 
        """

src/II-Sequential-Problems/07-Exact-Solution-Methods/Asynchronous-Value-Iteration.jl:
9: function solve(M::GaussSeidelValueIteration, problem::MDP)

src/II-Sequential-Problems/07-Exact-Solution-Methods/Linear-Program-Formulation.jl:
18: function tensorform(problem::MDP)
29: function solve(M::LinearProgramFormulation, problem::MDP)

src/II-Sequential-Problems/07-Exact-Solution-Methods/Linear-Systems-with-Quadratic-Reward.jl:
13: function solve(problem::LinearQuadraticProblem)

src/II-Sequential-Problems/07-Exact-Solution-Methods/Markov-Decision-Processes.jl:
18: function lookahead(problem::MDP, U, s, a)
30: function lookahead(problem::MDP, U::Vector, s, a)
35: function backup(problem::MDP, U, s)
43: function iterative_policy_evaluation(problem::MDP, π, k_max)
57: function policy_evaluation(problem::MDP, π)

src/II-Sequential-Problems/07-Exact-Solution-Methods/Policy-Iteration.jl:
8: function solve(M::PolicyIteration, problem::MDP)

src/II-Sequential-Problems/07-Exact-Solution-Methods/Value-Function-Policies.jl:
10: function greedy(problem::MDP, U, s)

src/II-Sequential-Problems/07-Exact-Solution-Methods/Value-Iteration.jl:
11: function solve(M::ValueIteration, problem::MDP)


        """
        end
        @time @safetestset "08-Approximate-Value-Functions Tests" begin 
        """
        src/II-Sequential-Problems/08-Approximate-Value-Functions/Kernel-Smoothing.jl:
14: function (Uθ::LocallyWeightedValueFunction)(s)
18: function fit!(Uθ::LocallyWeightedValueFunction, S, U)

src/II-Sequential-Problems/08-Approximate-Value-Functions/Linear-Regression.jl:
12: function (Uθ::LinearRegressionValueFunction)(s)
16: function fit!(Uθ::LinearRegressionValueFunction, S, U)

src/II-Sequential-Problems/08-Approximate-Value-Functions/Nearest-Neighbor.jl:
19: function (Uθ::NearestNeighborValueFunction)(s)
25: function fit!(Uθ::NearestNeighborValueFunction, S, U)

src/II-Sequential-Problems/08-Approximate-Value-Functions/Parametric Representations.jl:
16: function solve(M::ApproximateValueIteration, problem::MDP)

src/II-Sequential-Problems/08-Approximate-Value-Functions/Simplex-Interpolation.jl:
19: function (Uθ::MultilinearValueFunction)(s)
44: function fit!(Uθ::MultilinearValueFunction, S, U)
67: function (Uθ::SimplexValueFunction)(s)
85: function fit!(Uθ::SimplexValueFunction, S, U)


        """
        end
        @time @safetestset "09-Online-Planning Tests" begin 
        """
        src/II-Sequential-Problems/09-Online-Planning/Branch-and-Bound.jl:
16: function branch_and_bound(problem, s, d, Ulo, Qhi)

src/II-Sequential-Problems/09-Online-Planning/Forward-Search.jl:
19: function forward_search(problem, s, d, U)

src/II-Sequential-Problems/09-Online-Planning/Heuristic-Search.jl:
13: function simulate!(π::HeuristicSearch, U, s)
21: function (π::HeuristicSearch)(s)


src/II-Sequential-Problems/09-Online-Planning/Labeled-Heuristic-Search.jl:
23: function (π::LabeledHeuristicSearch)(s)
31: function simulate!(π::LabeledHeuristicSearch, U, solved, s)

src/II-Sequential-Problems/09-Online-Planning/Lookahead-with-Rollouts.jl:
16: function rollout(problem, s, π, d)
25: function (π::RolloutLookahead)(s)

src/II-Sequential-Problems/09-Online-Planning/Monte-Carlo-Tree-Search.jl:
16: function (π::MonteCarloTreeSearch)(s)
23: function simulate!(π::MonteCarloTreeSearch, s, d = π.d)
57: function explore(π::MonteCarloTreeSearch, s)

src/II-Sequential-Problems/09-Online-Planning/Open-Loop-Planning.jl:
37: function label!(π::LabeledHeuristicSearch, U, solved, s)

src/II-Sequential-Problems/09-Online-Planning/Sparse-Sampling.jl:
15: function sparse_sampling(problem, s, d, m, U)


        """
        end
        @time @safetestset "10-Policy-Search Tests" begin 
        """
        src/II-Sequential-Problems/10-Policy-Search/Approximate-Policy-Evaluation.jl:
15: function (U::MonteCarloPolicyEvaluation)(π)
36: function optimize(M::HookeJeevesPolicySearch, π, U)
78: function optimize(M::GeneticPolicySearch, π, U)

src/II-Sequential-Problems/10-Policy-Search/Cross-Entropy-Method.jl:
16: function optimize_dist(M::CrossEntropyPolicySearch, π, U)
27: function optimize(M, π, U)

src/II-Sequential-Problems/10-Policy-Search/Isotropic-Evolutionary-Strategies.jl:
25: function evolution_strategy_weights(m)
32: function optimize_dist(M::EvolutionStrategies, π, U)
59: function optimize_dist(M::IsotropicEvolutionStrategies, π, U)


        """
        
        end
        @time @safetestset "11-Policy-Gradient-Estimation Tests" begin 
        """
        src/II-Sequential-Problems/11-Policy-Gradient-Estimation/Baseline-Subtraction.jl:
14: function gradient(M::BaselineSubtractionGradient, π, θ)

src/II-Sequential-Problems/11-Policy-Gradient-Estimation/Finite-Difference.jl:
1: function simulate(problem::MDP, s, π, d)
35: function gradient(M::FiniteDifferenceGradient, π, θ)

src/II-Sequential-Problems/11-Policy-Gradient-Estimation/Likelihood-Ratio.jl:
14:     function gradient(M::LikelihoodRatioGradient, π, θ)

src/II-Sequential-Problems/11-Policy-Gradient-Estimation/Regression-Gradient.jl:
19: function gradient(M::RegressionGradient, π, θ)

src/II-Sequential-Problems/11-Policy-Gradient-Estimation/Reward-to-Go.jl:
15: function gradient(M::RewardToGoGradient, π, θ)


        """
        end
        @time @safetestset "12-Policy-Gradient-Optimization Tests" begin 
        """
        src/II-Sequential-Problems/12-Policy-Gradient-Optimization/Clamped Surrogate Objective.jl:
24: function clamped_gradient(M::ClampedSurrogateUpdate, θ, θ′, τs)
38: function update(M::ClampedSurrogateUpdate, θ)

src/II-Sequential-Problems/12-Policy-Gradient-Optimization/Gradient Ascent Update.jl:
12: function update(M::PolicyGradientUpdate, θ)

src/II-Sequential-Problems/12-Policy-Gradient-Optimization/Natural Gradient Update.jl:
22: function natural_update(θ, ∇f, F, ϵ, τs)
29: function update(M::NaturalPolicyUpdate, θ)

src/II-Sequential-Problems/12-Policy-Gradient-Optimization/Restricted Gradient Update.jl:
19: function update(M::RestrictedPolicyUpdate, θ)

src/II-Sequential-Problems/12-Policy-Gradient-Optimization/Trust Region Update.jl:
31: function surrogate_objective(M::TrustRegionUpdate, θ, θ′, τs)
38: function surrogate_constraint(M::TrustRegionUpdate, θ, θ′, τs)
44: function linesearch(M::TrustRegionUpdate, f, g, θ, θ′)
51: function update(M::TrustRegionUpdate, θ)


        """
        end
        @time @safetestset "13-Actor-Critic-Methods Tests" begin 
        """
        src/II-Sequential-Problems/13-Actor-Critic-Methods/Actor-Critic.jl:
30:     function gradient(M::ActorCritic, π, θ, ϕ)

src/II-Sequential-Problems/13-Actor-Critic-Methods/Deterministic Policy Gradient.jl:
36:     function gradient(M::DeterministicPolicyGradient, π, θ, ϕ)

src/II-Sequential-Problems/13-Actor-Critic-Methods/Generalized Advantage Estimation.jl:
34:     function gradient(M::GeneralizedAdvantageEstimation, π, θ, ϕ)


        """
        end

        @time @safetestset "14-Policy-Validation Tests" begin 
        """
        src/II-Sequential-Problems/14-Policy-Validation/Adversarial Analysis.jl:
11: function adversarial(problem::MDP, π, λ)

        """
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
