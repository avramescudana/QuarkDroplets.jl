module QuarkDroplets

export njlradius

# Package which contains Bessel functions as besselj(ν,x)
using SpecialFunctions
# Package for obstaning the roots of a given function
using Roots
# Package for performing numerical integration
using QuadGK
# Package for solving nonlinear system of equations
using NLsolve
# Package for saving and loading results to Julia .jld files
using JLD

# Spherical bessel function of argument x and order l
function sphericalbessel(x, l)
    return √(π/2x)*besselj(l+1/2, x)
end

# Energy cutoff [MeV]
const Λ = 600
# Planck's constant [MeV⋅fm]
const ħ = 197.5
# Number of colors
const Nc = 3
# Number of flavours
const Nf = 2
# Coupling constant [MeV^(-2)] as chosen in [arXiv:hep-ph/0411128]
const G = 4.7 / 2 / Λ^2

# Solves the NJL mass gap equations for a fixed radius
include("njlradius.jl")

end
