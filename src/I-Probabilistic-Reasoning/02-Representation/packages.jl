using Pkg
using DelimitedFiles

dependencies = [
    "LightGraphs",
]

Pkg.add(dependencies)
 
writedlm("installed.txt", dependencies)