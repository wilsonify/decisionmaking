struct BehavioralCloning
    """
    A method for
        learning a parameterized stochas        tic policy from expert demonstra        tions in the form of a set of state        action tuples D . The policy param        eterization vector θ is iteratively
        improved by maximizing the log
        likelihood of the actions given the
        states. Behavioral cloning requires
        a step size α , an iteration count
        k_max , and a log likelihood gradi        ent ∇logπ .
    """
    # step size
    α
    k_max # number of iterations
    ∇logπ # log likelihood gradient
    end
    function optimize(M::BehavioralCloning, D, θ)
    α, k_max, ∇logπ = M.α, M.k_max, M.∇logπ
    for k in 1:k_max
    ∇ = mean(∇logπ(θ, a, s) for (s,a) in D)
    θ += α*∇
    end
    return θ
    end