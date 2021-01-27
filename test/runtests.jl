using QuarkDroplets
using Test

@testset "QuarkDroplets.jl" begin

    R = 1.49
    println("Current radius = ",R)
    filename = string("results/", R, ".jld")
    if isfile(filename)
        println("Already there")
    else
        njlradius(R)
    end

end
