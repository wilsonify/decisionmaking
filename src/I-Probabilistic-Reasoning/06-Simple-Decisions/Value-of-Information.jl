function value_of_information(𝒫, query, evidence, M)
    """
    A method for decision network evaluation, which
        takes a simple problem 𝒫, a list of
        query variables query, a dictionary
        containing observed chance variables and their values evidence,
        and an inference strategy M. The
        method returns an assignment of
        decision values that maximizes
        the expected utility, given the evidence.
    """
    φ = infer(M, 𝒫.bn, query, evidence)
    voi = -solve(𝒫, evidence, M).u
    query_vars = filter(v -> v.name ∈ query, 𝒫.chance_vars)
    for o′ in assignments(query_vars)
        oo′ = merge(evidence, o′)
        p = φ.table[o′]
        voi += p * solve(𝒫, oo′, M).u
    end
    return voi
end
