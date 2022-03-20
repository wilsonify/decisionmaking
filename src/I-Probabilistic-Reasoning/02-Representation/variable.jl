struct Variable
    """
    A variable is given a name (represented as a symbol) and may take on an integer from 1 to m.
    """
    name::Symbol
    m::Int # number of possible values
end
