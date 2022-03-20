
path_to_here=@__DIR__
include("$path_to_here/factor-table.jl")
"""
A factor is defined by a factor table that assigns values to different assignments involving a set of variables.
"""

struct Factor
    vars::Vector{Variable}
    table::FactorTable
end

function normalize!(ϕ::Factor)
    z = sum(p for (a, p) in ϕ.table)
    for (a, p) in ϕ.table
        ϕ.table[a] = p / z
    end
    return ϕ
end
