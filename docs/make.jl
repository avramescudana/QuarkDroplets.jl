using QuarkDroplets
using Documenter

makedocs(;
    modules=[QuarkDroplets],
    authors="avramescudana <avramescudana@protonmail.com> and contributors",
    repo="https://github.com/avramescudana/QuarkDroplets.jl/blob/{commit}{path}#L{line}",
    sitename="QuarkDroplets.jl",
    format=Documenter.HTML(;
        prettyurls=get(ENV, "CI", "false") == "true",
        canonical="https://avramescudana.github.io/QuarkDroplets.jl",
        assets=String[],
    ),
    pages=[
        "Home" => "index.md",
    ],
)

deploydocs(;
    repo="github.com/avramescudana/QuarkDroplets.jl",
)
