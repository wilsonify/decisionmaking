using Pkg
using DelimitedFiles

dependencies = [
    "Formatting",
    "AMQPClient"
]

Pkg.add(dependencies)
 
writedlm("installed.txt", dependencies)