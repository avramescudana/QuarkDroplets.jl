function roots(R)

    @info "Finding the roots..."

    # Compact notation for the possible parities
    ϵ = [1 -1]
    # Maximum value for x≡k⋅R=E⋅R/ħ with Emax=Λ, which will appear as argument for the Bessel function
    xmax = Λ * R / ħ

    # Empty vector for roots and their corresponding quantum numbers l and ϵ
    xroot = Float64[]
    lroot = Int64[]
    ϵroot = Int64[]

    # Routine for finding roots, performed until no roots are found two consecutive times
    stillsearch = true
    θ = false
    li = 0
    while stillsearch
        for ϵi in ϵ
            # Boundary condition
            boundary(x) = sphericalbessel(x, li) - ϵi * sphericalbessel(x, li + ϵi)
            if (li!=0) || (ϵi!=-1)
                # Function for finding the root of the boundary condition in the interval [0,xmax]
                root = find_zeros(boundary, zero(xmax), xmax)
                @debug l, root, θ
                if isempty(root)
                    if θ
                        stillsearch=false
                    else
                        θ = true
                    end
                else
                    roots = [r for r in root]
                    append!(xroot, roots)
                    # Notice that, for a given li and ϵi, multiple roots may be found
                    append!(lroot, fill(li, length(roots)))
                    append!(ϵroot, fill(ϵi, length(roots)))
                end
            end
        end
        li = li+1
    end

    # Number of roots
    κ = length(xroot)

    @info "Done!"
    @debug "Roots found at: " xroot
    @debug "Corresponding l: " lroot
    @debug "Corresponding ϵ: " ϵroot

    return xroot, lroot, ϵroot, κ

end
