using Pkg

if VERSION <= v"1.5"
    print("VERSION $VERSION < v1.5")
    Pkg.develop(PackageSpec(path="."))
else
    print("VERSION $VERSION >= v1.5")
    Pkg.develop(path=".")
end
