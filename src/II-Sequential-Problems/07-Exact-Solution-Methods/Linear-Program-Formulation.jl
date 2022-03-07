"""
A method for
    solving a discrete MDP using a
    linear program formulation. For
    convenience in specifying the lin    ear program, we define a func    tion for converting an MDP into
    its tensor form, where the states
    and actions consist of integer in    dices, the reward function is a ma    trix, and the transition function is
    a three-dimensional tensor. It uses
    the JuMP.jl package for mathemat    ical programming. The optimizer
    is set to use GLPK.jl , but others can
    be used instead. We also define the
    default solve behavior for MDPs to
    use this formulation.
"""
struct LinearProgramFormulation end
function tensorform(𝒫::MDP)
    𝒮, 𝒜, R, T = 𝒫.𝒮, 𝒫.𝒜, 𝒫.R, 𝒫.T
    𝒮′ = eachindex(𝒮)
    𝒜′ = eachindex(𝒜)
    R′ = [R(s, a) for s in 𝒮, a in 𝒜]
    T′ = [T(s, a, s′) for s in 𝒮, a in 𝒜, s′ in 𝒮]
    return 𝒮′, 𝒜′, R′, T′
end
solve(𝒫::MDP) = solve(LinearProgramFormulation(), 𝒫)
function solve(M::LinearProgramFormulation, 𝒫::MDP)
    𝒮, 𝒜, R, T = tensorform(𝒫)
    model = Model(GLPK.Optimizer)
    @variable(model, U[𝒮])
    @objective(model, Min, sum(U))
    @constraint(model, [s = 𝒮, a = 𝒜], U[s] ≥ R[s, a] + 𝒫.γ * T[s, a, :] ⋅ U)
    optimize!(model)
    return ValueFunctionPolicy(𝒫, value.(U))
end
