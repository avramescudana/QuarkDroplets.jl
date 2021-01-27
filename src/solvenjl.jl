function solvenjl(κ, coef, energ, j)

    println("Solving the NJL equations...")

    constant = 4*Nc*Nf*G*ħ^3
    function f!(F, x)
        for k in 1:κ
            F[k] = constant*sum([coef[k, kprime]*(2*j[kprime]+1)*x[kprime]/√(x[kprime]^2+energ[kprime]^2) for kprime in 1:κ]) - x[k]
        end
    end

    # The quark masses are initialized as having 350 [MeV]
    initial_x = 350.0*ones(κ)
    result = nlsolve(f!, initial_x)
    mass = result.zero

    println("Done!")
    println("Masses: ", mass)

    return mass

end
