


struct AlphaVectorPolicy
    """
    n alpha vector policy is defined in terms of a set of alpha vectors Γ and an array of associated actions a . 
    Given the current belief b , 
    it will find the alpha vector that gives the highest value at that belief point. 
    It will return the associated action.
    """
    problem::Any # POMDP problem
    Γ::Any # alpha vectors
    a::Any # actions associated with alpha vectors
end
function utility(π::AlphaVectorPolicy, b)
    return maximum(α ⋅ b for α in π.Γ)
end
function (π::AlphaVectorPolicy)(b)
    i = argmax([α ⋅ b for α in π.Γ])
    return π.a[i]
end
