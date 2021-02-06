function coefs(R, xroot, lroot, ϵroot, κ, norm)

    @info "Calculating coefficients..."

    energ = @. xroot*ħ/R
    j = @. lroot+ϵroot/2

    norm² = norm * norm'
    uu̅(r) = @. sphericalbessel(xroot/R*r,lroot)^2 + sphericalbessel(xroot/R*r,lroot+ϵroot)^2
    uu̅uu̅(r) = uu̅(r) * uu̅(r)' * r^2
    ∫uu̅uu̅ = quadgk.(uu̅uu̅, 0, R)[1]

    coef = @. norm²*∫uu̅uu̅/(4*π)/2
    avgcoef = sum(coef)/κ^2

    @info "Done!"
    @debug "Corresponding j: " j
    @debug "Corresponding E: " energ
    @debug "Average value of coefficients: " avgcoef

    return coef, avgcoef, energ, j

end
