struct POMG
    """
    Data structure
for a partially observable Markov
game.
    """
    γ::Any # discount factor
    ℐ::Any # agents
    𝒮::Any # state space
    𝒜::Any # joint action space
    𝒪::Any # joint observation space
    T::Any # transition function
    O::Any # joint observation function
    R::Any # joint reward function
end








