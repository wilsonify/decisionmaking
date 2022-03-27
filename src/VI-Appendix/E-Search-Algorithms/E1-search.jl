
"""
In a search problem, 
we choose action a t at time t based on observing state s t , 
and then receive a reward r t . 

The action space A is the set of possible actions, 
and the state space S is the set of possible states. 
Some of the algorithms assume these sets are finite, but this is not required in general. 
The state evolves deterministically and depends only on the current state and action taken. 
We use A( s ) to denote the set of valid actions from state s. 
When there are no valid actions, 
the state is considered to be absorbing and yields zero reward for all future timesteps. 
Goal states, for example, are typically absorbing.

The deterministic state transition function T ( s, a ) gives the successor state s ′ .
The reward function R ( s, a ) gives the reward received when executing action a from state s. 
Search problems typically do not include a discount factor γ that penalizes future rewards. 
The objective is to choose a sequence of actions that maximizes the sum of rewards or return. 

"""


struct Search
    """
    The search problem data structure.
    """
    𝒮 # state space
    𝒜::Any # valid action function
    T::Any # transition function
    R::Any # reward function
end




