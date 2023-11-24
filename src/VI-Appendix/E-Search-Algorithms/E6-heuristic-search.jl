function heuristic_search(𝒫::Search, s, d, Uhi, U, M)
    """
    The heuristic search algorithm for solving a search problem 𝒫 starting from
    state s and searching to a maximum depth d . 
    A heuristic Uhi is used to guide the search, 
    the approximate vlaue function U is evaluated at terminal states, 
    and a transposition table M in the form of a dictionary containing depth-state 
    tuples allows the algorithm to cache values from previously explored states.
    """
    if haskey(M, (d, s))
        return M[(d, s)]
    end
    𝒜, T, R = 𝒫.𝒜(s), 𝒫.T, 𝒫.R
    if isempty(𝒜) || d ≤ 0
        best = (a = nothing, u = U(s))
    else
        best = (a = first(𝒜), u = -Inf)
        for a in sort(𝒜, by = a -> R(s, a) + Uhi(T(s, a)), rev = true)
            if R(s, a) + Uhi(T(s, a)) ≤ best.u
                break
            end
            s′ = T(s, a)
            u = R(s, a) + heuristic_search(𝒫, s′, d - 1, Uhi, U, M).u
            if u > best.u
                best = (a = a, u = u)
            end
        end
    end
    M[(d, s)] = best
    return best
end
