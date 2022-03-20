
"""
This nonlinear
program computes a Nash equilibrium for a Markov game 𝒫 .
"""
function tensorform(𝒫::MG)
    ℐ, 𝒮, 𝒜, R, T = 𝒫.ℐ, 𝒫.𝒮, 𝒫.𝒜, 𝒫.R, 𝒫.T
    ℐ′ = eachindex(ℐ)
    𝒮′ = eachindex(𝒮)
    𝒜′ = [eachindex(𝒜[i]) for i in ℐ]
    R′ = [R(s, a) for s in 𝒮, a in joint(𝒜)]
    T′ = [T(s, a, s′) for s in 𝒮, a in joint(𝒜), s′ in 𝒮]
    return ℐ′, 𝒮′, 𝒜′, R′, T′
end

function solve!(M::NashEquilibrium, 𝒫::MG)
    ℐ, 𝒮, 𝒜, R, T = tensorform(𝒫)
    𝒮′, 𝒜′, γ = 𝒫.𝒮, 𝒫.𝒜, 𝒫.γ
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
function randstep(𝒫::MG, s, a)
    s′ = rand(SetCategorical(𝒫.𝒮, [𝒫.T(s, a, s′) for s′ in 𝒫.𝒮]))
    r = 𝒫.R(s, a)
    return s′, r
end
function simulate(𝒫::MG, π, k_max, b)
    s = rand(b)
    for k = 1:k_max
        a = Tuple(πi(s)() for πi in π)
        s′, r = randstep(𝒫, s, a)
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
        agent i in an MG 𝒫 that maintains
        counts Ni of other agent action selections over time for each state
        and averages them assuming this is
        their stochastic policy. It then computes a best response to this policy and performs the corresponding utility-maximizing action.
    """
    𝒫::Any # Markov game
    i::Any # agent index
    Qi::Any # state-action value estimates
    Ni::Any # state-action counts
end
function MGFictitiousPlay(𝒫::MG, i)
    ℐ, 𝒮, 𝒜, R = 𝒫.ℐ, 𝒫.𝒮, 𝒫.𝒜, 𝒫.R
    Qi = Dict((s, a) => R(s, a)[i] for s in 𝒮 for a in joint(𝒜))
    Ni = Dict((j, s, aj) => 1.0 for j in ℐ for s in 𝒮 for aj in 𝒜[j])
    return MGFictitiousPlay(𝒫, i, Qi, Ni)
end


function (πi::MGFictitiousPlay)(s)
    𝒫, i, Qi = πi.𝒫, πi.i, πi.Qi
    ℐ, 𝒮, 𝒜, T, R, γ = 𝒫.ℐ, 𝒫.𝒮, 𝒫.𝒜, 𝒫.T, 𝒫.R, 𝒫.γ
    πi′(i, s) = SimpleGamePolicy(ai => πi.Ni[i, s, ai] for ai in 𝒜[i])
    πi′(i) = MGPolicy(s => πi′(i, s) for s in 𝒮)
    π = [πi′(i) for i in ℐ]
    U(s, π) = sum(πi.Qi[s, a] * probability(𝒫, s, π, a) for a in joint(𝒜))
    Q(s, π) = reward(𝒫, s, π, i) + γ * sum(transition(𝒫, s, π, s′) * U(s′, π) for s′ in 𝒮)
    Q(ai) = Q(s, joint(π, SimpleGamePolicy(ai), i))
    ai = argmax(Q, 𝒫.𝒜[πi.i])
    return SimpleGamePolicy(ai)
end
function update!(πi::MGFictitiousPlay, s, a, s′)
    𝒫, i, Qi = πi.𝒫, πi.i, πi.Qi
    ℐ, 𝒮, 𝒜, T, R, γ = 𝒫.ℐ, 𝒫.𝒮, 𝒫.𝒜, 𝒫.T, 𝒫.R, 𝒫.γ
    for (j, aj) in enumerate(a)
        πi.Ni[j, s, aj] += 1
    end
    πi′(i, s) = SimpleGamePolicy(ai => πi.Ni[i, s, ai] for ai in 𝒜[i])
    πi′(i) = MGPolicy(s => πi′(i, s) for s in 𝒮)
    π = [πi′(i) for i in ℐ]
    U(π, s) = sum(πi.Qi[s, a] * probability(𝒫, s, π, a) for a in joint(𝒜))
    Q(s, a) = R(s, a)[i] + γ * sum(T(s, a, s′) * U(π, s′) for s′ in 𝒮)
    for a in joint(𝒜)
        πi.Qi[s, a] = Q(s, a)
    end
end
