using Pkg
using DelimitedFiles

dependencies = [
    "ForwardDiff",
]

Pkg.add(dependencies)
 
writedlm("installed.txt", dependencies)