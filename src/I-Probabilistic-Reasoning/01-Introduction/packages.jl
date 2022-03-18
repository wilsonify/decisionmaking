using Pkg
using DelimitedFiles

dependencies = [
    "Formatting",
]

Pkg.add(dependencies)
 
writedlm("installed.txt", dependencies)