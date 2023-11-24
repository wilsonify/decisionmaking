# using DecisionMakingAlgorithms
using Test

@time @testset "01-Introduction Tests" begin
    path_to_there = "$(@__DIR__)/I-Probabilistic-Reasoning/01-Introduction"
    include("$path_to_there/test_helloWorld.jl")
    include("$path_to_there/test-control-flow.jl")
    include("$path_to_there/test-functions.jl")
    #include("$path_to_there/test-packages.jl")
    #include("$path_to_there/test-types.jl")
end

#         @time @safetestset "02-Representation Tests" begin
#             path_to_here = @__DIR__
#             path_to_there = "$path_to_here/I-Probabilistic-Reasoning/02-Representation"
#
#             include("$path_to_there/test-assignments.jl")
#             include("$path_to_there/test-bayesian-networks.jl")
#             include("$path_to_there/test-blanket.jl")
#             include("$path_to_there/test-conditioning.jl")
#             include("$path_to_there/test-condition.jl")
#             include("$path_to_there/test-factor-table.jl")
#             include("$path_to_there/test-gibbs_sample.jl")
#             include("$path_to_there/test-in_scope.jl")
#             include("$path_to_there/test-marginalize.jl")
#             include("$path_to_there/test-normalize_factor.jl")
#             include("$path_to_there/test-probability.jl")
#             include("$path_to_there/test-update_gibbs_sample.jl")
#             include("$path_to_there/test-variablenames.jl")
#
#         end
#
#         @time @safetestset "03-Inference Tests" begin
#             path_to_here = @__DIR__
#             path_to_there = "$path_to_here/I-Probabilistic-Reasoning/03-Inference"
#             include("$path_to_there/test-gaussia-model-inference.jl")
#             include("$path_to_there/test-inference.jl")
#             include("$path_to_there/test-infer-direct-sampling.jl")
#             include("$path_to_there/test-infer-likelihood-weighted-sampling.jl")
#             include("$path_to_there/test-infer-gibbs-sampling.jl")
#             include("$path_to_there/test-infer-variable-elimination.jl")
#             include("$path_to_there/test-infer-exact-inference.jl")
#             include("$path_to_there/test-infer-mvnormal.jl")
#
#         end
#
#         @time @safetestset "04-Parameter-Learning" begin
#             path_to_here = @__DIR__
#             path_to_there = "$path_to_here/I-Probabilistic-Reasoning/04-Parameter-Learning"
#             include("$path_to_there/test-statistics.jl")
#             include("$path_to_there/test-gaussian_kernel.jl")
#             include("$path_to_there/test-prior.jl")
#             include("$path_to_there/test-kernel_density_estimate.jl")
#             include("$path_to_there/test-sub2ind.jl")
#
#         end
#
#         @time @safetestset "05-Structure-Learning Tests" begin
#             path_to_here = @__DIR__
#             path_to_there = "$path_to_here/I-Probabilistic-Reasoning/05-Structure-Learning"
#             include("$path_to_there/test-bayesian-network-scoring.jl")
#             include("$path_to_there/test-are_markov_equivalent.jl")
#             include("$path_to_there/test-bayesian_score_component.jl")
#             include("$path_to_there/test-rand_graph_neighbor.jl")
#             include("$path_to_there/test-bayesian_score.jl")
#             include("$path_to_there/test-fit-k2search.jl")
#             include("$path_to_there/test-fit-local-directed-graph-search.jl")
#
#         end
#
#         @time @safetestset "06-Simple-Decisions Tests" begin
#             path_to_here = @__DIR__
#             path_to_there = "$path_to_here/I-Probabilistic-Reasoning/06-Simple-Decisions"
#             include("$path_to_there/test-solve.jl")
#             include("$path_to_there/test-value-of-information.jl")
#         end
#
#     end
#     @time @safetestset "II-Sequential-Problems Tests" begin
#         @time @safetestset "07-Exact-Solution-Methods Tests" begin
#             path_to_here = @__DIR__
#             path_to_there = "$path_to_here/II-Sequential-Problems/07-Exact-Solution-Methods"
#             include("$path_to_there/test-iterative_policy_evaluation.jl")
#             include("$path_to_there/test-solve-gauss-seidel-value-iteration.jl")
#             include("$path_to_there/test-policy_evaluation.jl")
#             include("$path_to_there/test-backup.jl")
#             include("$path_to_there/test-solve-linear-program-formulation.jl")
#             include("$path_to_there/test-solve-policy-iteration.jl")
#             include("$path_to_there/test-tensorform.jl")
#             include("$path_to_there/test-solve-value-iteration.jl")
#             include("$path_to_there/test-solve-linear-quadratic-problem.jl")
#             include("$path_to_there/test-greedy.jl")
#             include("$path_to_there/test-iterative_policy_evaluation.jl")
#             include("$path_to_there/test-lookahead.jl")
#         end
#         @time @safetestset "08-Approximate-Value-Functions Tests" begin
#             path_to_here = @__DIR__
#             path_to_there = "$path_to_here/II-Sequential-Problems/08-Approximate-Value-Functions"
#             include("$path_to_there/test-fit-MultilinearValueFunction.jl")
#             include("$path_to_there/test-fit-NearestNeighborValueFunction.jl")
#             include("$path_to_there/test-solve-ApproximateValueIteration.jl")
#             include("$path_to_there/test-fit-LocallyWeightedValueFunction.jl")
#             include("$path_to_there/test-fit-LinearRegressionValueFunction.jl")
#             include("$path_to_there/test-fit-SimplexValueFunction.jl")
#         end
#         @time @safetestset "09-Online-Planning Tests" begin
#             path_to_here = @__DIR__
#             path_to_there = "$path_to_here/II-Sequential-Problems/09-Online-Planning"
#
#             include("$path_to_there/test-simulate-LabeledHeuristicSearch.jl")
#             include("$path_to_there/test-sparse_sampling.jl")
#             include("$path_to_there/test-forward_search.jl")
#             include("$path_to_there/test-branch-and-bound.jl")
#             include("$path_to_there/test-label-LabeledHeuristicSearch.jl")
#             include("$path_to_there/test-simulate-MonteCarloTreeSearch.jl")
#             include("$path_to_there/test-simulate-HeuristicSearch.jl")
#             include("$path_to_there/test-rollout.jl")
#             include("$path_to_there/test-explore-MonteCarloTreeSearch.jl")
#         end
#         @time @safetestset "10-Policy-Search Tests" begin
#             path_to_here = @__DIR__
#             path_to_there = "$path_to_here/II-Sequential-Problems/10-Policy-Search"
#             include("$path_to_there/test-optimize_dist-EvolutionStrategies.jl")
#             include("$path_to_there/test-optimize_dist-IsotropicEvolutionStrategies.jl")
#             include("$path_to_there/test-optimize-HookeJeevesPolicySearch.jl")
#             include("$path_to_there/test-optimize-M.jl")
#             include("$path_to_there/test-optimize-GeneticPolicySearch.jl")
#             include("$path_to_there/test-evolution_strategy_weights.jl")
#             include("$path_to_there/test-optimize_dist-CrossEntropyPolicySearch.jl")
#
#         end
#         @time @safetestset "11-Policy-Gradient-Estimation Tests" begin
#             path_to_here = @__DIR__
#             path_to_there = "$path_to_here/II-Sequential-Problems/11-Policy-Gradient-Estimation"
#             include("$path_to_there/test-gradient-BaselineSubtractionGradient.jl")
#             include("$path_to_there/test-regression-gradient.jl")
#             include("$path_to_there/test-gradient-FiniteDifferenceGradient.jl")
#             include("$path_to_there/test-gradient-RegressionGradient.jl")
#             include("$path_to_there/test-gradient-RewardToGoGradient.jl")
#             include("$path_to_there/test-simulate-MDP.jl")
#             include("$path_to_there/test-gradient-LikelihoodRatioGradient.jl")
#         end
#         @time @safetestset "12-Policy-Gradient-Optimization Tests" begin
#             path_to_here = @__DIR__
#             path_to_there = "$path_to_here/II-Sequential-Problems/12-Policy-Gradient-Optimization"
#             include("$path_to_there/test-update-NaturalPolicyUpdate.jl")
#             include("$path_to_there/test-surrogate_constraint-TrustRegionUpdate.jl")
#             include("$path_to_there/test-surrogate_objective-TrustRegionUpdate.jl")
#             include("$path_to_there/test-update-ClampedSurrogateUpdate.jl")
#             include("$path_to_there/test-natural_update.jl")
#             include("$path_to_there/test-clamped_gradient-ClampedSurrogateUpdate.jl")
#             include("$path_to_there/test-update-TrustRegionUpdate.jl")
#             include("$path_to_there/test-update-RestrictedPolicyUpdate.jl")
#             include("$path_to_there/test-update-PolicyGradientUpdate.jl")
#             include("$path_to_there/test-linesearch-TrustRegionUpdate.jl")
#         end
#         @time @safetestset "13-Actor-Critic-Methods Tests" begin
#             path_to_here = @__DIR__
#             path_to_there = "$path_to_here/II-Sequential-Problems/13-Actor-Critic-Methods"
#             include("$path_to_there/test-gradient-DeterministicPolicyGradient.jl")
#             include("$path_to_there/test-gradient-ActorCritic.jl")
#             include("$path_to_there/test-gradient-GeneralizedAdvantageEstimation.jl")
#
#         end
#
#         @time @safetestset "14-Policy-Validation Tests" begin
#             path_to_here = @__DIR__
#             path_to_there = "$path_to_here/II-Sequential-Problems/14-Policy-Validation"
#             include("$path_to_there/test-adversarial-MDP.jl")
#         end
#     end
#     @time @safetestset "III-Model-Uncertainty Tests" begin
#         @time @safetestset "15-Exploration-and-Exploitation Tests" begin
#             path_to_here = @__DIR__
#             path_to_there = "$path_to_here/III-Model-Uncertainty/15-Exploration-and-Exploitation"
#             include("$path_to_there/test-update-BanditModel.jl")
#             include("$path_to_there/test-simulate-banditproblem.jl")
#             include("$path_to_there/test-simulate-MDP.jl")
#             include("$path_to_there/test-bonus-UCB1Exploration.jl")
#         end
#         @time @safetestset "16-Model-Based-Methods Tests" begin
#             path_to_here = @__DIR__
#             path_to_there = "$path_to_here/III-Model-Uncertainty/16-Model-Based-Methods"
#             include("$path_to_there/test-update-MaximumLikelihoodMDP.jl")
#             include("$path_to_there/test-backup-MaximumLikelihoodMDP.jl")
#             include("$path_to_there/test-backup-RmaxMDP.jl")
#             include("$path_to_there/test-lookahead-MaximumLikelihoodMDP.jl")
#             include("$path_to_there/test-lookahead-BayesianMDP.jl")
#             include("$path_to_there/test-update-RandomizedUpdate.jl")
#             include("$path_to_there/test-exploration.jl")
#             include("$path_to_there/test-update-FullUpdate.jl")
#             include("$path_to_there/test-update-RmaxMDP.jl")
#             include("$path_to_there/test-update-PrioritizedUpdate.jl")
#             include("$path_to_there/test-update-BayesianMDP.jl")
#             include("$path_to_there/test-lookahead-RmaxMDP.jl")
#             include("$path_to_there/test-update-PosteriorSamplingUpdate.jl")
#         end
#         @time @safetestset "17-Model-Free-Methods Tests" begin
#             path_to_here = @__DIR__
#             path_to_there = "$path_to_here/III-Model-Uncertainty/17-Model-Free-Methods"
#             include("$path_to_there/test-lookahead-ReplayGradientQLearning.jl")
#             include("$path_to_there/test-update-ReplayGradientQLearning.jl")
#             include("$path_to_there/test-update-IncrementalEstimate.jl")
#             include("$path_to_there/test-update-Sarsa.jl")
#             include("$path_to_there/test-lookahead-GradientQLearning.jl")
#             include("$path_to_there/test-q-learning.jl")
#             include("$path_to_there/test-reward-shaping.jl")
#             include("$path_to_there/test-update-GradientQLearning.jl")
#             include("$path_to_there/test-update-QLearning.jl")
#             include("$path_to_there/test-update-SarsaLambda.jl")
#         end
#         @time @safetestset "18-Imitation-Learning Tests" begin
#             """
#             optimize(M::BehavioralCloning, D, θ)
#             optimize(M::DatasetAggregation, D, θ)
#             feature_expectations(M::InverseReinforcementLearning, π)
#             discounted_state_visitations(M::MaximumEntropyIRL, θ)
#             optimize(M::MaximumEntropyIRL, D, ϕ, θ)
#             calc_weighting(M::InverseReinforcementLearning, μs)
#             calc_policy_mixture(M::InverseReinforcementLearning, μs)
#             optimize(M::InverseReinforcementLearning, θ)
#             optimize(M::SMILe, θ)
#             """
#         end
#     end
#     @time @safetestset "IV-State-Uncertainty Tests" begin
#         @time @safetestset "19-Beliefs Tests" begin
#             """
#             update(b::AdaptiveInjectionParticleFilter, problem, a, o)
#             update(b::KalmanFilter, problem, a, o)
#             update(b::ExtendedKalmanFilter, problem, a, o)
#             update(b::Vector{Float64}, problem, a, o)
#             update(b::ParticleFilter, problem, a, o)
#             update(b::RejectionParticleFilter, problem, a, o)
#             update(b::InjectionParticleFilter, problem, a, o)
#             unscented_transform(μ, Σ, f, λ, ws)
#             update(b::UnscentedKalmanFilter, problem, a, o)
#             """
#         end
#         @time @safetestset "20-Exact-Belief-State-Planning Tests" begin
#             """
#             utility(π::AlphaVectorPolicy, b)
#
#             lookahead(problem::POMDP, U, s, a)
#             evaluate_plan(problem::POMDP, π::ConditionalPlan, s)
#             alphavector(problem::POMDP, π::ConditionalPlan)
#             ConditionalPlan(problem::POMDP, a, plans)
#             combine_lookahead(problem::POMDP, s, a, Γo)
#             combine_alphavector(problem::POMDP, a, Γo)
#             expand(plans, Γ, problem)
#             lookahead(problem::POMDP, U, b::Vector, a)
#             greedy(problem::POMDP, U, b::Vector)
#             utility(π::LookaheadAlphaVectorPolicy, b)
#             greedy(π, b)
#             find_maximal_belief(α, Γ)
#             find_dominating(Γ)
#             prune(plans, Γ)
#             value_iteration(problem::POMDP, k_max)
#             solve(M::ValueIteration, problem::POMDP)
#             """
#         end
#         @time @safetestset "21-Offline-Belief-State-Planning Tests" begin
#             """
#             update(problem::POMDP, M::FastInformedBound, Γ)
#             solve(M::FastInformedBound, problem::POMDP)
#             baws_lowerbound(problem::POMDP)
#             alphavector_iteration(problem::POMDP, M, Γ)
#             update(problem::POMDP, M::QMDP, Γ)
#             solve(M::QMDP, problem::POMDP)
#             randstep(problem::POMDP, b, a)
#             random_belief_expansion(problem, B)
#             exploratory_belief_expansion(problem, B)
#             blind_lowerbound(problem, k_max)
#             backup(problem::POMDP, Γ, b)
#             update(problem::POMDP, M::PointBasedValueIteration, Γ)
#             solve(M::PointBasedValueIteration, problem)
#             update(problem::POMDP, M::RandomizedPointBasedValueIteration, Γ)
#             solve(M::RandomizedPointBasedValueIteration, problem)
#             explore!(M::SawtoothHeuristicSearch, problem, πhi, πlo, b, d = 0)
#             solve(M::SawtoothHeuristicSearch, problem::POMDP)
#             basis(problem)
#             utility(π::SawtoothPolicy, b)
#             solve(M::SawtoothIteration, problem::POMDP)
#             TriangulatedPolicy(problem::POMDP, m)
#             utility(π::TriangulatedPolicy, b)
#             solve(M::TriangulatedIteration, problem)
#             """
#         end
#         @time @safetestset "22-Online-Belief-State-Planning Tests" begin
#             """
#             determinized_sparse_tree_search(problem, b, d, Φ, U)
#             determized_approximate_belief(b, problem, m)
#
#             successor(problem, Φ, ϕ, a)
#             possible_observations(problem, Φ, b, a)
#             update(b, Φ, problem, a, o)
#             heuristic_search(π::GapHeuristicSearch, b, d)
#
#             explore(π::HistoryMonteCarloTreeSearch, h)
#             simulate(π::HistoryMonteCarloTreeSearch, s, h, d)
#
#             """
#         end
#         @time @safetestset "23-Controller-Abstractions Tests" begin
#             """
#
#             update(π::ControllerPolicy, x, a, o)
#             utility(π::ControllerPolicy, U, x, s)
#             iterative_policy_evaluation(π::ControllerPolicy, k_max)
#             solve(M::ControllerGradient, problem::POMDP)
#             improve!(π::ControllerPolicy, M::ControllerGradient, problem::POMDP)
#             project_to_simplex(y)
#             gradient(π::ControllerPolicy, M::ControllerGradient, problem::POMDP)
#             tensorform(problem::POMDP)
#             solve(M::NonlinearProgramming, problem::POMDP)
#             solve(M::ControllerPolicyIteration, problem::POMDP)
#             policy_improvement!(π::ControllerPolicy, U, prevX)
#             prune!(π::ControllerPolicy, U, prevX)
#             """
#         end
#     end
#     @time @safetestset "V-Multiagent-Systems Tests" begin
#         @time @safetestset "24-Multiagent-Reasoning Tests" begin
#             """
#             solve(M::CorrelatedEquilibrium, problem::SimpleGame)
#             simulate(problem::SimpleGame, π, k_max)
#             FictitiousPlay(problem::SimpleGame, i)
#             update!(πi::FictitiousPlay, a)
#             GradientAscent(problem::SimpleGame, i)
#             update!(πi::GradientAscent, a)
#             HierarchicalSoftmax(problem::SimpleGame, λ, k)
#             solve(M::HierarchicalSoftmax, problem)
#             IteratedBestResponse(problem::SimpleGame, k_max)
#             solve(M::IteratedBestResponse, problem)
#
#             tensorform(problem::SimpleGame)
#             solve(M::NashEquilibrium, problem::SimpleGame)
#             SimpleGamePolicy(p::Base.Generator)
#             SimpleGamePolicy(p::Dict)
#
#             utility(problem::SimpleGame, π, i)
#             best_response(problem::SimpleGame, π, i)
#             softmax_response(problem::SimpleGame, π, i, λ)
#             """
#         end
#         @time @safetestset "25-Sequential-Problems Tests" begin
#             """
#             tensorform(problem::MG)
#             solve!(M::NashEquilibrium, problem::MG)
#             randstep(problem::MG, s, a)
#             simulate(problem::MG, π, k_max, b)
#             MGFictitiousPlay(problem::MG, i)
#
#             update!(πi::MGFictitiousPlay, s, a, s′)
#             MGGradientAscent(problem::MG, i)
#
#             update!(πi::MGGradientAscent, s, a, s′)
#             policy_evaluation(problem::MG, π, i)
#             NashQLearning(problem::MG, i)
#
#             update!(πi::NashQLearning, s, a, s′)
#             best_response(problem::MG, π, i)
#             softmax_response(problem::MG, π, i, λ)
#             """
#         end
#         @time @safetestset "26-State-Uncertainty Tests" begin
#             """
#             solve(M::POMGDynamicProgramming, problem::POMG)
#             prune_dominated!(Π, problem::POMG)
#             is_dominated(problem::POMG, Π, i, πi)
#             create_conditional_plans(problem, d)
#             expand_conditional_plans(problem, Π)
#             solve(M::POMGNashEquilibrium, problem::POMG)
#             lookahead(problem::POMG, U, s, a)
#             evaluate_plan(problem::POMG, π, s)
#             utility(problem::POMG, b, π)
#             """
#         end
#         @time @safetestset "27-Collaborative-Agents Tests" begin
#             """
#             solve(M::DecPOMDPDynamicProgramming, problem::DecPOMDP)
#             solve(M::DecPOMDPHeuristicSearch, problem::DecPOMDP)
#             explore(M::DecPOMDPHeuristicSearch, problem::DecPOMDP, t)
#             solve(M::DecPOMDPIteratedBestResponse, problem::DecPOMDP)
#             tensorform(problem::DecPOMDP)
#             solve(M::DecPOMDPNonlinearProgramming, problem::DecPOMDP)
#             """
#         end
#     end
# end
