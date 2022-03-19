using Pkg
using DelimitedFiles

dependencies = [
    "Formatting",
    "LightGraphs",
    "Distributions"
]

Pkg.add(dependencies)
 
writedlm("installed.txt", dependencies)