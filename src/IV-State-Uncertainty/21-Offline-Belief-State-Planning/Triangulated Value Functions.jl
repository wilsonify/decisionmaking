struct TriangulatedPolicy
    """
    A policy representation using Freudenthal
triangulation with granularity m .
As with the sawtooth method,
we maintain a dictionary that
maps belief vectors to utilities.
This implementation initializes
the utilities to 0, but if we want to
represent an upper bound, then
we would need to initialize those
utilities appropriately. We define a
function to estimate the utility of
a given belief using interpolation.
We can extract a policy using
greedy lookahead. The Freudenthal triangulation structure is
passed the dimensionality and
granularity at construction. The
FreudenthalTriangulations.jl
package provides the function
belief_vertices , which returns
B given a particular triangulation.
It also provides belief_simplex ,
which returns the set of enclosing
points and weights for a belief.
    """
    𝒫::Any # POMDP problem
    V::Any # dictionary mapping beliefs to utilities
    B::Any # beliefs
    T::Any # Freudenthal triangulation
end
function TriangulatedPolicy(𝒫::POMDP, m)
    T = FreudenthalTriangulation(length(𝒫.𝒮), m)
    B = belief_vertices(T)
    V = Dict(b => 0.0 for b in B)
    return TriangulatedPolicy(𝒫, V, B, T)
end
function utility(π::TriangulatedPolicy, b)
    B, λ = belief_simplex(π.T, b)
    return sum(λi * π.V[b] for (λi, b) in zip(λ, B))
end
(π::TriangulatedPolicy)(b) = greedy(π, b).a


struct TriangulatedIteration
    """
        Approximate
value iteration with k_max iterations using a triangulated policy
with granularity m . At each iteration, we update the utilities associated with the beliefs in B using
greedy one-step lookahead with
triangulated utilities.
        """
    # granulatiry
    m::Any
    k_max::Any # maximum number of iterations
end
function solve(M::TriangulatedIteration, 𝒫)
    π = TriangulatedPolicy(𝒫, M.m)
    U(b) = utility(π, b)
    for k = 1:M.k_max
        U′ = [greedy(𝒫, U, b).u for b in π.B]
        for (b, u′) in zip(π.B, U′)
            π.V[b] = u′
        end
    end
    return π
end
