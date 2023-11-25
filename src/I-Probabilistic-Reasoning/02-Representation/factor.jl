#A factor is defined by a factor table that assigns values to different assignments involving a set of variables.

struct Factor
    vars::Vector{Variable}
    table::FactorTable
end

function normalize_factor!(ϕ::Factor)
    z = sum(p for (a, p) in ϕ.table)
    for (a, p) in ϕ.table
        ϕ.table[a] = p / z
        end
    return ϕ
    end

function Base.rand(ϕ::Factor)
    """
    a method for sampling an assignment from a factor ϕ .
    """ 

    tot, p, w = 0.0, rand(), sum(values(ϕ.table))
    for (a, v) in ϕ.table
        tot += v / w
        if tot >= p
            return a
        end
    end
    return Assignment()
end

function variablenames(ϕ::Factor)
    return [var.name for var in ϕ.vars]
end 

function Base.:*(ϕ::Factor, ψ::Factor)
    """
    An implementation of the factor product,
    which constructs the factor representing the
    joint distribution of two smaller factors ϕ and ψ. 
    If we want to compute the factor product of ϕ and ψ,  we simply write ϕ*ψ .
    """

    ϕnames = variablenames(ϕ)
    ψnames = variablenames(ψ)
    ψonly = setdiff(ψ.vars, ϕ.vars)
    table = FactorTable()
    for (ϕa, ϕp) in ϕ.table
        for a in assignments(ψonly)
            a = merge(ϕa, a)
            ψa = select(a, ψnames)
            table[a] = ϕp * get(ψ.table, ψa, 0.0)
        end
    end
    vars = vcat(ϕ.vars, ψonly)
    return Factor(vars, table)
end

function marginalize(ϕ::Factor, name)
    """
    A method for marginalizing a variable named name from a factor ϕ .
    """
    table = FactorTable()
    for (a, p) in ϕ.table
        a′ = delete!(copy(a), name)
        table[a′] = get(table, a′, 0.0) + p
    end
    vars = filter(v -> v.name != name, ϕ.vars)
    return Factor(vars, table)
end

function in_scope(name, ϕ)
    """
    returns true if a variable name is within the scope of the factor ϕ .
    """
    return any(name == v.name for v in ϕ.vars)
end

function condition(ϕ::Factor, name, value)
    """
    The first takes a factor ϕ and returns a new factor
    whose table entries are consistent with the
    variable named name having value value .    
    """
    if !in_scope(name, ϕ)
        return ϕ
    end
    table = FactorTable()
    for (a, p) in ϕ.table
        if a[name] == value
            table[delete!(copy(a), name)] = p
        end
    end
    vars = filter(v -> v.name != name, ϕ.vars)
    return Factor(vars, table)
end

function conditioning(ϕ::Factor, evidence)
    """
    The second takes a factor ϕ and applies evidence in the form of a named tuple.
    """
    for (name, value) in pairs(evidence)
        ϕ = condition(ϕ, name, value)
    end
    return ϕ
end