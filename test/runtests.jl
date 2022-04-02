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
        src/III-Model-Uncertainty/15-Exploration-and-Exploitation/Bandit Problems.jl:
  15: function simulate(problem::BanditProblem, model, π, h)

src/III-Model-Uncertainty/15-Exploration-and-Exploitation/Bayesian Model Estimation.jl:
  8:     function update!(model::BanditModel, a, r)


src/III-Model-Uncertainty/15-Exploration-and-Exploitation/Exploration with Multiple States.jl:
  14: function simulate(problem::MDP, model, π, h, s)

src/III-Model-Uncertainty/15-Exploration-and-Exploitation/Optimal Exploration Strategies.jl:
  11:     function bonus(π::UCB1Exploration, B, a)


        """
        end
        @time @safetestset "16-Model-Based-Methods Tests" begin 
        """
        src/III-Model-Uncertainty/16-Model-Based-Methods/Bayes-adaptive MDPs.jl:
  20: function lookahead(model::BayesianMDP, s, a)
  32: function update!(model::BayesianMDP, s, a, r, s′)

src/III-Model-Uncertainty/16-Model-Based-Methods/Exploration.jl:
   12: function update!(planner::PrioritizedUpdate, model, s)
   31: function update!(planner::PrioritizedUpdate, model, s, a, r, s′)
   89: function lookahead(model::RmaxMDP, s, a)
  100: function backup(model::RmaxMDP, U, s)
  103: function update!(model::RmaxMDP, s, a, r, s′)
  109: function MDP(model::RmaxMDP)

src/III-Model-Uncertainty/16-Model-Based-Methods/Maximum Likelihood Models.jl:
  20: function lookahead(model::MaximumLikelihoodMDP, s, a)
  32: function backup(model::MaximumLikelihoodMDP, U, s)
  35: function update!(model::MaximumLikelihoodMDP, s, a, r, s′)
  42: function MDP(model::MaximumLikelihoodMDP)

src/III-Model-Uncertainty/16-Model-Based-Methods/Posterior Sampling.jl:
  14: function Base.rand(model::BayesianMDP)
  24: function update!(planner::PosteriorSamplingUpdate, model, s, a, r, s′)

src/III-Model-Uncertainty/16-Model-Based-Methods/Update Schemes.jl:
   7: function update!(planner::FullUpdate, model, s, a, r, s′)
  22:     function update!(planner::RandomizedUpdate, model, s, a, r, s′)


        """
        end
        @time @safetestset "17-Model-Free-Methods Tests" begin 
        """
        src/III-Model-Uncertainty/17-Model-Free-Methods/Action Value Function Approximation.jl:
  18: function lookahead(model::GradientQLearning, s, a)
  22: function update!(model::GradientQLearning, s, a, r, s′)

src/III-Model-Uncertainty/17-Model-Free-Methods/Eligibility Traces.jl:
  22: function update!(model::SarsaLambda, s, a, r, s′)

src/III-Model-Uncertainty/17-Model-Free-Methods/Experience Replay.jl:
  25: function lookahead(model::ReplayGradientQLearning, s, a)
  28: function update!(model::ReplayGradientQLearning, s, a, r, s′)

src/III-Model-Uncertainty/17-Model-Free-Methods/Incremental Estimation of the Mean.jl:
  18: function update!(model::IncrementalEstimate, x)

src/III-Model-Uncertainty/17-Model-Free-Methods/Q-Learning.jl:
  19: function update!(model::QLearning, s, a, r, s′)

src/III-Model-Uncertainty/17-Model-Free-Methods/Sarsa.jl:
  20: function update!(model::Sarsa, s, a, r, s′)


        """
        end
        @time @safetestset "18-Imitation-Learning Tests" begin 
        """
        src/III-Model-Uncertainty/18-Imitation-Learning/Behavioral Cloning.jl:
  16:     function optimize(M::BehavioralCloning, D, θ)

src/III-Model-Uncertainty/18-Imitation-Learning/Dataset Aggregation.jl:
  30: function optimize(M::DatasetAggregation, D, θ)

src/III-Model-Uncertainty/18-Imitation-Learning/Inverse Reinforcement Learning.jl:
  21: function feature_expectations(M::InverseReinforcementLearning, π)

src/III-Model-Uncertainty/18-Imitation-Learning/Maximum Entropy Inverse Reinforcement Learning.jl:
  24: function discounted_state_visitations(M::MaximumEntropyIRL, θ)
  43: function optimize(M::MaximumEntropyIRL, D, ϕ, θ)

src/III-Model-Uncertainty/18-Imitation-Learning/Maximum Margin Inverse Reinforcement Learning.jl:
  18: function calc_weighting(M::InverseReinforcementLearning, μs)
  32: function calc_policy_mixture(M::InverseReinforcementLearning, μs)
  47: function optimize(M::InverseReinforcementLearning, θ)

src/III-Model-Uncertainty/18-Imitation-Learning/Stochastic Mixing Iterative Learning.jl:
  21: function optimize(M::SMILe, θ)

        """
        end
    end
    @time @safetestset "IV-State-Uncertainty Tests" begin
        @time @safetestset "19-Beliefs Tests" begin 
        """
        src/IV-State-Uncertainty/19-Beliefs/Adaptive Injection Particle Filter.jl:
  22: function update(b::AdaptiveInjectionParticleFilter, problem, a, o)

src/IV-State-Uncertainty/19-Beliefs/Discrete State Filter.jl:
  15: function update(b::KalmanFilter, problem, a, o)

src/IV-State-Uncertainty/19-Beliefs/Extended Kalman Filter.jl:
  18: function update(b::ExtendedKalmanFilter, problem, a, o)

src/IV-State-Uncertainty/19-Beliefs/Linear Gaussian Filter.jl:
  9: function update(b::Vector{Float64}, problem, a, o)

src/IV-State-Uncertainty/19-Beliefs/Particle Filter.jl:
  10: function update(b::ParticleFilter, problem, a, o)
  27: function update(b::RejectionParticleFilter, problem, a, o)

src/IV-State-Uncertainty/19-Beliefs/Particle Injection.jl:
  13: function update(b::InjectionParticleFilter, problem, a, o)

src/IV-State-Uncertainty/19-Beliefs/Unscented Kalman Filter.jl:
  21: function unscented_transform(μ, Σ, f, λ, ws)
  35: function update(b::UnscentedKalmanFilter, problem, a, o)


        """
        end
        @time @safetestset "20-Exact-Belief-State-Planning Tests" begin 
        """
        src/IV-State-Uncertainty/20-Exact-Belief-State-Planning/Alpha Vectors.jl:
  15: function utility(π::AlphaVectorPolicy, b)
  18: function (π::AlphaVectorPolicy)(b)

src/IV-State-Uncertainty/20-Exact-Belief-State-Planning/Conditional Plans.jl:
  27: function lookahead(problem::POMDP, U, s, a)
  32: function evaluate_plan(problem::POMDP, π::ConditionalPlan, s)
  40: function alphavector(problem::POMDP, π::ConditionalPlan)

src/IV-State-Uncertainty/20-Exact-Belief-State-Planning/Linear Policies.jl:
  10: function ConditionalPlan(problem::POMDP, a, plans)
  14: function combine_lookahead(problem::POMDP, s, a, Γo)
  21: function combine_alphavector(problem::POMDP, a, Γo)
  24: function expand(plans, Γ, problem)

src/IV-State-Uncertainty/20-Exact-Belief-State-Planning/Pruning.jl:
   7: function lookahead(problem::POMDP, U, b::Vector, a)
  15: function greedy(problem::POMDP, U, b::Vector)
  23: function utility(π::LookaheadAlphaVectorPolicy, b)
  26: function greedy(π, b)
  42: function find_maximal_belief(α, Γ)
  66: function find_dominating(Γ)
  83: function prune(plans, Γ)

src/IV-State-Uncertainty/20-Exact-Belief-State-Planning/Value Iteration.jl:
   7: function value_iteration(problem::POMDP, k_max)
  19: function solve(M::ValueIteration, problem::POMDP)


        """
    end
        @time @safetestset "21-Offline-Belief-State-Planning Tests" begin 
        """
        src/IV-State-Uncertainty/21-Offline-Belief-State-Planning/Fast Informed Bound.jl:
  11: function update(problem::POMDP, M::FastInformedBound, Γ)
  27: function solve(M::FastInformedBound, problem::POMDP)

src/IV-State-Uncertainty/21-Offline-Belief-State-Planning/Fast Lower Bounds.jl:
  5: function baws_lowerbound(problem::POMDP)

src/IV-State-Uncertainty/21-Offline-Belief-State-Planning/Fully Observable Value Approximation.jl:
  11: function alphavector_iteration(problem::POMDP, M, Γ)
  27: function update(problem::POMDP, M::QMDP, Γ)
  39: function solve(M::QMDP, problem::POMDP)

src/IV-State-Uncertainty/21-Offline-Belief-State-Planning/Point Selection.jl:
   8: function randstep(problem::POMDP, b, a)
  23: function random_belief_expansion(problem, B)
  41: function exploratory_belief_expansion(problem, B)

src/IV-State-Uncertainty/21-Offline-Belief-State-Planning/Point-Based Value Iteration.jl:
   6: function blind_lowerbound(problem, k_max)
  26: function backup(problem::POMDP, Γ, b)
  58: function update(problem::POMDP, M::PointBasedValueIteration, Γ)
  62: function solve(M::PointBasedValueIteration, problem)

src/IV-State-Uncertainty/21-Offline-Belief-State-Planning/Randomized Point-Based Value Iteration.jl:
  17: function update(problem::POMDP, M::RandomizedPointBasedValueIteration, Γ)
  33: function solve(M::RandomizedPointBasedValueIteration, problem)

src/IV-State-Uncertainty/21-Offline-Belief-State-Planning/Sawtooth Heuristic Search.jl:
  21: function explore!(M::SawtoothHeuristicSearch, problem, πhi, πlo, b, d = 0)
  37: function solve(M::SawtoothHeuristicSearch, problem::POMDP)

src/IV-State-Uncertainty/21-Offline-Belief-State-Planning/Sawtooth Upper Bound.jl:
   6: function basis(problem)
  11: function utility(π::SawtoothPolicy, b)
  65: function solve(M::SawtoothIteration, problem::POMDP)

src/IV-State-Uncertainty/21-Offline-Belief-State-Planning/Triangulated Value Functions.jl:
  21: function TriangulatedPolicy(problem::POMDP, m)
  27: function utility(π::TriangulatedPolicy, b)
  46: function solve(M::TriangulatedIteration, problem)


        """
        end
        @time @safetestset "22-Online-Belief-State-Planning Tests" begin 
        """
        src/IV-State-Uncertainty/22-Online-Belief-State-Planning/Determinized Sparse Tree Search.jl:
  17: function determinized_sparse_tree_search(problem, b, d, Φ, U)
  39: function determized_approximate_belief(b, problem, m)
  47: function (π::DeterminizedSparseTreeSearch)(b)

src/IV-State-Uncertainty/22-Online-Belief-State-Planning/DeterminizedParticle.jl:
  17: function successor(problem, Φ, ϕ, a)
  29: function possible_observations(problem, Φ, b, a)
  37: function update(b, Φ, problem, a, o)

src/IV-State-Uncertainty/22-Online-Belief-State-Planning/Gap Heuristic Search.jl:
  26: function heuristic_search(π::GapHeuristicSearch, b, d)
  48: function (π::GapHeuristicSearch)(b)

src/IV-State-Uncertainty/22-Online-Belief-State-Planning/Monte Carlo Tree Search.jl:
  18: function explore(π::HistoryMonteCarloTreeSearch, h)
  23: function simulate(π::HistoryMonteCarloTreeSearch, s, h, d)
  43: function (π::HistoryMonteCarloTreeSearch)(b, h = [])


        """
        end
        @time @safetestset "23-Controller-Abstractions Tests" begin 
        """
        src/IV-State-Uncertainty/23-Controller-Abstractions/Controllers.jl:
  17: function (π::ControllerPolicy)(x)
  22: function update(π::ControllerPolicy, x, a, o)
  38: function utility(π::ControllerPolicy, U, x, s)
  47: function iterative_policy_evaluation(π::ControllerPolicy, k_max)

src/IV-State-Uncertainty/23-Controller-Abstractions/Gradient Ascent.jl:
  18: function solve(M::ControllerGradient, problem::POMDP)
  30: function improve!(π::ControllerPolicy, M::ControllerGradient, problem::POMDP)
  54: function project_to_simplex(y)
  68: function gradient(π::ControllerPolicy, M::ControllerGradient, problem::POMDP)

src/IV-State-Uncertainty/23-Controller-Abstractions/Nonlinear Programming.jl:
  13: function tensorform(problem::POMDP)
  24: function solve(M::NonlinearProgramming, problem::POMDP)

src/IV-State-Uncertainty/23-Controller-Abstractions/Policy Iteration.jl:
   7: function solve(M::ControllerPolicyIteration, problem::POMDP)
  30: function policy_improvement!(π::ControllerPolicy, U, prevX)
  73: function prune!(π::ControllerPolicy, U, prevX)

        """
        end
    end
    @time @safetestset "V-Multiagent-Systems Tests" begin
        @time @safetestset "24-Multiagent-Reasoning Tests" begin 
        """
        src/V-Multiagent-Systems/24-Multiagent-Reasoning/Correlated Equilibrium.jl:
  4: function solve(M::CorrelatedEquilibrium, problem::SimpleGame)

src/V-Multiagent-Systems/24-Multiagent-Reasoning/Fictitious Play.jl:
   6: function simulate(problem::SimpleGame, π, k_max)
  34: function FictitiousPlay(problem::SimpleGame, i)
  40: function update!(πi::FictitiousPlay, a)

src/V-Multiagent-Systems/24-Multiagent-Reasoning/Gradient Ascent.jl:
  15: function GradientAscent(problem::SimpleGame, i)
  21: function update!(πi::GradientAscent, a)

src/V-Multiagent-Systems/24-Multiagent-Reasoning/Hierarchical Softmax.jl:
  15: function HierarchicalSoftmax(problem::SimpleGame, λ, k)
  19: function solve(M::HierarchicalSoftmax, problem)

src/V-Multiagent-Systems/24-Multiagent-Reasoning/Iterated Best Response.jl:
  21: function IteratedBestResponse(problem::SimpleGame, k_max)
  25: function solve(M::IteratedBestResponse, problem)

src/V-Multiagent-Systems/24-Multiagent-Reasoning/JointCorrelatedPolicy.jl:
  13: function (π::JointCorrelatedPolicy)()

src/V-Multiagent-Systems/24-Multiagent-Reasoning/Nash Equilibrium.jl:
   6: function tensorform(problem::SimpleGame)
  15: function solve(M::NashEquilibrium, problem::SimpleGame)

src/V-Multiagent-Systems/24-Multiagent-Reasoning/Response Models.jl:
  22:     function SimpleGamePolicy(p::Base.Generator)
  25:     function SimpleGamePolicy(p::Dict)
  33: function (πi::SimpleGamePolicy)()
  40: function utility(problem::SimpleGame, π, i)
  52: function best_response(problem::SimpleGame, π, i)

src/V-Multiagent-Systems/24-Multiagent-Reasoning/Simple Games.jl:
  23: function softmax_response(problem::SimpleGame, π, i, λ)


        """
        end
        @time @safetestset "25-Sequential-Problems Tests" begin 
        """
        src/V-Multiagent-Systems/25-Sequential-Problems/Fictitious Play.jl:
    6: function tensorform(problem::MG)
   16: function solve!(M::NashEquilibrium, problem::MG)
   57: function randstep(problem::MG, s, a)
   62: function simulate(problem::MG, π, k_max, b)
   89: function MGFictitiousPlay(problem::MG, i)
   97: function (πi::MGFictitiousPlay)(s)
  109: function update!(πi::MGFictitiousPlay, s, a, s′)

src/V-Multiagent-Systems/25-Sequential-Problems/Gradient Ascent.jl:
  18: function MGGradientAscent(problem::MG, i)
  25: function (πi::MGGradientAscent)(s)
  31: function update!(πi::MGGradientAscent, s, a, s′)

src/V-Multiagent-Systems/25-Sequential-Problems/Markov Games.jl:
  36: function policy_evaluation(problem::MG, π, i)

src/V-Multiagent-Systems/25-Sequential-Problems/Nash Q-Learning.jl:
  25: function NashQLearning(problem::MG, i)
  31: function (πi::NashQLearning)(s)
  43: function update!(πi::NashQLearning, s, a, s′)

src/V-Multiagent-Systems/25-Sequential-Problems/Response Models.jl:
   8: function best_response(problem::MG, π, i)
  20: function softmax_response(problem::MG, π, i, λ)


        """
        end
        @time @safetestset "26-State-Uncertainty Tests" begin 
        """
        src/V-Multiagent-Systems/26-State-Uncertainty/Dynamic Programming.jl:
  17: function solve(M::POMGDynamicProgramming, problem::POMG)
  29: function prune_dominated!(Π, problem::POMG)
  44: function is_dominated(problem::POMG, Π, i, πi)

src/V-Multiagent-Systems/26-State-Uncertainty/Nash Equilibrium.jl:
  17: function create_conditional_plans(problem, d)
  26: function expand_conditional_plans(problem, Π)
  33: function solve(M::POMGNashEquilibrium, problem::POMG)

src/V-Multiagent-Systems/26-State-Uncertainty/Policy Evaluation.jl:
  13: function lookahead(problem::POMG, U, s, a)
  18: function evaluate_plan(problem::POMG, π, s)
  23: function utility(problem::POMG, b, π)


        """
        end
        @time @safetestset "27-Collaborative-Agents Tests" begin
        """
        src/V-Multiagent-Systems/27-Collaborative-Agents/Dynamic Programming.jl:
  14: function solve(M::DecPOMDPDynamicProgramming, problem::DecPOMDP)

src/V-Multiagent-Systems/27-Collaborative-Agents/Heuristic Search.jl:
  18: function solve(M::DecPOMDPHeuristicSearch, problem::DecPOMDP)
  39: function explore(M::DecPOMDPHeuristicSearch, problem::DecPOMDP, t)

src/V-Multiagent-Systems/27-Collaborative-Agents/Iterated Best Response.jl:
  16: function solve(M::DecPOMDPIteratedBestResponse, problem::DecPOMDP)

src/V-Multiagent-Systems/27-Collaborative-Agents/Nonlinear Programming.jl:
  11: function tensorform(problem::DecPOMDP)
  23: function solve(M::DecPOMDPNonlinearProgramming, problem::DecPOMDP)

        """
        end
    end
end
