
struct RandomizedPointBasedValueIteration
    """
    Randomized
    point-based
    backup,
    which
    updates the alpha vectors Γ
    associated with beliefs B for the
    𝒫 . This backup can be used in
    place of point_based_update
    """
    # set of belief points
    B::Any
    k_max::Any # maximum number of iterations
end
function update(𝒫::POMDP, M::RandomizedPointBasedValueIteration, Γ)
    Γ′, B′ = [], copy(M.B)
    while !isempty(B′)
        b = rand(B′)
        α = argmax(α -> α ⋅ b, Γ)
        α′ = backup(𝒫, Γ, b)
        if α′ ⋅ b ≥ α ⋅ b
            push!(Γ′, α′)
        else
            push!(Γ′, α)
        end
        filter!(b -> maximum(α ⋅ b for α in Γ′) < maximum(α ⋅ b for α in Γ), B′)
    end
    return Γ′
end

function solve(M::RandomizedPointBasedValueIteration, 𝒫)
    Γ = [baws_lowerbound(𝒫)]
    Γ = alphavector_iteration(𝒫, M, Γ)
    return LookaheadAlphaVectorPolicy(𝒫, Γ)
end
