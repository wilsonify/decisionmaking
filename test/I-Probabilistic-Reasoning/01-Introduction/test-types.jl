using Test
using LinearAlgebra


@testset "Basic tests" begin
    @testset "add numbers" begin
        @test 1 + 1 == 2

    end

    @testset "add strings" begin
        @test "1" * "1" == "11"
    end
end

@testset "test Types" begin
    @testset "test Booleans" begin
        α = true
        done = false
        x = true
        y = false # semicolon suppresses the console output
        @test x == true 
        @test typeof(x) == Bool
        @test x != y # test for equality
        # The standard Boolean operators are supported.
        @test !x == false # not
        @test x && y == false # and
        @test x || y == true # or    
    end

    @testset "test Numbers" begin
        x = 4
        y = 2

        @test(typeof(42) == Int64)
        @test(typeof(42.0) == Float64)
        @test(x == 4)
        @test(y == 2)
        @test(x + y == 6)
        @test(x - y == 2)
        @test(x * y == 8)
        @test(x / y == 2.0)
        @test(x^y == 16) # exponentiation
        @test(x % y == 0) # remainder from division
        @test(div(x, y) == 2) # truncated division returns an integer
        @test( (3 < 4) == true)
        @test((3 >= 4) == false)
        @test(!(3 ≥ 4) ) # unicode also works, use \le[tab] in console
        @test((3 < 4) == true)
        @test((3 <= 4) == true)
        @test((3 ≤ 4) == true)# unicode also works, use \le[tab] in console
        @test(! (3 == 4) )
        @test((3 < 4 < 5) == true)

    end
    @testset "test Strings" begin
        x = "optimal"
        @test(x == "optimal")
        @test(typeof(x) == String)
    end

    @testset "test Symbols" begin

        :A
        :Battery

        @test(:A == :A)
        @test(:Battery == :Battery)
        @test(Symbol("Failure") == :Failure)
    end

    @testset "test Vectors" begin
        x = [] # empty vector
        x = trues(3) # Boolean vector containing three trues
        x = ones(3) # vector of three ones
        x = zeros(3) # vector of three zeros
        x = rand(3) # vector of three random numbers between 0 and 1
        x = [3, 1, 4] # vector of integers
        x = [3.1415, 1.618, 2.7182] # vector of floats    
        #An array comprehension can be used to create vectors.
        array_comprehension = [sin(x) for x = 1:5]
        @test(
            array_comprehension == [
                0.8414709848078965,
                0.9092974268256817,
                0.1411200080598672,
                -0.7568024953079282,
                -0.9589242746631385,
            ]
        )

        # We can inspect the type of vectors:
        @test(typeof([3, 1, 4]) == Vector{Int64})# 1-dimensional array of Int64s
        @test(typeof([3.1415, 1.618, 2.7182]) == Vector{Float64}) # 1-dimensional array of Float64s
        @test(Vector{Float64} == Vector{Float64}) # alias for a 1-dimensional array

        #We index into vectors using square brackets.
        @test(x[1] == 3.1415)  # first element is indexed by 1
        @test(x[3] == 2.7182)  # third element
        @test(x[end] == 2.7182)  # use end to reference the end of the array
        @test(x[end-1] == 1.618)  # this returns the second to last element


        # We can pull out a range of elements from an array. Ranges are specified using a colon notation.
        x = [1, 2, 5, 3, 1]
        @test(x == [1, 2, 5, 3, 1])
        @test(x[1:3] == [1, 2, 5])# pull out the first three elements
        @test(x[1:2:end] == [1, 5, 1]) # pull out every other element
        @test(x[end:-1:1] == [1, 3, 5, 2, 1]) # pull out all the elements in reverse order

        """
        We can perform a variety of different operations on arrays. The exclamation
        mark at the end of function names is used to indicate that the function mutates
        (i.e., changes) the input.
        """

        @test(length(x) == 5)
        @test([x, x] == [[1, 2, 5, 3, 1], [1, 2, 5, 3, 1]]) # concatenation

        push!(x, -1)
        @test(x == [1, 2, 5, 3, 1, -1])#add an element to the end
        pop!(x)
        @test(x == [1, 2, 5, 3, 1])#remove an element from the end
        append!(x, [2, 3])
        @test(x == [1, 2, 5, 3, 1, 2, 3])#append [2, 3] to the end of x
        sort!(x)
        @test(x == [1, 1, 2, 2, 3, 3, 5])#sort the elements, altering the same vector
        y = sort(x)
        @test(y == [1, 1, 2, 2, 3, 3, 5])#sort the elements as a new vector
        x[1] = 2
        @test(x == [2, 1, 2, 2, 3, 3, 5])#change the first element to 2
    end
    @testset "test LinearAlgebra" begin
        x = [1, 2]
        y = [3, 4]
        @test(x + y == [4, 6])#add vectors
        @test(3x - [1, 2] == [2, 4])#multiply by a scalar and subtract        
        @test(dot(x, y) == 11)# dot product available after using LinearAlgebra
        @test(x ⋅ y == 11)# dot product using unicode character, use \cdot[tab] in console
        @test(prod(y) == 12) # product of all the elements in y    
        @test(x .* y == [3, 8]) # elementwise multiplication
        @test(x .^ 2 == [1, 4]) # elementwise squaring 
        @test(sin.(x) == [0.8414709848078965, 0.9092974268256817])# elementwise application of sin
        @test(sqrt.(x) == [1.0, 1.4142135623730951]) # elementwise application of sqrt
    end

    @testset "test Matrices" begin
        X = [1 2 3; 4 5 6; 7 8 9; 10 11 12]
        @test(typeof(X) == Matrix{Int64})  # a 2-dimensional array of Int64s
        @test(X[2] == 4) # second element using column-major ordering
        @test(X[3, 2] == 8) # element in third row and second column
        @test(X[1, :] == [1, 2, 3]) # extract the first row
        @test(X[:, 2] == [2, 5, 8, 11]) # extract the second column
        @test(X[:, 1:2] == [1 2; 4 5; 7 8; 10 11]) # extract the first two columns
        @test(X[1:2, 1:2] == [1 2; 4 5]) # extract a 2x2 submatrix from the top left of x
        @test(Matrix(1.0I, 3, 3) == [1.0 0.0 0.0; 0.0 1.0 0.0; 0.0 0.0 1.0]) # 3x3 identity matrix
        @test(Matrix(Diagonal([3, 2, 1])) == [3 0 0; 0 2 0; 0 0 1]) # 3x3 diagonal matrix with 3, 2, 1 on diagonal
        @test(zeros(3, 2) == [0.0 0.0; 0.0 0.0; 0.0 0.0]) # 3x2 matrix of zeros
        @test( size(rand(3, 2)) == (3,2) ) # 3x2 random matrix        
        @test(
            [round(sin(x + y);digits=2) for x = 1:3, y = 1:2] == [0.91 0.14; 0.14 -0.76; -0.76 -0.96]
        ) # array comprehension

        @test(X' == [1 4 7 10; 2 5 8 11; 3 6 9 12]) # complex conjugate transpose
        @test(3X .+ 2 == [5 8 11; 14 17 20; 23 26 29; 32 35 38]) # multiplying by scalar and adding scalar
        X = [1 3; 3 1] # create an invertible matrix
        @test(inv(X) == [-0.125 0.375; 0.375 -0.125]) # inversion
        @test(det(X) == -8.0) # determinant (requires LinearAlgebra)
        @test([X X] == [1 3 1 3; 3 1 3 1]) # horizontal concatenation, same as hcat(X, X)
        @test([X; X] == [1 3; 3 1; 1 3; 3 1]) # vertical concatenation, same as vcat(X, X)
        @test(sin.(X) == [0.8414709848078965 0.1411200080598672; 0.1411200080598672 0.8414709848078965]) # elementwise application of sin
        @test(map(sin, X) == [0.8414709848078965 0.1411200080598672; 0.1411200080598672 0.8414709848078965]) # elementwise application of sin
        @test(vec(X) == [1, 3, 3, 1]) # reshape an array as a vector
    end

end
