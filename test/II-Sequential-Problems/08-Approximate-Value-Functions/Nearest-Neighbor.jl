"""
The k-nearest neighbors method, which approximates the value of a state s based
on the k closest states in S as determined by a distance function d . 
The vector θ contains the values of the states in S . 
Greater efficiency can be achieved by using specialized data structures, 
such as kd-trees, implemented in NearestNeighbors.jl .


"""
mutable struct NearestNeighborValueFunction

    k::Any # number of neighbors
    d::Any # distance function d(s, s′)
    S::Any # set of discrete states
    θ::Any # vector of values at states in S

end

function (Uθ::NearestNeighborValueFunction)(s)
    dists = [Uθ.d(s, s′) for s′ in Uθ.S]
    ind = sortperm(dists)[1:Uθ.k]
    return mean(Uθ.θ[i] for i in ind)
end

function fit!(Uθ::NearestNeighborValueFunction, S, U)
    Uθ.θ = U
    return Uθ
end
