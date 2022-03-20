
struct SawtoothPolicy
    problem::Any # POMDP problem
    V::Any # dictionary mapping beliefs to utilities
end
function basis(problem)
    n = length(problem.𝒮)
    e(i) = [j == i ? 1.0 : 0.0 for j = 1:n]
    return [e(i) for i = 1:n]
end
function utility(π::SawtoothPolicy, b)
    problem, V = π.problem, π.V
    if haskey(V, b)
        return V[b]
    end
    n = length(problem.𝒮)
    E = basis(problem)
    u = sum(V[E[i]] * b[i] for i = 1:n)
    for (b′, u′) in V
        if b′ ∉ E
            i = argmax([norm(b - e, 1) - norm(b′ - e, 1) for e in E])
            w = [norm(b - e, 1) for e in E]
            w[i] = norm(b - b′, 1)
            w /= sum(w)
            w = [1 - wi for wi in w]
            α = [V[e] for e in E]
            α[i] = u′
            u = min(u, w ⋅ α)
        end
    end
    return u
end
"""
The sawtooth upper bound representation for value
functions and policies. It is defined
using a dictionary V that maps belief vectors to upper bounds on
their utility obtained, for example, from the fast informed bound.
A requirement of this representation is that V contain belief-utility
pairs at the standard basis beliefs,
which can be obtained from the
basis function. We can use onestep lookahead to obtain greedy
action-utility pairs from arbitrary
beliefs b .
"""
(π::SawtoothPolicy)(b) = greedy(π, b).a


struct SawtoothIteration
    """
        Sawtooth iteration iteratively applies one-step
lookahead at points in B to improve
the utility estimates at the points in
V . The beliefs in B are a superset of
those contained in V . To preserve
the upper bound at each iteration,
updates are not made at the standard basis beliefs stored in E . We
run k_max iterations.
        """
    # initial mapping from beliefs to utilities
    V::Any
    B::Any
    # beliefs to compute values including those in V map
    k_max::Any # maximum number of iterations
end
function solve(M::SawtoothIteration, problem::POMDP)
    E = basis(problem)
    π = SawtoothPolicy(problem, M.V)
    for k = 1:M.k_max
        V = Dict(b => (b ∈ E ? M.V[b] : greedy(π, b).u) for b in M.B)
        π = SawtoothPolicy(problem, V)
    end
    return π
end
