"""
Types and functions relevant to working with factors over a set of discrete variables.
A variable is given a name (represented as a symbol) and may take on an integer from 1 to m.
An assignment is a mapping from variable names to values represented as integers. 
A factor is defined by a factor table that assigns values to different assignments involving a set of variables.
A factor table is a mapping from assignments to real values. 
This mapping is represented by a dictionary.
Any assignments not contained in the dictionary are set to 0. 
Also included in this algorithm block are some utility functions for returning the variable names associated with a factor,
selecting a subset of an assignment, enumerating possible assignments, and normalizing factors.
As discussed in appendix, product produces the Cartesian product of a set of collections. 
It is imported from Base.Iterators .
"""
# Example joint distribution involving binary variables X, Y, and Z.

#| X | Y | Z | P(X,Y,Z) |
#|---|---|---|----------|
#| 0 | 0 | 0 | 0.08     |
#| 0 | 0 | 1 | 0.31     |
#| 0 | 1 | 0 | 0.09     |
#| 0 | 1 | 1 | 0.37     |
#| 1 | 0 | 0 | 0.01     |
#| 1 | 0 | 1 | 0.05     |
#| 1 | 1 | 0 | 0.02     |
#| 1 | 1 | 1 | 0.07     |
#

struct Variable
    name::Symbol
    m::Int # number of possible values
end

const Assignment = Dict{Symbol,Int}
const FactorTable = Dict{Assignment,Float64}

struct Factor
    vars::Vector{Variable}
    table::FactorTable
end

variablenames(ϕ::Factor) = [var.name for var in ϕ.vars]

select(a::Assignment, varnames::Vector{Symbol}) =
    Assignment(n => a[n] for n in varnames)

function assignments(vars::AbstractVector{Variable})
    names = [var.name for var in vars]
    return vec([Assignment(n => v for (n, v) in zip(names, values)) for values in product((1:v.m for v in vars)...)])
end

function normalize!(ϕ::Factor)
    z = sum(p for (a, p) in ϕ.table)
    for (a, p) in ϕ.table
        ϕ.table[a] = p / z
    end
    return ϕ
end
# We can instantiate the table from table 2.1 using the Factor type
X = Variable(:x, 2)
Y = Variable(:y, 2)
Z = Variable(:z, 2)
ϕ = Factor([X, Y, Z], FactorTable(
    Dict(pairs((x = 1, y = 1, z = 1))) => 0.08,
    Dict(pairs((x = 1, y = 1, z = 2))) => 0.31,
    Dict(pairs((x = 1, y = 2, z = 1))) => 0.09,
    Dict(pairs((x = 1, y = 2, z = 2))) => 0.37,
    Dict(pairs((x = 2, y = 1, z = 1))) => 0.01,
    Dict(pairs((x = 2, y = 1, z = 2))) => 0.05,
    Dict(pairs((x = 2, y = 2, z = 1))) => 0.02,
    Dict(pairs((x = 2, y = 2, z = 2))) => 0.07
))
println(ϕ)

