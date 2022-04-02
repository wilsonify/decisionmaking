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
        @time @safetestset "15-Exploration-and-Exploitation Tests" begin
            """
            function simulate(problem::BanditProblem, model, π, h)
            function update!(model::BanditModel, a, r)
            function simulate(problem::MDP, model, π, h, s)
            function bonus(π::UCB1Exploration, B, a)
            """
        end
        @time @safetestset "16-Model-Based-Methods Tests" begin
            """
            function lookahead(model::BayesianMDP, s, a)
            function update!(model::BayesianMDP, s, a, r, s′)
            function update!(planner::PrioritizedUpdate, model, s)
            function update!(planner::PrioritizedUpdate, model, s, a, r, s′)
            function lookahead(model::RmaxMDP, s, a)
            function backup(model::RmaxMDP, U, s)
            function update!(model::RmaxMDP, s, a, r, s′)
            function MDP(model::RmaxMDP)
            function lookahead(model::MaximumLikelihoodMDP, s, a)
            function backup(model::MaximumLikelihoodMDP, U, s)
            function update!(model::MaximumLikelihoodMDP, s, a, r, s′)
            function MDP(model::MaximumLikelihoodMDP)
            function Base.rand(model::BayesianMDP)
            function update!(planner::PosteriorSamplingUpdate, model, s, a, r, s′)
            function update!(planner::FullUpdate, model, s, a, r, s′)
            function update!(planner::RandomizedUpdate, model, s, a, r, s′)
            """
        end
        @time @safetestset "17-Model-Free-Methods Tests" begin
            """
            function lookahead(model::GradientQLearning, s, a)
            function update!(model::GradientQLearning, s, a, r, s′)
            function update!(model::SarsaLambda, s, a, r, s′)
            function lookahead(model::ReplayGradientQLearning, s, a)
            function update!(model::ReplayGradientQLearning, s, a, r, s′)
            function update!(model::IncrementalEstimate, x)
            function update!(model::QLearning, s, a, r, s′)
            function update!(model::Sarsa, s, a, r, s′)
            """
        end
        @time @safetestset "18-Imitation-Learning Tests" begin
            """
            function optimize(M::BehavioralCloning, D, θ)
            function optimize(M::DatasetAggregation, D, θ)
            function feature_expectations(M::InverseReinforcementLearning, π)
            function discounted_state_visitations(M::MaximumEntropyIRL, θ)
            function optimize(M::MaximumEntropyIRL, D, ϕ, θ)
            function calc_weighting(M::InverseReinforcementLearning, μs)
            function calc_policy_mixture(M::InverseReinforcementLearning, μs)
            function optimize(M::InverseReinforcementLearning, θ)
            function optimize(M::SMILe, θ)
            """
        end
    end
    @time @safetestset "IV-State-Uncertainty Tests" begin
        @time @safetestset "19-Beliefs Tests" begin
            """
            function update(b::AdaptiveInjectionParticleFilter, problem, a, o)
            function update(b::KalmanFilter, problem, a, o)
            function update(b::ExtendedKalmanFilter, problem, a, o)
            function update(b::Vector{Float64}, problem, a, o)
            function update(b::ParticleFilter, problem, a, o)
            function update(b::RejectionParticleFilter, problem, a, o)
            function update(b::InjectionParticleFilter, problem, a, o)
            function unscented_transform(μ, Σ, f, λ, ws)
            function update(b::UnscentedKalmanFilter, problem, a, o)
            """
        end
        @time @safetestset "20-Exact-Belief-State-Planning Tests" begin
            """
            function utility(π::AlphaVectorPolicy, b)
            function (π::AlphaVectorPolicy)(b)
            function lookahead(problem::POMDP, U, s, a)
            function evaluate_plan(problem::POMDP, π::ConditionalPlan, s)
            function alphavector(problem::POMDP, π::ConditionalPlan)
            function ConditionalPlan(problem::POMDP, a, plans)
            function combine_lookahead(problem::POMDP, s, a, Γo)
            function combine_alphavector(problem::POMDP, a, Γo)
            function expand(plans, Γ, problem)
            function lookahead(problem::POMDP, U, b::Vector, a)
            function greedy(problem::POMDP, U, b::Vector)
            function utility(π::LookaheadAlphaVectorPolicy, b)
            function greedy(π, b)
            function find_maximal_belief(α, Γ)
            function find_dominating(Γ)
            function prune(plans, Γ)
            function value_iteration(problem::POMDP, k_max)
            function solve(M::ValueIteration, problem::POMDP)
            """
        end
        @time @safetestset "21-Offline-Belief-State-Planning Tests" begin
            """
            function update(problem::POMDP, M::FastInformedBound, Γ)
            function solve(M::FastInformedBound, problem::POMDP)
            function baws_lowerbound(problem::POMDP)
            function alphavector_iteration(problem::POMDP, M, Γ)
            function update(problem::POMDP, M::QMDP, Γ)
            function solve(M::QMDP, problem::POMDP)
            function randstep(problem::POMDP, b, a)
            function random_belief_expansion(problem, B)
            function exploratory_belief_expansion(problem, B)
            function blind_lowerbound(problem, k_max)
            function backup(problem::POMDP, Γ, b)
            function update(problem::POMDP, M::PointBasedValueIteration, Γ)
            function solve(M::PointBasedValueIteration, problem)
            function update(problem::POMDP, M::RandomizedPointBasedValueIteration, Γ)
            function solve(M::RandomizedPointBasedValueIteration, problem)
            function explore!(M::SawtoothHeuristicSearch, problem, πhi, πlo, b, d = 0)
            function solve(M::SawtoothHeuristicSearch, problem::POMDP)
            function basis(problem)
            function utility(π::SawtoothPolicy, b)
            function solve(M::SawtoothIteration, problem::POMDP)
            function TriangulatedPolicy(problem::POMDP, m)
            function utility(π::TriangulatedPolicy, b)
            function solve(M::TriangulatedIteration, problem)
            """
        end
        @time @safetestset "22-Online-Belief-State-Planning Tests" begin
            """
            function determinized_sparse_tree_search(problem, b, d, Φ, U)
            function determized_approximate_belief(b, problem, m)
            function (π::DeterminizedSparseTreeSearch)(b)
            function successor(problem, Φ, ϕ, a)
            function possible_observations(problem, Φ, b, a)
            function update(b, Φ, problem, a, o)
            function heuristic_search(π::GapHeuristicSearch, b, d)
            function (π::GapHeuristicSearch)(b)
            function explore(π::HistoryMonteCarloTreeSearch, h)
            function simulate(π::HistoryMonteCarloTreeSearch, s, h, d)
            function (π::HistoryMonteCarloTreeSearch)(b, h = [])
            """
        end
        @time @safetestset "23-Controller-Abstractions Tests" begin
            """
            function (π::ControllerPolicy)(x)
            function update(π::ControllerPolicy, x, a, o)
            function utility(π::ControllerPolicy, U, x, s)
            function iterative_policy_evaluation(π::ControllerPolicy, k_max)
            function solve(M::ControllerGradient, problem::POMDP)
            function improve!(π::ControllerPolicy, M::ControllerGradient, problem::POMDP)
            function project_to_simplex(y)
            function gradient(π::ControllerPolicy, M::ControllerGradient, problem::POMDP)
            function tensorform(problem::POMDP)
            function solve(M::NonlinearProgramming, problem::POMDP)
            function solve(M::ControllerPolicyIteration, problem::POMDP)
            function policy_improvement!(π::ControllerPolicy, U, prevX)
            function prune!(π::ControllerPolicy, U, prevX)
            """
        end
    end
    @time @safetestset "V-Multiagent-Systems Tests" begin
        @time @safetestset "24-Multiagent-Reasoning Tests" begin
            """
            function solve(M::CorrelatedEquilibrium, problem::SimpleGame)
            function simulate(problem::SimpleGame, π, k_max)
            function FictitiousPlay(problem::SimpleGame, i)
            function update!(πi::FictitiousPlay, a)
            function GradientAscent(problem::SimpleGame, i)
            function update!(πi::GradientAscent, a)
            function HierarchicalSoftmax(problem::SimpleGame, λ, k)
            function solve(M::HierarchicalSoftmax, problem)
            function IteratedBestResponse(problem::SimpleGame, k_max)
            function solve(M::IteratedBestResponse, problem)
            function (π::JointCorrelatedPolicy)()
            function tensorform(problem::SimpleGame)
            function solve(M::NashEquilibrium, problem::SimpleGame)
            function SimpleGamePolicy(p::Base.Generator)
            function SimpleGamePolicy(p::Dict)
            function (πi::SimpleGamePolicy)()
            function utility(problem::SimpleGame, π, i)
            function best_response(problem::SimpleGame, π, i)
            function softmax_response(problem::SimpleGame, π, i, λ)
            """
        end
        @time @safetestset "25-Sequential-Problems Tests" begin
            """
            function tensorform(problem::MG)
            function solve!(M::NashEquilibrium, problem::MG)
            function randstep(problem::MG, s, a)
            function simulate(problem::MG, π, k_max, b)
            function MGFictitiousPlay(problem::MG, i)
            function (πi::MGFictitiousPlay)(s)
            function update!(πi::MGFictitiousPlay, s, a, s′)
            function MGGradientAscent(problem::MG, i)
            function (πi::MGGradientAscent)(s)
            function update!(πi::MGGradientAscent, s, a, s′)
            function policy_evaluation(problem::MG, π, i)
            function NashQLearning(problem::MG, i)
            function (πi::NashQLearning)(s)
            function update!(πi::NashQLearning, s, a, s′)
            function best_response(problem::MG, π, i)
            function softmax_response(problem::MG, π, i, λ)
            """
        end
        @time @safetestset "26-State-Uncertainty Tests" begin
            """
            function solve(M::POMGDynamicProgramming, problem::POMG)
            function prune_dominated!(Π, problem::POMG)
            function is_dominated(problem::POMG, Π, i, πi)
            function create_conditional_plans(problem, d)
            function expand_conditional_plans(problem, Π)
            function solve(M::POMGNashEquilibrium, problem::POMG)
            function lookahead(problem::POMG, U, s, a)
            function evaluate_plan(problem::POMG, π, s)
            function utility(problem::POMG, b, π)
            """
        end
        @time @safetestset "27-Collaborative-Agents Tests" begin
            """
            function solve(M::DecPOMDPDynamicProgramming, problem::DecPOMDP)
            function solve(M::DecPOMDPHeuristicSearch, problem::DecPOMDP)
            function explore(M::DecPOMDPHeuristicSearch, problem::DecPOMDP, t)
            function solve(M::DecPOMDPIteratedBestResponse, problem::DecPOMDP)
            function tensorform(problem::DecPOMDP)
            function solve(M::DecPOMDPNonlinearProgramming, problem::DecPOMDP)
            """
        end
    end
end
