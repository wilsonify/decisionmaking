"""
    A method for conducting multilinear interpolation
    to estimate the value of state vector s for known state values θ
    over a grid defined by a lowerleft vertex o and vector of widths
    δ . Vertices of the grid can all be
    written o + δ.*i for some nonnegative integral vector i . The
    package Interpolations.jl also
    provides multilinear and other interpolation methods.
"""
mutable struct MultilinearValueFunction
    o::Any # position of lower-left corner
    δ::Any # vector of widths
    θ::Any # vector of values at states in S
end




function (Uθ::MultilinearValueFunction)(s)
    o, δ, θ = Uθ.o, Uθ.δ, Uθ.θ
    Δ = (s - o) ./ δ
    # Multidimensional index of lower-left cell
    i = min.(floor.(Int, Δ) .+ 1, size(θ) .- 1)
    vertex_index = similar(i)
    d = length(s)
    u = 0.0
    for vertex = 0:2^d-1
        weight = 1.0
        for j = 1:d
            # Check whether jth bit is set
            if vertex & (1 << (j - 1)) > 0
                vertex_index[j] = i[j] + 1
                weight *= Δ[j] - i[j] + 1
            else
                vertex_index[j] = i[j]
                weight *= i[j] - Δ[j]
            end
        end
        u += θ[vertex_index...] * weight
    end
    return u
end

function fit!(Uθ::MultilinearValueFunction, S, U)
    Uθ.θ = U
    return Uθ
end



mutable struct SimplexValueFunction
    """
    A method for conducting simplex interpolation to
        estimate the value of state vector
        s for known state values θ over a
        grid defined by a lower-left vertex o and vector of widths δ . Vertices of the grid can all be written
        o + δ.*i for some non-negative integral vector i . Simplex interpolation is also implemented in the general GridInterpolations.jl package.
    """
    o::Any # position of lower-left corner
    δ::Any # vector of widths
    θ::Any # vector of values at states in S
end




function (Uθ::SimplexValueFunction)(s)
    Δ = (s - Uθ.o) ./ Uθ.δ
    # Multidimensional index of upper-right cell
    i = min.(floor.(Int, Δ) .+ 1, size(Uθ.θ) .- 1) .+ 1
    u = 0.0
    s′ = (s - (Uθ.o + Uθ.δ .* (i .- 2))) ./ Uθ.δ
    p = sortperm(s′) # increasing order
    w_tot = 0.0
    for j in p
        w = s′[j] - w_tot
        u += w * Uθ.θ[i...]
        i[j] -= 1
        w_tot += w
    end
    u += (1 - w_tot) * Uθ.θ[i...]
    return u
end

function fit!(Uθ::SimplexValueFunction, S, U)
    Uθ.θ = U
    return Uθ
end
