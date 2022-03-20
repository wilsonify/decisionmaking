
"""
This nonlinear
program computes a Nash equilibrium for a Markov game problem .
"""
function tensorform(problem::MG)
    ℐ, 𝒮, 𝒜, R, T = problem.ℐ, problem.𝒮, problem.𝒜, problem.R, problem.T
    ℐ′ = eachindex(ℐ)
    𝒮′ = eachindex(𝒮)
    𝒜′ = [eachindex(𝒜[i]) for i in ℐ]
    R′ = [R(s, a) for s in 𝒮, a in joint(𝒜)]
    T′ = [T(s, a, s′) for s in 𝒮, a in joint(𝒜), s′ in 𝒮]
    return ℐ′, 𝒮′, 𝒜′, R′, T′
end

function solve!(M::NashEquilibrium, problem::MG)
    ℐ, 𝒮, 𝒜, R, T = tensorform(problem)
    𝒮′, 𝒜′, γ = problem.𝒮, problem.𝒜, problem.γ
    model = Model(Ipopt.Optimizer)
    @variable(model, U[ℐ, 𝒮])
    @variable(model, π[i = ℐ, 𝒮, ai = 𝒜[i]] ≥ 0)
    @NLobjective(
        model,
        Min,
        sum(
            U[i, s] - sum(
                prod(π[j, s, a[j]] for j in ℐ) *
                (R[s, y][i] + γ * sum(T[s, y, s′] * U[i, s′] for s′ in 𝒮)) for
                (y, a) in enumerate(joint(𝒜))
            ) for i in ℐ, s in 𝒮
        )
    )
    @NLconstraint(
        model,
        [i = ℐ, s = 𝒮, ai = 𝒜[i]],
        U[i, s] ≥ sum(
            prod(j == i ? (a[j] == ai ? 1.0 : 0.0) : π[j, s, a[j]] for j in ℐ) *
            (R[s, y][i] + γ * sum(T[s, y, s′] * U[i, s′] for s′ in 𝒮)) for
            (y, a) in enumerate(joint(𝒜))
        )
    )
    @constraint(model, [i = ℐ, s = 𝒮], sum(π[i, s, ai] for ai in 𝒜[i]) == 1)
    optimize!(model)
    π′ = value.(π)
    πi′(i, s) = SimpleGamePolicy(𝒜′[i][ai] => π′[i, s, ai] for ai in 𝒜[i])
    πi′(i) = MGPolicy(𝒮′[s] => πi′(i, s) for s in 𝒮)
    return [πi′(i) for i in ℐ]
end

"""
Functions for taking a random step and running full
    simulations in Markov games. The
    simulate function will simulate the
    joint policy π for k_max steps starting from a state randomly sampled
    from b .
"""
function randstep(problem::MG, s, a)
    s′ = rand(SetCategorical(problem.𝒮, [problem.T(s, a, s′) for s′ in problem.𝒮]))
    r = problem.R(s, a)
    return s′, r
end
function simulate(problem::MG, π, k_max, b)
    s = rand(b)
    for k = 1:k_max
        a = Tuple(πi(s)() for πi in π)
        s′, r = randstep(problem, s, a)
        for πi in π
            update!(πi, s, a, s′)
        end
        s = s′
    end
    return π
end


mutable struct MGFictitiousPlay
    """
    Fictitious play for
        agent i in an MG problem that maintains
        counts Ni of other agent action selections over time for each state
        and averages them assuming this is
        their stochastic policy. It then computes a best response to this policy and performs the corresponding utility-maximizing action.
    """
    problem::Any # Markov game
    i::Any # agent index
    Qi::Any # state-action value estimates
    Ni::Any # state-action counts
end
function MGFictitiousPlay(problem::MG, i)
    ℐ, 𝒮, 𝒜, R = problem.ℐ, problem.𝒮, problem.𝒜, problem.R
    Qi = Dict((s, a) => R(s, a)[i] for s in 𝒮 for a in joint(𝒜))
    Ni = Dict((j, s, aj) => 1.0 for j in ℐ for s in 𝒮 for aj in 𝒜[j])
    return MGFictitiousPlay(problem, i, Qi, Ni)
end


function (πi::MGFictitiousPlay)(s)
    problem, i, Qi = πi.problem, πi.i, πi.Qi
    ℐ, 𝒮, 𝒜, T, R, γ = problem.ℐ, problem.𝒮, problem.𝒜, problem.T, problem.R, problem.γ
    πi′(i, s) = SimpleGamePolicy(ai => πi.Ni[i, s, ai] for ai in 𝒜[i])
    πi′(i) = MGPolicy(s => πi′(i, s) for s in 𝒮)
    π = [πi′(i) for i in ℐ]
    U(s, π) = sum(πi.Qi[s, a] * probability(problem, s, π, a) for a in joint(𝒜))
    Q(s, π) = reward(problem, s, π, i) + γ * sum(transition(problem, s, π, s′) * U(s′, π) for s′ in 𝒮)
    Q(ai) = Q(s, joint(π, SimpleGamePolicy(ai), i))
    ai = argmax(Q, problem.𝒜[πi.i])
    return SimpleGamePolicy(ai)
end
function update!(πi::MGFictitiousPlay, s, a, s′)
    problem, i, Qi = πi.problem, πi.i, πi.Qi
    ℐ, 𝒮, 𝒜, T, R, γ = problem.ℐ, problem.𝒮, problem.𝒜, problem.T, problem.R, problem.γ
    for (j, aj) in enumerate(a)
        πi.Ni[j, s, aj] += 1
    end
    πi′(i, s) = SimpleGamePolicy(ai => πi.Ni[i, s, ai] for ai in 𝒜[i])
    πi′(i) = MGPolicy(s => πi′(i, s) for s in 𝒮)
    π = [πi′(i) for i in ℐ]
    U(π, s) = sum(πi.Qi[s, a] * probability(problem, s, π, a) for a in joint(𝒜))
    Q(s, a) = R(s, a)[i] + γ * sum(T(s, a, s′) * U(π, s′) for s′ in 𝒮)
    for a in joint(𝒜)
        πi.Qi[s, a] = Q(s, a)
    end
end
