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
problem and a particular agent i , we can
compute the softmax response policy πi given the other agents are
playing the policies in π . This computation requires specifying the
precision parameter λ .
"""
function softmax_response(problem::SimpleGame, π, i, λ)
    𝒜i = problem.𝒜[i]
    U(ai) = utility(problem, joint(π, SimpleGamePolicy(ai), i), i)
    return SimpleGamePolicy(ai => exp(λ * U(ai)) for ai in 𝒜i)
end
