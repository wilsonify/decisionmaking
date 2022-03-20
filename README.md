# Algorithms for Decision Making
*Mykel Kochenderfer, Tim Wheeler, and Kyle Wray*
Book webpage: https://algorithmsbook.com

This book provides a broad introduction to algorithms for decision making under uncertainty. 
It covers a wide variety of topics related to decision making, 
introducing the underlying mathematical problem formulations and the algorithms for solving them.

This repo is a fork which bundles those algorithms into a Julia package
including path independent includes and unit tests

# Using project

This will install the packages in the same state that is given by Manifest.toml. 
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