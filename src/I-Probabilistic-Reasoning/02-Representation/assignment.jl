
"""
Types and functions relevant to working with factors over a set of discrete variables.

An assignment is a mapping from variable names to values represented as integers. 

Also included are some utility functions for returning the variable names associated with a factor,
selecting a subset of an assignment, enumerating possible assignments, and normalizing factors.
As discussed in appendix, product produces the Cartesian product of a set of collections. 
It is imported from Base.Iterators .

"""
const Assignment = Dict{Symbol,Int}

select(a::Assignment, varnames::Vector{Symbol}) = Assignment(n => a[n] for n in varnames)

function assignments(vars::AbstractVector{Variable})
    names = [var.name for var in vars]
    return vec([
        Assignment(n => v for (n, v) in zip(names, values)) for
        values in product((1:v.m for v in vars)...)
    ])
end
