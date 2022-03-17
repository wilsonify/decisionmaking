include("Simple Games.jl")
struct SimpleGamePolicy
    """
    A policy associated with an agent is represented
    by a dictionary that maps actions
    to probabilities. There are different ways to construct a policy. One
    way is to pass in a dictionary directory, in which case the probabilities
    are normalized. Another way is to
    pass in a generator that creates this
    dictionary. We can also construct a
    policy by passing in an action, in
    which case it assigns probability 1
    to that action. If we have an individual policy πi , we can call πi(ai)
    to compute the probability the policy associates with action ai . If we
    call πi() , then it will return a random action according to that policy.
    We can use joint(𝒜) to construct
    the joint action space from 𝒜 . We
    can use utility(𝒫, π, i) to compute the utility associated with executing joint policy π in the game
    𝒫 from the perspective of agent i .
    """
    p::Any # dictionary mapping actions to probabilities
    function SimpleGamePolicy(p::Base.Generator)
        return SimpleGamePolicy(Dict(p))
    end
    function SimpleGamePolicy(p::Dict)
        vs = collect(values(p))
        vs ./= sum(vs)
        return new(Dict(k => v for (k, v) in zip(keys(p), vs)))
    end
end
SimpleGamePolicy(ai) = new(Dict(ai => 1.0))
(πi::SimpleGamePolicy)(ai) = get(πi.p, ai, 0.0)
function (πi::SimpleGamePolicy)()
    D = SetCategorical(collect(keys(πi.p)), collect(values(πi.p)))
    return rand(D)
end
joint(X) = vec(collect(product(X...)))
joint(π, πi, i) = [i == j ? πi : πj for (j, πj) in enumerate(π)]

function utility(𝒫::SimpleGame, π, i)
    𝒜, R = 𝒫.𝒜, 𝒫.R
    p(a) = prod(πj(aj) for (πj, aj) in zip(π, a))
    return sum(R(a)[i] * p(a) for a in joint(𝒜))
end

"""
For a simple game
𝒫 , we can compute a deterministic best response for agent i given
that the other agents are playing
the policies in π .
"""
function best_response(𝒫::SimpleGame, π, i)
    U(ai) = utility(𝒫, joint(π, SimpleGamePolicy(ai), i), i)
    ai = argmax(U, 𝒫.𝒜[i])
    return SimpleGamePolicy(ai)
end
