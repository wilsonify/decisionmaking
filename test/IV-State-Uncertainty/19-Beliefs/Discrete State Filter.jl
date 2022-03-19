struct KalmanFilter
    """
    The Kalman filter,
which updates beliefs in the form
of Gaussian distributions. The current belief is represented by μb and
Σb , and 𝒫 contains the matrices that
define linear Gaussian dynamics
and observation model. This 𝒫 can
be defined using a composite type
or a named tuple.
    """
    μb::Any # mean vector
    Σb::Any # covariance matrix
end
function update(b::KalmanFilter, 𝒫, a, o)
    μb, Σb = b.μb, b.Σb
    Ts, Ta, Os = 𝒫.Ts, 𝒫.Ta, 𝒫.Os
    Σs, Σo = 𝒫.Σs, 𝒫.Σo
    # predict
    μp = Ts * μb + Ta * a
    Σp = Ts * Σb * Ts' + Σs
    # update
    K = Σp * Os' / (Os * Σp * Os' + Σo)
    μb′ = μp + K * (o - Os * μp)
    Σb′ = (I - K * Os) * Σp
    return KalmanFilter(μb′, Σb′)
end
