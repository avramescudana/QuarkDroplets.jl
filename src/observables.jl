function observables(R, xroot, lroot, ϵroot, κ, norm, coef, energ, j, mass)

    @info "Extracting observables..."

    sinϕ = @. mass/√(energ^2+mass^2)
    cosϕ = @. √(1-sinϕ^2)
    vnjl² = @. (1-energ/√(energ^2+mass^2))/2

    # Average mass computed with vnjl² and sinϕ
    Mvavg = sum(@. mass*j*vnjl²)/sum(@. j*vnjl²)
    Msavg = sum(@. mass*j*sinϕ) / sum(@. j*sinϕ)

    # Average mass computed as an integral
    Mcoef(r) = sum(@. 1/2*(2*j+1)/(4*π)*sinϕ*norm^2*(sphericalbessel(xroot/R*r, lroot)^2+sphericalbessel(xroot/R*r, lroot+ϵroot)^2))
    M(r) = 4*Nc*Nf*G*ħ^3*Mcoef(r)
    Mint(r) = 4*π*r^2*M(r)
    Mavg = quadgk(Mint, 0, R)[1]
    Mavg = Mavg / (4*π*R^3/3)

    # Chiral condensate extracted from the radial mass
    # For dubious reasons, for certain values it returns a complex value with very small imaginary part...
    ψ̅ψ(r) = - complex(1/(2*G) * M(r))^(1/3)
    # ψ̅ψ(r) = - (1/(2*G) * M(r))^(1/3)
    ψ̅ψint(r) = 4*π*r^2*ψ̅ψ(r)
    ψ̅ψavg = quadgk(ψ̅ψint, 0, R)[1]
    ψ̅ψavg = ψ̅ψavg / (4*π*R^3/3)

    # Trying to brute force get rid of the imaginary part...
    if imag(ψ̅ψavg) != 0
        ψ̅ψavg = NaN
    else
        ψ̅ψavg = real(ψ̅ψavg)
    end

    # Radial dependence of mass
    Mr = r -> M(r)
    # Radial dependence of chiral condensate
    qq̅ = r -> ψ̅ψ(r)

    # Energy density of the chiral condensate
    ε₁ = - sum(@. j*energ*cosϕ)
    ε₂ = - sum([(coef[k₁, k₂]*sinϕ[k₁]*sinϕ[k₂]) for k₁ in 1:κ for k₂ in 1:κ])
    ε₂ = ε₂ *2*Nc*Nf*G*ħ^3
    ε = (ε₁ + ε₂) / (4*π*R^3/3)

    @info "Done!"
    @debug "Average mass: " Mavg
    @debug "Average value of chiral condensate: " ψ̅ψavg
    @debug "Energy density of a chiral pair: " ε

    return Mvavg, Msavg, Mr, Mavg, qq̅, ψ̅ψavg, ε

end
