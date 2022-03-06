
function infer(D::MvNormal, query, evidencevars, evidence)
    """
    Inference in a mul-
tivariate Gaussian distribution D .
A vector of integers specifies the
query variables in the query ar-
gument, and a vector of integers
specifies the evidence variables
in the evidencevars argument.
The values of the evidence vari-
ables are contained in the vector
evidence . The Distributions.jl
package defines the MvNormal dis-
tribution.
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