struct LinearQuadraticProblem
    """
    A method that computes an optimal policy for an h_max-step horizon MDP with
    stochastic linear dynamics parameterized by matrices Ts and Ta and quadratic reward parameterized by matrices Rs and Ra . 
    The method returns a vector of policies where entry h produces the optimal first action in an h-step policy.
    """
    Ts::Any # transition matrix with respect to state
    Ta::Any # transition matrix with respect to action
    Rs::Any # reward matrix with respect to state (negative semidefinite)
    Ra::Any # reward matrix with respect to action (negative definite)
    h_max::Any # horizon
end
function solve(problem::LinearQuadraticProblem)
    Ts, Ta, Rs, Ra, h_max = problem.Ts, problem.Ta, problem.Rs, problem.Ra, problem.h_max
    V = zeros(size(Rs))
    πs = Any[s->zeros(size(Ta, 2))]
    for h = 2:h_max
        V = Ts' * (V - V * Ta * ((Ta' * V * Ta + Ra) \ Ta' * V)) * Ts + Rs
        L = -(Ta' * V * Ta + Ra) \ Ta' * V * Ts
        push!(πs, s -> L * s)
    end
    return πs
end
