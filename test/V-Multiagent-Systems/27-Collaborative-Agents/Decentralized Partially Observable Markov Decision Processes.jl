struct DecPOMDP
    """
    Data structure
    for a decentralized partially observable Markov decision process
    (Dec-POMDP). The joint function from algorithm 24.2 allows the
    creation of all permutations of a
    set provided, such as 𝒜 or 𝒪 . The
    tensorform function converts the
    Dec-POMDP 𝒫 to a tensor representation.
    """
    γ::Any # discount factor
    ℐ::Any # agents
    𝒮::Any # state space
    𝒜::Any # joint action space
    𝒪::Any # joint observation space
    T::Any # transition function
    O::Any # joint observation function
    R::Any # reward function
end










