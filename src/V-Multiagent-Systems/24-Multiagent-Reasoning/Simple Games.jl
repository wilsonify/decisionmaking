struct SimpleGame
    """
    Data structure for
        a simple game.
    """
    γ::Any # discount factor
    ℐ::Any # agents
    𝒜::Any # joint action space
    R::Any # joint reward function
end





"""
For a simple game
𝒫 and a particular agent i , we can
compute the softmax response policy πi given the other agents are
playing the policies in π . This computation requires specifying the
precision parameter λ .
"""
function softmax_response(𝒫::SimpleGame, π, i, λ)
    𝒜i = 𝒫.𝒜[i]
    U(ai) = utility(𝒫, joint(π, SimpleGamePolicy(ai), i), i)
    return SimpleGamePolicy(ai => exp(λ * U(ai)) for ai in 𝒜i)
end
