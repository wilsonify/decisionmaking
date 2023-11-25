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

## Errata

### First printing

* [p. 108] Ex 5.4: Make edge E->D in the PDAG directed (thanks to Nikhil Raghuraman)
* [p. 121] Alg 6.2: Caption updated to reflect that algorithm returns the value of information (thanks to Griffin Holt) 
* [p. 157] Ex 7.9: Change solution to "then both policies are optimal" (thanks to Liam Kruse)
* [p. 174] Fig 8.13: Changed "polynomial" to "quadratic" (thanks to Balduin)
* [p. 192] Ex 9.5: Change N(s0) to 1, as count is not incremented until after exploration (thanks to Paul Diederichs)
* [p. 196] Ex 9.8: Change line plot colors to improve readability wrt color blindness (thanks to Zhen Wu)
* [p. 199] Alg 9.9: P.S should be prepended with "π." (thanks to Griffin Holt)
* [p. 226] Fix intermediate derivation in equation in solution of Ex 10.1 (thanks to Paul Diederichs)
* [p. 246] Ex 11.2 solution: "theh" should be "the" (thanks to Marc Schlicting)
* [p. 307] Ex 15.3 curve was not plotted with the correct demoninator, causing the curve to be too low (thanks to Hugo Buurmeijer)
* [p. 314] Ex 15.7 values for arm 1 were fixed (thanks to Mykel)
* [p. 317] Mention that when N(s,a) = 0, we can use a uniform distribution or set T(s,a) to zero (thanks to Mykel and Dylan Asmar)
* [p. 329] Eq 16.8: b in second P(s'|s,b,a) should be theta (thanks to Griffin Holt)
* [p. 330] Change the reference to Chapter 16 to be to Part 4 instead (thanks to Michael Sheehan)
* [p. 644] Sec. G.3.2: "x" in text should be "X" to be consistent with code (thanks to Ziyu Wang)
