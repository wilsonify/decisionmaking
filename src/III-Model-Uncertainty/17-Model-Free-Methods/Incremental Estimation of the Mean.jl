"""
A type for main    taining an incremental estimate of
    the mean of a random variable. The
    associated type maintains a cur    rent mean value μ , a learning rate
    function α , and an iteration count m .
    Calling update! with a new value
    x updates the estimate.
"""
mutable struct IncrementalEstimate
    μ::Any # mean estimate
    α::Any # learning rate function
    m::Any # number of updates
end




function update!(model::IncrementalEstimate, x)
    model.m += 1
    model.μ += model.α(model.m) * (x - model.μ)
    return model
end
