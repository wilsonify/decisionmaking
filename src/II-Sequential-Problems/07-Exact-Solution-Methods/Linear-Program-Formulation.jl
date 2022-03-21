using JuMP
"""
A method for
    solving a discrete MDP using a
    linear program formulation. For
    convenience in specifying the linear program, we define a function for converting an MDP into
    its tensor form, where the states
    and actions consist of integer indices, the reward function is a matrix, and the transition function is
    a three-dimensional tensor. It uses
    the JuMP.jl package for mathematical programming. The optimizer
    is set to use GLPK.jl , but others can
    be used instead. We also define the
    default solve behavior for MDPs to
    use this formulation.
"""
struct LinearProgramFormulation end

function tensorform(problem::MDP)
    𝒮, 𝒜, R, T = problem.𝒮, problem.𝒜, problem.R, problem.T
    𝒮′ = eachindex(𝒮)
    𝒜′ = eachindex(𝒜)
    R′ = [R(s, a) for s in 𝒮, a in 𝒜]
    T′ = [T(s, a, s′) for s in 𝒮, a in 𝒜, s′ in 𝒮]
    return 𝒮′, 𝒜′, R′, T′
end

solve(problem::MDP) = solve(LinearProgramFormulation(), problem)

function solve(M::LinearProgramFormulation, problem::MDP)
    𝒮, 𝒜, R, T = tensorform(problem)
    model = Model(GLPK.Optimizer)
    @variable(model, U[𝒮])
    @objective(model, Min, sum(U))
    @constraint(model, [s = 𝒮, a = 𝒜], U[s] ≥ R[s, a] + problem.γ * T[s, a, :] ⋅ U)
    optimize!(model)
    return ValueFunctionPolicy(problem, value.(U))
end
