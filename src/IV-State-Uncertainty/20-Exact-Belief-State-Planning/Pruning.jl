"""
policy represented by a set of alpha vectors Γ .
It uses one-step lookahead to produce an optimal action and associated utility. Equation (20.13) is
used to compute the lookahead.
"""

function lookahead(problem::POMDP, U, b::Vector, a)
    𝒮, 𝒪, T, O, R, γ = problem.𝒮, problem.𝒪, problem.T, problem.O, problem.R, problem.γ
    r = sum(R(s, a) * b[i] for (i, s) in enumerate(𝒮))
    Posa(o, s, a) = sum(O(a, s′, o) * T(s, a, s′) for s′ in 𝒮)
    Poba(o, b, a) = sum(b[i] * Posa(o, s, a) for (i, s) in enumerate(𝒮))
    return r + γ * sum(Poba(o, b, a) * U(update(b, problem, a, o)) for o in 𝒪)
end

function greedy(problem::POMDP, U, b::Vector)
    u, a = findmax(a -> lookahead(problem, U, b, a), problem.𝒜)
    return (a = a, u = u)
end
struct LookaheadAlphaVectorPolicy
    problem::Any # POMDP problem
    Γ::Any # alpha vectors
end
function utility(π::LookaheadAlphaVectorPolicy, b)
    return maximum(α ⋅ b for α in π.Γ)
end
function greedy(π, b)
    U(b) = utility(π, b)
    return greedy(π.problem, U, b)
end
(π::LookaheadAlphaVectorPolicy)(b) = greedy(π, b).a


"""
A method for finding the belief vector b for which
    the alpha vector α improves the
    most compared to the set of alpha
    vectors Γ . Nothing is returned if
    no such belief exists. The packages
    JuMP.jl and GLPK.jl provide a
    mathematical optimization framework and a solver for linear programs, respectively.
"""
function find_maximal_belief(α, Γ)
    m = length(α)
    if isempty(Γ)
        return fill(1 / m, m) # arbitrary belief
    end
    model = Model(GLPK.Optimizer)
    @variable(model, δ)
    @variable(model, b[i = 1:m] ≥ 0)
    @constraint(model, sum(b) == 1.0)
    for a in Γ
        @constraint(model, (α - a) ⋅ b ≥ δ)
    end
    @objective(model, Max, δ)
    optimize!(model)
    return value(δ) > 0 ? value.(b) : nothing
end

"""A method for
pruning dominated alpha vectors and associated plans. The
find_dominating function identifies all of the dominating alpha vectors in the set Γ . It uses binary vectors candidates and dominating
to track which alpha vectors are
candidates for inclusion in the
dominating set and which are currently in the dominating set, respectively.
"""
function find_dominating(Γ)
    n = length(Γ)
    candidates, dominating = trues(n), falses(n)
    while any(candidates)
        i = findfirst(candidates)
        b = find_maximal_belief(Γ[i], Γ[dominating])
        if b === nothing
            candidates[i] = false
        else
            k = argmax([candidates[j] ? b ⋅ Γ[j] : -Inf for j = 1:n])
            candidates[k], dominating[k] = false, true
        end
    end
    return dominating
end


function prune(plans, Γ)
    d = find_dominating(Γ)
    return (plans[d], Γ[d])
end
