using DecisionMakingAlgorithms
using Test



@testset "DecisionMakingAlgorithms.jl" begin
    
@time @safetestset "Introduction Tests" begin include("I-Probabilistic-Reasoning/01-Introduction/test_test.jl") end
#@time @safetestset "Tstops Tests" begin include("interface/ode_tstops_tests.jl") end
#@time @safetestset "Backwards Tests" begin include("interface/ode_backwards_test.jl") end
#@time @safetestset "Initdt Tests" begin include("interface/ode_initdt_tests.jl") end
#@time @safetestset "Linear Tests" begin include("interface/ode_twodimlinear_tests.jl") end
#@time @safetestset "Mass Matrix Tests" begin include("interface/mass_matrix_tests.jl") end
#@time @safetestset "Differentiation Trait Tests" begin include("interface/differentiation_traits_tests.jl") end
#@time @safetestset "Inf Tests" begin include("interface/inf_handling.jl") end

end
