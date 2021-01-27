function coefs(R, xroot, lroot, ϵroot, κ, norm)

    println("Calculating coefficients...")

    energ = @. xroot*ħ/R
    j = @. lroot+ϵroot/2

    norm² = reshape([n₁^2 * n₂^2  for n₁ in norm for n₂ in norm], (κ, κ))
    uu̅(r) = @. sphericalbessel(xroot/R*r,lroot)^2 + sphericalbessel(xroot/R*r,lroot+ϵroot)^2
    uu̅uu̅(r) = reshape([u₁ * u₂ * r^2  for u₁ in uu̅(r) for u₂ in uu̅(r)], (κ, κ))
    ∫uu̅uu̅ = quadgk.(uu̅uu̅, 0, R)[1]

    coef = @. norm²*∫uu̅uu̅/(4*π)/2
    avgcoef = sum(coef)/κ^2

    println("Done!")
    println("Corresponding j: ", j)
    println("Corresponding E: ", energ)
    println("Average value of coefficients: ", avgcoef)

    return coef, avgcoef, energ, j

end
