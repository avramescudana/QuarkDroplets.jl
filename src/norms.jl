function norms(R, xroot, lroot, ϵroot)

    @info "Computing normalization constants..."

    # Coefficient depending on ϵ which appears in the normalization constant
    function coefnorm(l, ϵ)
        if ϵ==1
            return -(l+1)
        else
            return l
        end
    end

    norm = @. 1/√(R^3*2*sphericalbessel(xroot, lroot)^2*(1+coefnorm(lroot, ϵroot)/xroot))

    @info "Done!"

    return norm

end
