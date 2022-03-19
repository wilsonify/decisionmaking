using Formatting

function foo()
    printfmt("Base.source_path() = {:s}\n", Base.source_path())
    printfmt("Base.PROGRAM_FILE = {:s}\n", Base.PROGRAM_FILE)
    printfmt("@__FILE__ = {:s}\n", @__FILE__)
    printfmt("@__DIR__ = {:s}\n", @__DIR__)
    printfmt("dirname(pwd()) = {:s}\n", dirname(pwd()))
    printfmt("splitpath(@__DIR__) = {:s}", splitpath(@__DIR__))
    return true
end
