"""
    The unscented
    Kalman filter, an extension of the
    Kalman filter to problems with
    nonlinear Gaussian dynamics. The
    current belief is represented by
    mean μb and covariance Σb . The
    problem 𝒫 specifies the nonlinear
    dynamics using the mean tran-
    sition dynamics function fT and
    mean observation dynamics func-
    tion fO . The sigma points used in
    the unscented transforms are con-
    trolled by the spread parameter λ .
    """
struct UnscentedKalmanFilter
    μb::Any # mean vector
    Σb::Any # covariance matrix
    λ::Any # spread parameter
end



function unscented_transform(μ, Σ, f, λ, ws)
    n = length(μ)
    Δ = cholesky((n + λ) * Σ).L
    S = [μ]
    for i = 1:n
        push!(S, μ + Δ[:, i])
        push!(S, μ - Δ[:, i])
    end
    S′ = f.(S)
    μ′ = sum(w * s for (w, s) in zip(ws, S′))
    Σ′ = sum(w * (s - μ′) * (s - μ′)' for (w, s) in zip(ws, S′))
    return (μ′, Σ′, S, S′)
end

function update(b::UnscentedKalmanFilter, 𝒫, a, o)
    μb, Σb, λ = b.μb, b.Σb, b.λ
    fT, fO = 𝒫.fT, 𝒫.fO
    n = length(μb)
    ws = [λ / (n + λ); fill(1 / (2(n + λ)), 2n)]
    # predict
    μp, Σp, Sp, Sp′ = unscented_transform(μb, Σb, s -> fT(s, a), λ, ws)
    Σp += 𝒫.Σs
    # update
    μo, Σo, So, So′ = unscented_transform(μp, Σp, fO, λ, ws)
    Σo += 𝒫.Σo
    Σpo = sum(w * (s - μp) * (s′ - μo)' for (w, s, s′) in zip(ws, So, So′))
    K = Σpo / Σo
    μb′ = μp + K * (o - μo)
    Σb′ = Σp - K * Σo * K'
    return UnscentedKalmanFilter(μb′, Σb′, λ)
end
