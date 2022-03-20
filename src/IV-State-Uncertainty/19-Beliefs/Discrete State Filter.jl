struct KalmanFilter
    """
    The Kalman filter,
which updates beliefs in the form
of Gaussian distributions. The current belief is represented by μb and
Σb , and problem contains the matrices that
define linear Gaussian dynamics
and observation model. This problem can
be defined using a composite type
or a named tuple.
    """
    μb::Any # mean vector
    Σb::Any # covariance matrix
end
function update(b::KalmanFilter, problem, a, o)
    μb, Σb = b.μb, b.Σb
    Ts, Ta, Os = problem.Ts, problem.Ta, problem.Os
    Σs, Σo = problem.Σs, problem.Σo
    # predict
    μp = Ts * μb + Ta * a
    Σp = Ts * Σb * Ts' + Σs
    # update
    K = Σp * Os' / (Os * Σp * Os' + Σo)
    μb′ = μp + K * (o - Os * μp)
    Σb′ = (I - K * Os) * Σp
    return KalmanFilter(μb′, Σb′)
end
