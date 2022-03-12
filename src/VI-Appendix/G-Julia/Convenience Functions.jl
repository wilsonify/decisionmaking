# Convenience Functions
"""
There are a few functions that allow us to more compactly specify the algorithms
in the body of this book. Julia 1.7 will support a two-argument version of findmax ,
where we can pass in a function and a collection. It returns the maximum of
the function when evaluated on the elements of the collection along with the
first maximizing element. The argmax function is similar, but it only returns the
first maximizing element. To support this in Julia 1.6, we manually extend these
functions.
"""
function Base.findmax(f::Function, xs)
    f_max = -Inf
    x_max = first(xs)
    for x in xs
        v = f(x)
        if v > f_max
            f_max, x_max = v, x
        end
    end
    return f_max, x_max
end

Base.argmax(f::Function, xs) = findmax(f, xs)[2]

@assert(findmax(x -> x^2, [0, -10, 3]) == (100, -10))
@assert(argmax(abs, [0, -10, 3]) == -10)


"""
The following functions are useful when working with dictionaries and named
tuples:
"""
Base.Dict{Symbol,V}(a::NamedTuple) where {V} =
    Dict{Symbol,V}(n => v for (n, v) in zip(keys(a), values(a)))
Base.convert(::Type{Dict{Symbol,V}}, a::NamedTuple) where {V} = Dict{Symbol,V}(a)
Base.isequal(a::Dict{Symbol,<:Any}, nt::NamedTuple) =
    length(a) == length(nt) && all(a[n] == v for (n, v) in zip(keys(nt), values(nt)))


a = Dict{Symbol,Integer}((a = 1, b = 2, c = 3))
#Dict{Symbol, Integer} with 3 entries:
#:a => 1
#:b => 2
#:c => 3
@assert(isequal(a, (a = 1, b = 2, c = 3)) == true)
@assert(isequal(a, (a = 1, c = 3, b = 2)) == true)

Dict{Dict{Symbol,Integer},Float64}((a = 1, b = 1) => 0.2, (a = 1, b = 2) => 0.8)
#Dict{Dict{Symbol, Integer}, Float64} with 2 entries:
#Dict(:a=>1, :b=>1) => 0.2
#Dict(:a=>1, :b=>2) => 0.8

"""
We define SetCategorical to represent distributions over discrete sets.
"""

struct SetCategorical{S}
    elements::Vector{S} # Set elements (could be repeated)
    distr::Categorical # Categorical distribution over set elements
    function SetCategorical(elements::AbstractVector{S}) where {S}
        weights = ones(length(elements))
        return new{S}(elements, Categorical(normalize(weights, 1)))
    end

    function SetCategorical(
        elements::AbstractVector{S},
        weights::AbstractVector{Float64},
    ) where {S}
        ℓ₁ = norm(weights, 1)
        if ℓ₁ < 1e-6 || isinf(ℓ₁)
            return SetCategorical(elements)
        end
        distr = Categorical(normalize(weights, 1))
        return new{S}(elements, distr)
    end
end


Distributions.rand(D::SetCategorical) = D.elements[rand(D.distr)]
Distributions.rand(D::SetCategorical, n::Int) = D.elements[rand(D.distr, n)]

function Distributions.pdf(D::SetCategorical, x)
    sum(e == x ? w : 0.0 for (e, w) in zip(D.elements, D.distr.p))
end

D = SetCategorical(["up", "down", "left", "right"], [0.4, 0.2, 0.3, 0.1]);
rand(D)
# "down"
rand(D, 5)
# 5-element Vector{String}: ["up","up","left","up","up"]
pdf(D, "up") # 0.3999999999999999
