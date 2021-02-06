using QuarkDroplets
using Test

@testset "QuarkDroplets.jl" begin

    R = π
    filename = string("results/", R, ".jld")
    if isfile(filename)
        @info "Simulation already ran"
    else
        xroot, lroot, ϵroot, κ, norm, coef, energ, j, mass = njlradius(R)
        saveradius(R, xroot, lroot, ϵroot, κ, norm, coef, energ, j, mass)
    end
    rm(filename)

end
