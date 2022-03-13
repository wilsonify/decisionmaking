.phony: install-dependencies test

installed.txt:
	julia packages.jl

test: installed.txt
	julia test-bayesian-networks.jl