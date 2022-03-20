function sub2ind(siz, x)
    """
    A function for extracting the statistics, or counts, from a discrete data set D,
    assuming a Bayesian network with variables vars and structure G. The
    data set is an n × m matrix, where n is the number of variables and
    m is the number of data points.

    This function returns an array M of length n. 
    The ith component consists of a qi × ri matrix of counts.
    The sub2ind(siz, x) function returns a linear index into an array 
    with dimensions specified by siz given coordinates x. 
    It is used to identify which parental instantiation is relevant to a particular data point and variable.
    """
    k = vcat(1, cumprod(siz[1:end-1]))
    return dot(k, x .- 1) + 1
end

function statistics(vars, G, D::Matrix{Int})
    n = size(D, 1)
    r = [vars[i].m for i = 1:n]
    q = [prod([r[j] for j in inneighbors(G, i)]) for i = 1:n]
    M = [zeros(q[i], r[i]) for i = 1:n]
    for o in eachcol(D)
        for i = 1:n
            k = o[i]
            parents = inneighbors(G, i)
            j = 1
            if !isempty(parents)
                j = sub2ind(r[parents], o[parents])
            end
            M[i][j, k] += 1.0
        end
    end
    return M
end
