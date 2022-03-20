
mutable struct MGGradientAscent
    """
    Gradient ascent
    for an agent i of an MG problem . The
    algorithm incrementally updates
    its distributions of actions at visited states following gradient ascent to improve the expected utility.
    The projection function from algorithm 23.6 is used to ensure that
    the resulting policy remains a valid
    probability distribution.
    """
    problem::Any # Markov game
    i::Any # agent index
    t::Any # time step
    Qi::Any # state-action value estimates
    πi::Any # current policy
end
function MGGradientAscent(problem::MG, i)
    ℐ, 𝒮, 𝒜 = problem.ℐ, problem.𝒮, problem.𝒜
    Qi = Dict((s, a) => 0.0 for s in 𝒮, a in joint(𝒜))
    uniform() = Dict(s => SimpleGamePolicy(ai => 1.0 for ai in problem.𝒜[i]) for s in 𝒮)
    return MGGradientAscent(problem, i, 1, Qi, uniform())
end

function (πi::MGGradientAscent)(s)
    𝒜i, t = πi.problem.𝒜[πi.i], πi.t
    ϵ = 1 / sqrt(t)
    πi′(ai) = ϵ / length(𝒜i) + (1 - ϵ) * πi.πi[s](ai)
    return SimpleGamePolicy(ai => πi′(ai) for ai in 𝒜i)
end
function update!(πi::MGGradientAscent, s, a, s′)
    problem, i, t, Qi = πi.problem, πi.i, πi.t, πi.Qi
    ℐ, 𝒮, 𝒜i, R, γ = problem.ℐ, problem.𝒮, problem.𝒜[πi.i], problem.R, problem.γ
    jointπ(ai) = Tuple(j == i ? ai : a[j] for j in ℐ)
    α = 1 / sqrt(t)
    Qmax = maximum(Qi[s′, jointπ(ai)] for ai in 𝒜i)
    πi.Qi[s, a] += α * (R(s, a)[i] + γ * Qmax - Qi[s, a])
    u = [Qi[s, jointπ(ai)] for ai in 𝒜i]
    π′ = [πi.πi[s](ai) for ai in 𝒜i]
    π = project_to_simplex(π′ + u / sqrt(t))
    πi.t = t + 1
    πi.πi[s] = SimpleGamePolicy(ai => p for (ai, p) in zip(𝒜i, π))
end
