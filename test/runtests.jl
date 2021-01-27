using QuarkDroplets
using Test

@testset "QuarkDroplets.jl" begin

    R = π
    println("Current radius = ",R)
    filename = string("results/", R, ".jld")
    if isfile(filename)
        println("Already there")
    else
        xroot, lroot, ϵroot, κ, norm, coef, energ, j, mass = njlradius(R)
        saveradius(R, xroot, lroot, ϵroot, κ, norm, coef, energ, j, mass)
    end
    rm(filename)
    
end
