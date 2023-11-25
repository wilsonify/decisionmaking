module DecisionMakingAlgorithms
    include("I-Probabilistic-Reasoning/01-Introduction/structureA.jl")
    export structureA
    include("I-Probabilistic-Reasoning/02-Representation/variable.jl")
    export Variable
    include("I-Probabilistic-Reasoning/02-Representation/assignment.jl")
    export Assignment
    include("I-Probabilistic-Reasoning/02-Representation/factor-table.jl")
    export FactorTable
    include("I-Probabilistic-Reasoning/02-Representation/factor.jl")
    export Factor
    include("I-Probabilistic-Reasoning/02-Representation/bayesian-network.jl")
    export BayesianNetwork
    export probability
end
# include("Convenience Functions.jl")
# include("VI-Appendix/E-Search-Algorithms/E1-search.jl")
# include("VI-Appendix/E-Search-Algorithms/E3-forward-search.jl")
# include("VI-Appendix/E-Search-Algorithms/E4-branch-and-bound.jl")
# include("VI-Appendix/E-Search-Algorithms/E5-dynamic-programming.jl")
# include("VI-Appendix/E-Search-Algorithms/E6-heuristic-search.jl")
#
# include("I-Probabilistic-Reasoning/01-Introduction/foo.jl")
# include("I-Probabilistic-Reasoning/01-Introduction/helloWorld.jl")
# include("I-Probabilistic-Reasoning/01-Introduction/receive.jl")

# include("I-Probabilistic-Reasoning/03-Inference/exact-inference.jl")
# include("I-Probabilistic-Reasoning/03-Inference/direct-sampling.jl")
# include("I-Probabilistic-Reasoning/03-Inference/Gaussian-Model-Inference.jl")
# include("I-Probabilistic-Reasoning/03-Inference/gibbs-sampling.jl")
# include("I-Probabilistic-Reasoning/03-Inference/likelihood-weighted-sampling.jl")
# include("I-Probabilistic-Reasoning/03-Inference/variable-elimination.jl")

# include( "I-Probabilistic-Reasoning/04-Parameter-Learning/Maximum-Likelihood-Estimates-for-Bayesian-Networks.jl")
# include("I-Probabilistic-Reasoning/04-Parameter-Learning/prior.jl")
#
# include("I-Probabilistic-Reasoning/04-Parameter-Learning/Nonparametric-Learning.jl")
# include("I-Probabilistic-Reasoning/05-Structure-Learning/Bayesian-Network-Scoring.jl")
#
# include("I-Probabilistic-Reasoning/05-Structure-Learning/K2Search.jl")
# include("I-Probabilistic-Reasoning/05-Structure-Learning/LocalDirectedGraphSearch.jl")
# include( "I-Probabilistic-Reasoning/05-Structure-Learning/Partially-Directed-Graph-Search.jl" )
#
# include("I-Probabilistic-Reasoning/06-Simple-Decisions/SimpleProblem.jl")
# include("I-Probabilistic-Reasoning/06-Simple-Decisions/Value-of-Information.jl")
#
# include("II-Sequential-Problems/07-Exact-Solution-Methods/Markov-Decision-Processes.jl")
# include("II-Sequential-Problems/07-Exact-Solution-Methods/Asynchronous-Value-Iteration.jl")
# include("II-Sequential-Problems/07-Exact-Solution-Methods/Linear-Program-Formulation.jl")
# include( "II-Sequential-Problems/07-Exact-Solution-Methods/Linear-Systems-with-Quadratic-Reward.jl" )
# include("II-Sequential-Problems/07-Exact-Solution-Methods/Policy-Iteration.jl")
# include("II-Sequential-Problems/07-Exact-Solution-Methods/Value-Function-Policies.jl")
# include("II-Sequential-Problems/07-Exact-Solution-Methods/Value-Iteration.jl")
#
# include("II-Sequential-Problems/08-Approximate-Value-Functions/Kernel-Smoothing.jl")
# include("II-Sequential-Problems/08-Approximate-Value-Functions/Linear-Regression.jl")
# include("II-Sequential-Problems/08-Approximate-Value-Functions/Nearest-Neighbor.jl")
# include( "II-Sequential-Problems/08-Approximate-Value-Functions/Parametric Representations.jl")
# include("II-Sequential-Problems/08-Approximate-Value-Functions/Simplex-Interpolation.jl")
#
# include("II-Sequential-Problems/09-Online-Planning/Branch-and-Bound.jl")
# include("II-Sequential-Problems/09-Online-Planning/Forward-Search.jl")
# include("II-Sequential-Problems/09-Online-Planning/Heuristic-Search.jl")
# include("II-Sequential-Problems/09-Online-Planning/Labeled-Heuristic-Search.jl")
# include("II-Sequential-Problems/09-Online-Planning/Lookahead-with-Rollouts.jl")
# include("II-Sequential-Problems/09-Online-Planning/Monte-Carlo-Tree-Search.jl")
# include("II-Sequential-Problems/09-Online-Planning/Open-Loop-Planning.jl")
# include("II-Sequential-Problems/09-Online-Planning/Sparse-Sampling.jl")
#
# include("II-Sequential-Problems/10-Policy-Search/Approximate-Policy-Evaluation.jl")
# include("II-Sequential-Problems/10-Policy-Search/Cross-Entropy-Method.jl")
# include("II-Sequential-Problems/10-Policy-Search/Isotropic-Evolutionary-Strategies.jl")
#
# include("II-Sequential-Problems/11-Policy-Gradient-Estimation/Baseline-Subtraction.jl")
# include("II-Sequential-Problems/11-Policy-Gradient-Estimation/Finite-Difference.jl")
# include("II-Sequential-Problems/11-Policy-Gradient-Estimation/Likelihood-Ratio.jl")
# include("II-Sequential-Problems/11-Policy-Gradient-Estimation/Regression-Gradient.jl")
# include("II-Sequential-Problems/11-Policy-Gradient-Estimation/Reward-to-Go.jl")
#
# include( "II-Sequential-Problems/12-Policy-Gradient-Optimization/Clamped Surrogate Objective.jl")
# include("II-Sequential-Problems/12-Policy-Gradient-Optimization/Gradient Ascent Update.jl")
# include("II-Sequential-Problems/12-Policy-Gradient-Optimization/Natural Gradient Update.jl")
# include( "II-Sequential-Problems/12-Policy-Gradient-Optimization/Restricted Gradient Update.jl")
# include("II-Sequential-Problems/12-Policy-Gradient-Optimization/Trust Region Update.jl")
#
# include( "II-Sequential-Problems/13-Actor-Critic-Methods/Actor-Critic with Monte Carlo Tree Search.jl")
# include("II-Sequential-Problems/13-Actor-Critic-Methods/Actor-Critic.jl")
# include("II-Sequential-Problems/13-Actor-Critic-Methods/Deterministic Policy Gradient.jl")
# include( "II-Sequential-Problems/13-Actor-Critic-Methods/Generalized Advantage Estimation.jl")
#
# include("II-Sequential-Problems/14-Policy-Validation/Adversarial Analysis.jl")
#
#
# include("III-Model-Uncertainty/15-Exploration-and-Exploitation/Bandit Problems.jl")
# include( "III-Model-Uncertainty/15-Exploration-and-Exploitation/Bayesian Model Estimation.jl")
# include( "III-Model-Uncertainty/15-Exploration-and-Exploitation/Directed Exploration Strategies.jl")
# include( "III-Model-Uncertainty/15-Exploration-and-Exploitation/Exploration with Multiple States.jl")
# include( "III-Model-Uncertainty/15-Exploration-and-Exploitation/Optimal Exploration Strategies.jl")
# include( "III-Model-Uncertainty/15-Exploration-and-Exploitation/Undirected Exploration Strategies.jl")
#
# include("III-Model-Uncertainty/16-Model-Based-Methods/Bayes-adaptive MDPs.jl")
# include("III-Model-Uncertainty/16-Model-Based-Methods/Exploration.jl")
# include("III-Model-Uncertainty/16-Model-Based-Methods/Maximum Likelihood Models.jl")
# include("III-Model-Uncertainty/16-Model-Based-Methods/Posterior Sampling.jl")
# include("III-Model-Uncertainty/16-Model-Based-Methods/Update Schemes.jl")
#
# include( "III-Model-Uncertainty/17-Model-Free-Methods/Action Value Function Approximation.jl")
# include("III-Model-Uncertainty/17-Model-Free-Methods/Eligibility Traces.jl")
# include("III-Model-Uncertainty/17-Model-Free-Methods/Experience Replay.jl")
# include("III-Model-Uncertainty/17-Model-Free-Methods/Incremental Estimation of the Mean.jl")
# include("III-Model-Uncertainty/17-Model-Free-Methods/Q-Learning.jl")
# include("III-Model-Uncertainty/17-Model-Free-Methods/Sarsa.jl")
#
# include("III-Model-Uncertainty/18-Imitation-Learning/Behavioral Cloning.jl")
# include("III-Model-Uncertainty/18-Imitation-Learning/Dataset Aggregation.jl")
# include( "III-Model-Uncertainty/18-Imitation-Learning/Generative Adversarial Imitation Learning.jl")
# include("III-Model-Uncertainty/18-Imitation-Learning/Inverse Reinforcement Learning.jl")
# include("III-Model-Uncertainty/18-Imitation-Learning/Maximum Entropy Inverse Reinforcement Learning.jl")
# include("III-Model-Uncertainty/18-Imitation-Learning/Maximum Margin Inverse Reinforcement Learning.jl")
# include("III-Model-Uncertainty/18-Imitation-Learning/Stochastic Mixing Iterative Learning.jl")
#
#
# include("IV-State-Uncertainty/19-Beliefs/Adaptive Injection Particle Filter.jl")
# include("IV-State-Uncertainty/19-Beliefs/Belief Initialization.jl")
# include("IV-State-Uncertainty/19-Beliefs/Discrete State Filter.jl")
# include("IV-State-Uncertainty/19-Beliefs/Extended Kalman Filter.jl")
# include("IV-State-Uncertainty/19-Beliefs/Linear Gaussian Filter.jl")
# include("IV-State-Uncertainty/19-Beliefs/Particle Filter.jl")
# include("IV-State-Uncertainty/19-Beliefs/Particle Injection.jl")
# include("IV-State-Uncertainty/19-Beliefs/Unscented Kalman Filter.jl")
#
# include("IV-State-Uncertainty/20-Exact-Belief-State-Planning/Alpha Vectors.jl")
# include(
#     "IV-State-Uncertainty/20-Exact-Belief-State-Planning/Belief-State Markov Decision Processes.jl",
# )
# include("IV-State-Uncertainty/20-Exact-Belief-State-Planning/Conditional Plans.jl")
# include("IV-State-Uncertainty/20-Exact-Belief-State-Planning/Linear Policies.jl")
# include("IV-State-Uncertainty/20-Exact-Belief-State-Planning/Pruning.jl")
# include("IV-State-Uncertainty/20-Exact-Belief-State-Planning/Value Iteration.jl")
#
# include("IV-State-Uncertainty/21-Offline-Belief-State-Planning/Fast Informed Bound.jl")
# include("IV-State-Uncertainty/21-Offline-Belief-State-Planning/Fast Lower Bounds.jl")
# include(
#     "IV-State-Uncertainty/21-Offline-Belief-State-Planning/Fully Observable Value Approximation.jl",
# )
# include("IV-State-Uncertainty/21-Offline-Belief-State-Planning/Point Selection.jl")
# include(
#     "IV-State-Uncertainty/21-Offline-Belief-State-Planning/Point-Based Value Iteration.jl",
# )
# include(
#     "IV-State-Uncertainty/21-Offline-Belief-State-Planning/Randomized Point-Based Value Iteration.jl",
# )
# include(
#     "IV-State-Uncertainty/21-Offline-Belief-State-Planning/Sawtooth Heuristic Search.jl",
# )
# include("IV-State-Uncertainty/21-Offline-Belief-State-Planning/Sawtooth Upper Bound.jl")
# include(
#     "IV-State-Uncertainty/21-Offline-Belief-State-Planning/Triangulated Value Functions.jl",
# )
#
# include("IV-State-Uncertainty/22-Online-Belief-State-Planning/Controllers.jl")
# include(
#     "IV-State-Uncertainty/22-Online-Belief-State-Planning/Determinized Sparse Tree Search.jl",
# )
# include("IV-State-Uncertainty/22-Online-Belief-State-Planning/DeterminizedParticle.jl")
# include("IV-State-Uncertainty/22-Online-Belief-State-Planning/Gap Heuristic Search.jl")
# include("IV-State-Uncertainty/22-Online-Belief-State-Planning/Gradient Ascent.jl")
# include("IV-State-Uncertainty/22-Online-Belief-State-Planning/Monte Carlo Tree Search.jl")
# include("IV-State-Uncertainty/22-Online-Belief-State-Planning/Nonlinear Programming.jl")
# include("IV-State-Uncertainty/22-Online-Belief-State-Planning/Policy Iteration.jl")
#
# include("IV-State-Uncertainty/23-Controller-Abstractions/Controllers.jl")
# include("IV-State-Uncertainty/23-Controller-Abstractions/Gradient Ascent.jl")
# include("IV-State-Uncertainty/23-Controller-Abstractions/Nonlinear Programming.jl")
# include("IV-State-Uncertainty/23-Controller-Abstractions/Policy Iteration.jl")

# # Types
# export Assignment
# export FactorTable
#
# include("V-Multiagent-Systems/24-Multiagent-Reasoning/Simple Games.jl")
# include("V-Multiagent-Systems/24-Multiagent-Reasoning/Correlated Equilibrium.jl")
# include("V-Multiagent-Systems/24-Multiagent-Reasoning/Dominant Strategy Equilibrium.jl")
# include("V-Multiagent-Systems/24-Multiagent-Reasoning/Fictitious Play.jl")
# include("V-Multiagent-Systems/24-Multiagent-Reasoning/Gradient Ascent.jl")
# include("V-Multiagent-Systems/24-Multiagent-Reasoning/Hierarchical Softmax.jl")
# include("V-Multiagent-Systems/24-Multiagent-Reasoning/Iterated Best Response.jl")
# include("V-Multiagent-Systems/24-Multiagent-Reasoning/Nash Equilibrium.jl")
# include("V-Multiagent-Systems/24-Multiagent-Reasoning/Response Models.jl")
#
# include("V-Multiagent-Systems/25-Sequential-Problems/Markov Games.jl")
# include("V-Multiagent-Systems/25-Sequential-Problems/Fictitious Play.jl")
# include("V-Multiagent-Systems/25-Sequential-Problems/Gradient Ascent.jl")
# include("V-Multiagent-Systems/25-Sequential-Problems/Nash Equilibrium.jl")
# include("V-Multiagent-Systems/25-Sequential-Problems/Nash Q-Learning.jl")
# include("V-Multiagent-Systems/25-Sequential-Problems/Response Models.jl")
#
# include("V-Multiagent-Systems/26-State-Uncertainty/Partially Observable Markov Games.jl")
# include("V-Multiagent-Systems/26-State-Uncertainty/Dynamic Programming.jl")
# include("V-Multiagent-Systems/26-State-Uncertainty/Nash Equilibrium.jl")
# include("V-Multiagent-Systems/26-State-Uncertainty/Policy Evaluation.jl")
#
# include(
#     "V-Multiagent-Systems/27-Collaborative-Agents/Decentralized Partially Observable Markov Decision Processes.jl",
# )
# include("V-Multiagent-Systems/27-Collaborative-Agents/Dynamic Programming.jl")
# include("V-Multiagent-Systems/27-Collaborative-Agents/Heuristic Search.jl")
# include("V-Multiagent-Systems/27-Collaborative-Agents/Iterated Best Response.jl")
# include("V-Multiagent-Systems/27-Collaborative-Agents/Nonlinear Programming.jl")
# include("V-Multiagent-Systems/27-Collaborative-Agents/Subclasses.jl")
#
#
# # Types
# export Assignment
# export FactorTable
#
# #structs
# export SetCategorical
#
# export Factor

# export DirectSampling
# export ExactInference
# export GibbsSampling
# export LikelihoodWeightedSampling
# export VariableElimination
# export K2Search
# export LocalDirectedGraphSearch
# export SimpleProblem
# export GaussSeidelValueIteration
# export LinearProgramFormulation
# export LinearQuadraticProblem
# export MDP
# export PolicyIteration
# export ValueFunctionPolicy
# export ValueIteration
# export LocallyWeightedValueFunction
# export LinearRegressionValueFunction
# export NearestNeighborValueFunction
# export ApproximateValueIteration
# export MultilinearValueFunction
# export SimplexValueFunction
# export BranchAndBound
# export ForwardSearch
# export HeuristicSearch
# export LabeledHeuristicSearch
# export RolloutLookahead
# export MonteCarloTreeSearch
# export SparseSampling
# export MonteCarloPolicyEvaluation
# export HookeJeevesPolicySearch
# export GeneticPolicySearch
# export CrossEntropyPolicySearch
# export EvolutionStrategies
# export IsotropicEvolutionStrategies
# export BaselineSubtractionGradient
# export FiniteDifferenceGradient
# export LikelihoodRatioGradient
# export RegressionGradient
# export RewardToGoGradient
# export ClampedSurrogateUpdate
# export PolicyGradientUpdate
# export NaturalPolicyUpdate
# export RestrictedPolicyUpdate
# export TrustRegionUpdate
# export ActorCritic
# export DeterministicPolicyGradient
# export GeneralizedAdvantageEstimation
# export BanditProblem
# export BanditModel
# export SoftmaxExploration
# export QuantileExploration
# export UCB1Exploration
# export PosteriorSamplingExploration
# export EpsilonGreedyExploration
# export ExploreThenCommitExploration
# export BayesianMDP
# export PrioritizedUpdate
# export RmaxMDP
# export MaximumLikelihoodMDP
# export PosteriorSamplingUpdate
# export FullUpdate
# export RandomizedUpdate
# export GradientQLearning
# export SarsaLambda
# export ReplayGradientQLearning
# export IncrementalEstimate
# export QLearning
# export Sarsa
# export BehavioralCloning
# export DatasetAggregation
# export InverseReinforcementLearning
# export MaximumEntropyIRL
# export SMILe
# export AdaptiveInjectionParticleFilter
# export POMDP
# export KalmanFilter
# export ExtendedKalmanFilter
# export ParticleFilter
# export RejectionParticleFilter
# export InjectionParticleFilter
# export UnscentedKalmanFilter
# export AlphaVectorPolicy
# export ConditionalPlan
# export LookaheadAlphaVectorPolicy
# export FastInformedBound
# export QMDP
# export PointBasedValueIteration
# export RandomizedPointBasedValueIteration
# export SawtoothHeuristicSearch
# export SawtoothPolicy
# export SawtoothIteration
# export TriangulatedPolicy
# export TriangulatedIteration
# export DeterminizedSparseTreeSearch
# export DeterminizedParticle
# export GapHeuristicSearch
# export HistoryMonteCarloTreeSearch
# export ControllerPolicy
# export ControllerGradient
# export NonlinearProgramming
# export ControllerPolicyIteration
# export CorrelatedEquilibrium
# export FictitiousPlay
# export GradientAscent
# export HierarchicalSoftmax
# export IteratedBestResponse
# export JointCorrelatedPolicy
# export NashEquilibrium
# export SimpleGamePolicy
# export SimpleGame
# export MGFictitiousPlay
# export MGGradientAscent
# export MG
# export MGPolicy
# export NashQLearning
# export POMGDynamicProgramming
# export POMGNashEquilibrium
# export POMG
# export DecPOMDP
# export DecPOMDPDynamicProgramming
# export DecPOMDPHeuristicSearch
# export DecPOMDPIteratedBestResponse
# export DecPOMDPNonlinearProgramming
# export Search
#
#
# #functions
# export foo
# export hello
# export hello_squares
# export receive
# export assignments

# export blanket
# export update_gibbs_sample!
# export gibbs_sample!
# export normalize_factor!
# export variablenames
# export marginalize
# export in_scope
# export condition
# export conditioning
# export infer
# export sub2ind
# export statistics
# export gaussian_kernel
# export kernel_density_estimate
# export prior
# export bayesian_score_component
# export bayesian_score
# export fit
# export rand_graph_neighbor
# export are_markov_equivalent
# export solve
# export value_of_information
# export tensorform
# export lookahead
# export backup
# export iterative_policy_evaluation
# export policy_evaluation
# export greedy
# export fit!
# export branch_and_bound
# export forward_search
# export simulate!
# export rollout
# export explore
# export expand
# export label!
# export sparse_sampling
# export optimize
# export optimize_dist
# export evolution_strategy_weights
# export gradient
# export simulate
# export clamped_gradient
# export update
# export natural_update
# export surrogate_objective
# export surrogate_constraint
# export linesearch
# export adversarial
# export bandito
# export update!
# export feature_expectations
# export discounted_state_visitations
# export calc_weighting
# export calc_policy_mixture
# export unscented_transform
# export utility
# export evaluate_plan
# export alphavector
# export ConditionalPlan
# export combine_lookahead
# export combine_alphavector
# export find_maximal_belief
# export find_dominating
# export prune
# export value_iteration
# export baws_lowerbound
# export alphavector_iteration
# export randstep
# export random_belief_expansion
# export exploratory_belief_expansion
# export blind_lowerbound
# export explore!
# export basis
# export TriangulatedPolicy
# export determinized_sparse_tree_search
# export determized_approximate_belief
# export successor
# export possible_observations
# export heuristic_search
# export improve!
# export project_to_simplex
# export policy_improvement!
# export prune!
# export FictitiousPlay
# export GradientAscent
# export HierarchicalSoftmax
# export IteratedBestResponse
# export best_response
# export softmax_response
# export solve!
# export MGFictitiousPlay
# export MGGradientAscent
# export NashQLearning
# export prune_dominated!
# export is_dominated
# export create_conditional_plans
# export expand_conditional_plans
# export dynamic_programming

