
struct IteratedBestResponse
    """
    Iterated best response involves cycling through
the agents and applying their best
response to the other agents. The
algorithm starts with some initial
policy and stops after k_max iterations. For convenience, we have
a constructor that takes as input a
simple game and creates an initial
policy that has each agent select
actions uniformly at random. The
same solve function will be reused
in the next chapter in the context of
more complicated forms of games.
    """
    k_max::Any # number of iterations
    π::Any
    # initial policy
end
function IteratedBestResponse(𝒫::SimpleGame, k_max)
    π = [SimpleGamePolicy(ai => 1.0 for ai in 𝒜i) for 𝒜i in 𝒫.𝒜]
    return IteratedBestResponse(k_max, π)
end
function solve(M::IteratedBestResponse, 𝒫)
    π = M.π
    for k = 1:M.k_max
        π = [best_response(𝒫, π, i) for i in 𝒫.ℐ]
    end
    return π
end
