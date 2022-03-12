struct ExtendedKalmanFilter
    """
    The extended
Kalman filter, an extension of the
Kalman filter to problems with
nonlinear Gaussian dynamics. The
current belief is represented by
mean μb and covariance Σb . The
problem 𝒫 specifies the nonlinear
dynamics using the mean transition dynamics function fT and
mean observation dynamics function fO . The Jacobians are obtained
using the ForwardDiff.jl package.
    """
    μb::Any # mean vector
    Σb::Any # covariance matrix
end
import ForwardDiff: jacobian
function update(b::ExtendedKalmanFilter, 𝒫, a, o)
    μb, Σb = b.μb, b.Σb
    fT, fO = 𝒫.fT, 𝒫.fO
    Σs, Σo = 𝒫.Σs, 𝒫.Σo
    # predict
    μp = fT(μb, a)
    Ts = jacobian(s -> fT(s, a), μb)
    Os = jacobian(fO, μp)
    Σp = Ts * Σb * Ts' + Σs
    # update
    K = Σp * Os' / (Os * Σp * Os' + Σo)
    μb′ = μp + K * (o - fO(μp))
    Σb′ = (I - K * Os) * Σp
    return ExtendedKalmanFilter(μb′, Σb′)
end
