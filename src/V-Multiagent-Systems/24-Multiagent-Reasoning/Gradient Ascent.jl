"""
An implementation of gradient ascent for an agent
i of a simple game 𝒫 . The algorithm
updates its distribution over actions incrementally following gradient ascent to improve the expected utility. The projection function from algorithm 23.6 is used
to ensure that the resulting policy
remains a valid probability distribution.
"""
mutable struct GradientAscent
    𝒫::Any # simple game
    i::Any # agent index
    t::Any # time step
    πi::Any # current policy
end
function GradientAscent(𝒫::SimpleGame, i)
    uniform() = SimpleGamePolicy(ai => 1.0 for ai in 𝒫.𝒜[i])
    return GradientAscent(𝒫, i, 1, uniform())
end
(πi::GradientAscent)() = πi.πi()
(πi::GradientAscent)(ai) = πi.πi(ai)
function update!(πi::GradientAscent, a)
    𝒫, ℐ, 𝒜i, i, t = πi.𝒫, πi.𝒫.ℐ, πi.𝒫.𝒜[πi.i], πi.i, πi.t
    jointπ(ai) = [SimpleGamePolicy(j == i ? ai : a[j]) for j in ℐ]
    r = [utility(𝒫, jointπ(ai), i) for ai in 𝒜i]
    π′ = [πi.πi(ai) for ai in 𝒜i]
    π = project_to_simplex(π′ + r / sqrt(t))
    πi.t = t + 1
    πi.πi = SimpleGamePolicy(ai => p for (ai, p) in zip(𝒜i, π))
end
