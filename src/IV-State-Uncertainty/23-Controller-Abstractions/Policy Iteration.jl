struct ControllerPolicyIteration
    k_max::Any
    # number of iterations
    eval_max::Any # number of evaluation iterations
end
function solve(M::ControllerPolicyIteration, 𝒫::POMDP)
    𝒜, 𝒪, k_max, eval_max = 𝒫.𝒜, 𝒫.𝒪, M.k_max, M.eval_max
    X = [1]
    ψ = Dict((x, a) => 1.0 / length(𝒜) for x in X, a in 𝒜)
    η = Dict((x, a, o, x′) => 1.0 for x in X, a in 𝒜, o in 𝒪, x′ in X)
    π = ControllerPolicy(𝒫, X, ψ, η)
    for i = 1:k_max
        prevX = copy(π.X)
        U = iterative_policy_evaluation(π, eval_max)
        policy_improvement!(π, U, prevX)
        prune!(π, U, prevX)
    end
    return π
end

"""
Policy iteration
for a POMDP 𝒫 given a fixed
number of iterations k_max and
number of policy evaluation iterations eval_max . The algorithm
iteratively applies policy evaluation (algorithm 23.2) and policy
improvement. Pruning is implemented in algorithm 23.4.
"""
function policy_improvement!(π::ControllerPolicy, U, prevX)
    𝒮, 𝒜, 𝒪 = π.𝒫.𝒮, π.𝒫.𝒜, π.𝒫.𝒪
    X, ψ, η = π.X, π.ψ, π.η
    repeatX𝒪 = fill(X, length(𝒪))
    assign𝒜X′ = vec(collect(product(𝒜, repeatX𝒪...)))
    for ax′ in assign𝒜X′
        x, a = maximum(X) + 1, ax′[1]
        push!(X, x)
        successor(o) = ax′[findfirst(isequal(o), 𝒪)+1]
        U′(o, s′) = U[successor(o), s′]
        for s in 𝒮
            U[x, s] = lookahead(π.𝒫, U′, s, a)
        end
        for a′ in 𝒜
            ψ[x, a′] = a′ == a ? 1.0 : 0.0
            for (o, x′) in product(𝒪, prevX)
                η[x, a′, o, x′] = x′ == successor(o) ? 1.0 : 0.0
            end
        end
    end
    for (x, a, o, x′) in product(X, 𝒜, 𝒪, X)
        if !haskey(η, (x, a, o, x′))
            η[x, a, o, x′] = 0.0
        end
    end
end

"""
The pruning step
of policy iteration. It reduces the
number of nodes in the current
policy π , using the utilities U computed by policy evaluation, and
the previous node list prevX . Its
first step replaces any pointwise
dominated previous nodes by their
improved nodes, marking the redundant node as now dominated.
The second step marks any newly
added nodes that are identical to
previous nodes. The third step
marks any pointwise dominated
new nodes. Finally, all marked
nodes are pruned.
"""
function prune!(π::ControllerPolicy, U, prevX)
    𝒮, 𝒜, 𝒪, X, ψ, η = π.𝒫.𝒮, π.𝒫.𝒜, π.𝒫.𝒪, π.X, π.ψ, π.η
    newX, removeX = setdiff(X, prevX), []
    # prune dominated from previous nodes
    dominated(x, x′) = all(U[x, s] ≤ U[x′, s] for s in 𝒮)
    for (x, x′) in product(prevX, newX)
        if x′ ∉ removeX && dominated(x, x′)
            for s in 𝒮
                U[x, s] = U[x′, s]
            end
            for a in 𝒜
                ψ[x, a] = ψ[x′, a]
                for (o, x′′) in product(𝒪, X)
                    η[x, a, o, x′′] = η[x′, a, o, x′′]
                end
            end
            push!(removeX, x′)
        end
    end
    # prune identical from previous nodes
    identical_action(x, x′) = all(ψ[x, a] ≈ ψ[x′, a] for a in 𝒜)
    identical_successor(x, x′) =
        all(η[x, a, o, x′′] ≈ η[x′, a, o, x′′] for a in 𝒜, o in 𝒪, x′′ in X)
    identical(x, x′) = identical_action(x, x′) && identical_successor(x, x′)
    for (x, x′) in product(prevX, newX)
        if x′ ∉ removeX && identical(x, x′)
            push!(removeX, x′)
        end
    end
    # prune dominated from new nodes
    for (x, x′) in product(X, newX)
        if x′ ∉ removeX && dominated(x′, x) && x ≠ x′
            push!(removeX, x′)
        end
    end
    # update controller
    π.X = setdiff(X, removeX)
    π.ψ = Dict(k => v for (k, v) in ψ if k[1] ∉ removeX)
    π.η = Dict(k => v for (k, v) in η if k[1] ∉ removeX)
end


