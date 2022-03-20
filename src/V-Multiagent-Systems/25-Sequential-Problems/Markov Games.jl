
struct MG
    """
    Data structure for a Markov game.
    """
    γ::Any # discount factor
    ℐ::Any # agents
    𝒮::Any # state space
    𝒜::Any # joint action space
    T::Any # transition function
    R::Any # joint reward function
end

struct MGPolicy
    """
    A Markov game
policy is a mapping from states to
simple game policies, introduced
in the previous chapter. We can
construct it by passing in a generator to construct the dictionary. The
probability a policy (either for a
Markov game or simple game) assigns to taking action ai from state
s is πi (s,ai). Functions are also
provided for computing R i ( s, π ( s ))
and T ( s ′ | s, π ( s )) . The policy evaluation function will compute a vector representing U π,i .
    """
    p::Any # dictionary mapping states to simple game policies
    MGPolicy(p::Base.Generator) = new(Dict(p))
end
(πi::MGPolicy)(s, ai) = πi.p[s](ai)
(πi::SimpleGamePolicy)(s, ai) = πi(ai)
probability(𝒫::MG, s, π, a) = prod(πj(s, aj) for (πj, aj) in zip(π, a))
reward(𝒫::MG, s, π, i) = sum(𝒫.R(s, a)[i] * probability(𝒫, s, π, a) for a in joint(𝒫.𝒜))
transition(𝒫::MG, s, π, s′) =
    sum(𝒫.T(s, a, s′) * probability(𝒫, s, π, a) for a in joint(𝒫.𝒜))
function policy_evaluation(𝒫::MG, π, i)
    𝒮, 𝒜, R, T, γ = 𝒫.𝒮, 𝒫.𝒜, 𝒫.R, 𝒫.T, 𝒫.γ
    p(s, a) = prod(πj(s, aj) for (πj, aj) in zip(π, a))
    R′ = [sum(R(s, a)[i] * p(s, a) for a in joint(𝒜)) for s in 𝒮]
    T′ = [sum(T(s, a, s′) * p(s, a) for a in joint(𝒜)) for s in 𝒮, s′ in 𝒮]
    return (I - γ * T′) \ R′
end







