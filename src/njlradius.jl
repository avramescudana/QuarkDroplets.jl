# Routine for finding the roots of the boundary equation
include("roots.jl")
# Routine for computing the normalization constant of the quark wavefunction
include("norms.jl")
# Routine for evaluating the coefficients involved in the NJL mass gap equations
include("coefs.jl")
# Routine for solving the nonlinear system of differential equations, namely the NJL equations
include("solvenjl.jl")
# Routine for computing various observables
# include("observables.jl")

function njlradius(R)

    @info "Running for a fixed radius: " R

    xroot, lroot, ϵroot, κ = roots(R)
    norm = norms(R, xroot, lroot, ϵroot)
    coef, avgcoef, energ, j = coefs(R, xroot, lroot, ϵroot, κ, norm)
    mass = solvenjl(κ, coef, energ, j)
    # Mvavg, Msavg, Mr, Mavg, qq̅, ψ̅ψavg, ε = observables(R, xroot, lroot, ϵroot, κ, norm, coef, energ, j, mass)

    # @info "Done!"

    return xroot, lroot, ϵroot, κ, norm, coef, energ, j, mass

end

function saveradius(R, xroot, lroot, ϵroot, κ, norm, coef, energ, j, mass; foldername="results/")

    # @info "Saving results to file"

    # Saving the relevant results to file
    !isdir(foldername) && mkdir(foldername)
    fn = sprint(show, R, context=:compact=>true)
    filename = joinpath(foldername, "$fn.jld")
    save(filename, "xroot", xroot, "lroot", lroot, "ϵroot", ϵroot, "κ", κ, "norm", norm, "coef", coef, "energ", energ, "j", j, "mass", mass)

    # @info "Done!"

end
