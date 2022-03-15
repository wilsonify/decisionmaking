using Pkg
using DelimitedFiles

dependencies = [
    "LightGraphs",
    "Distributions"
]

Pkg.add(dependencies)
 
writedlm("installed.txt", dependencies)