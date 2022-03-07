struct MDP
    """
        Data structure for
        an MDP. We will use the TR field
        later to sample the next state and
        reward given the current state
        and action: s′, r = TR(s, a) . In
        mathematical writing, MDPs are
        sometimes defined in terms of
        a tuple consisting of the various
        components of the MDP, written
    """
    y::Any # discount factor
    S::Any # state space
    A::Any # action space
    T::Any # transition function
    R::Any # reward function
    TR::Any # sample transition and reward
end







