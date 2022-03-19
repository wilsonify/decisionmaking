"""
MDP is a Markov Decision Processs.
A POMDP is an MDP with state uncertainty.

"""

struct POMDP
    """
    A data structure for POMDPs. We will use
the TRO field to sample the next
state, reward, and observation
given the current state and action:
s′, r, o = TRO(s, a) . A comprehensive package for specifying and
solving POMDPs is provided by
M. Egorov, Z. N. Sunberg, E. Balaban, T. A. Wheeler, J. K. Gupta, and
M. J. Kochenderfer, “POMDPs.jl: A
Framework for Sequential Decision
Making Under Uncertainty,” Journal of Machine Learning Research,
vol. 18, no. 26, pp. 1–5, 2017. In
mathematical writing, POMDPs
are sometimes defined in terms of
a tuple consisting of the various
components of the MDP, written
(S , A , O , T, R, O, γ ) .
    """

    γ::Any # discount factor
    𝒮::Any # state space
    𝒜::Any # action space
    𝒪::Any # observation space
    T::Any # transition function
    R::Any # reward function
    O::Any # observation function
    TRO::Any # sample transition, reward, and observation
end
