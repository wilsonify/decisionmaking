struct SMILe
    """
    The SMILe algorithm for training a stochastic parameterized policy from expert demonstrations for an MDP 𝒫 .
SMILe successively mixes in new
component policies with smaller
and smaller weight, while simultaneously reducing the probability of
acting according to the expert policy. The method returns the probabilities Ps and parameterizations
θs for the component policies.
    """

    𝒫::Any # problem with unknown reward
    bc::Any     # Behavioral cloning struct
    k_max::Any # number of iterations
    m::Any     # number of rollouts per iteration
    d::Any     # rollout depth
    b::Any    # initial state distribution
    β::Any    # mixing scalar (e.g., d^-3)
    πE::Any    # expert policy
    πθ::Any    # parameterized policy
end
function optimize(M::SMILe, θ)
    𝒫, bc, k_max, m = M.𝒫, M.bc, M.k_max, M.m
    d, b, β, πE, πθ = M.d, M.b, M.β, M.πE, M.πθ
    𝒜, T = 𝒫.𝒜, 𝒫.T
    θs = []
    π = s -> πE(s)
    for k = 1:k_max
        # execute latest π to get new dataset D
        D = []
        for i = 1:m
            s = rand(b)
            for j = 1:d
                push!(D, (s, πE(s)))
                a = π(s)
                s = rand(T(s, a))
            end
        end
        # train new policy classifier
        θ = optimize(bc, D, θ)
        push!(θs, θ)
        # compute a new policy mixture
        Pπ = Categorical(normalize([(1 - β)^(i - 1) for i = 1:k], 1))
        π = s -> begin
            if rand() < (1 - β)^(k - 1)
                return πE(s)
            else
                return rand(Categorical(πθ(θs[rand(Pπ)], s)))
            end
        end
    end
    Ps = normalize([(1 - β)^(i - 1) for i = 1:k_max], 1)
    return Ps, θs
end
