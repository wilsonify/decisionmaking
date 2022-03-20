function value_of_information(problem, query, evidence, M)
    """
    A method for decision network evaluation, which
        takes a simple problem problem, a list of
        query variables query, a dictionary
        containing observed chance variables and their values evidence,
        and an inference strategy M. The
        method returns an assignment of
        decision values that maximizes
        the expected utility, given the evidence.
    """
    φ = infer(M, problem.bn, query, evidence)
    voi = -solve(problem, evidence, M).u
    query_vars = filter(v -> v.name ∈ query, problem.chance_vars)
    for o′ in assignments(query_vars)
        oo′ = merge(evidence, o′)
        p = φ.table[o′]
        voi += p * solve(problem, oo′, M).u
    end
    return voi
end
