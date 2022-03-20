# Algorithms for Decision Making
*Mykel Kochenderfer, Tim Wheeler, and Kyle Wray*
Book webpage: https://algorithmsbook.com

This book provides a broad introduction to algorithms for decision making under uncertainty. 
It covers a wide variety of topics related to decision making, 
introducing the underlying mathematical problem formulations and the algorithms for solving them.

This repo is a fork which bundles those algorithms into a Julia package
including path independent includes and unit tests

The book is divided into five parts.

## I Probabilistic Reasoning

The first part addresses the problem of reasoning about uncertainty and objectives in simple decisions at a single point in time.

## II Sequential Problems

The second part extends decision making to sequential problems, 
where we must make a sequence of decisions in response to information about the outcomes of our actions as we proceed.

## III Model Uncertainty

The third part addresses model uncertainty, 
where we do not start with a known model and must learn how to act through interaction with the environment. 

## IV State Uncertainty

The fourth part addresses state uncertainty, 
where imperfect perceptual information prevents us from knowing the full environmental state.

## V Multiagent Systems

The fifth and final part discusses decision contexts involving multiple agents.

# Using project

These steps will install the packages in the same state that is given by Manifest.toml. 
Otherwise, it will resolve the latest versions of the dependencies compatible with Project.toml.

1. clone 
2. cd to the project directory
3. activate current directory
4. instantiate

```
git clone https://github.com/wilsonify/decisionmaking.git
cd decisionmaking
julia # enter julia REPL then type "]" to enter Pkg REPL
activate .
instantiate
```

# Tests 
run the tests with a specific environment
```
julia --project=<path/to/Project.toml> test/runtests.jl
```