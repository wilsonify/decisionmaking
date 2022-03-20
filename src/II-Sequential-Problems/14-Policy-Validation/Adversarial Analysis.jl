"""
Conversion to an
adversarial problem given a policy π . An adversarial agent tries to
change the outcomes of our policy
actions so as to balance minimizing our original utility and maximizing the likelihood of the trajectory. The parameter λ controls
how important it is to maximize
the likelihood of the resulting trajectory. It returns an MDP whose
transition and reward models are
represented as matrices.
"""
function adversarial(problem::MDP, π, λ)
    𝒮, 𝒜, T, R, γ = problem.𝒮, problem.𝒜, problem.T, problem.R, problem.γ
    𝒮′ = 𝒜′ = 𝒮
    R′ = zeros(length(𝒮′), length(𝒜′))
    T′ = zeros(length(𝒮′), length(𝒜′), length(𝒮′))
    for s in 𝒮′
        for a in 𝒜′
            R′[s, a] = -R(s, π(s)) + λ * log(T(s, π(s), a))
            T′[s, a, a] = 1
        end
    end
    return MDP(T′, R′, γ)
end
