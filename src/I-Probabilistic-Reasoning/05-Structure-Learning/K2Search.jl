struct K2Search
    """
    K2 search of the space of directed acyclic graphs using a specified variable ordering.
    This variable ordering imposes a topological ordering in the resulting graph. 
    The fit function takes an ordered list variables vars and a data set D. 
    The method starts with an empty graph and iteratively adds the next parent that
    maximally improves the Bayesian score.
    """
    ordering::Vector{Int} # variable ordering
end

function fit(method::K2Search, vars, D)
    G = SimpleDiGraph(length(vars))
    for (k, i) in enumerate(method.ordering[2:end])
        y = bayesian_score(vars, G, D)
        while true
            y_best, j_best = -Inf, 0
            for j in method.ordering[1:k]
                if !has_edge(G, j, i)
                    add_edge!(G, j, i)
                    y′ = bayesian_score(vars, G, D)
                    if y′ > y_best
                        y_best, j_best = y′, j
                    end
                    rem_edge!(G, j, i)
                end
            end
            if y_best > y
                y = y_best
                add_edge!(G, j_best, i)
            else
                break
            end
        end
    end
    return G
end


