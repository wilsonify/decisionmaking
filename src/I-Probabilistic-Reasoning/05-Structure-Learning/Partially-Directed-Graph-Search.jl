using IterTools

function are_markov_equivalent(G, H)
    """
    A method for determining whether the directed acyclic graphs G and H are Markov equivalent. 
    The subsets function from IterTools.jl returns all subsets of a given set and a specified size.
    """
    if nv(G) != nv(H) ||
       ne(G) != ne(H) ||
       !all(has_edge(H, e) || has_edge(H, reverse(e)) for e in edges(G))
        return false
    end
    for (I, J) in [(G, H), (H, G)]
        for c = 1:nv(I)
            parents = inneighbors(I, c)
            for (a, b) in subsets(parents, 2)
                if !has_edge(I, a, b) &&
                   !has_edge(I, b, a) &&
                   !(has_edge(J, a, c) && has_edge(J, b, c))
                    return false
                end
            end
        end
    end
    return true
end
