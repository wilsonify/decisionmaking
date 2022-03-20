using Distributions

function infer(D::MvNormal, query, evidencevars, evidence)
    """
    Inference in a multivariate Gaussian distribution D . 
    A vector of integers specifies the query variables in the query argument, 
    and a vector of integers specifies the evidence variables in the evidence vars argument.

    The values of the evidence variables are contained in the vector evidence . 
    The Distributions.jl package defines the MvNormal distribution.
    """
    μ, Σ = D.μ, D.Σ.mat
    b, μa, μb = evidence, μ[query], μ[evidencevars]
    A = Σ[query,query]
    B = Σ[evidencevars,evidencevars]
    C = Σ[query,evidencevars]
    μ = μ[query] + C * (B\(b - μb))
    Σ = A - C * (B \ C')
    return MvNormal(μ, Σ)
    end