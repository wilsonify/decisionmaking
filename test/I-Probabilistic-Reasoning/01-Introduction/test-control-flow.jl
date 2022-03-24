import Base.Iterators: product
import IterTools: subsets
using Test

@testset " Test Control Flow" begin
    # We can control the flow of our programs using conditional evaluation and loops.
    # This section provides some of the syntax used in the book.

    @testset " Test Conditional Evaluation" begin

        #Conditional evaluation will check the value of a Boolean expression and then
        #evaluate the appropriate block of code. One of the most common ways to do this
        #is with an if statement.
        x = 10
        y = 24132

        if x < y
            println("run this if x < y")
        elseif x > y
            println("run this if x > y")
        else
            println("run this if x == y")
        end


        #We can also use the ternary operator with its question mark and colon syntax.
        #It checks the Boolean expression before the question mark. If the expression
        #evaluates to true, then it returns what comes before the colon; otherwise it returns
        #what comes after the colon.

        f(x) = x > 0 ? x : 0
        @test f(-10) == 0
        @test f(10) == 10
    end

    @testset "test Loops" begin

        #A loop allows for repeated evaluation of expressions. One type of loop is the while
        #loop. It repeatedly evaluates a block of expressions until the specified condition
        #after the while keyword is met. The following example sums the values in the
        #array x .

        X = [1, 2, 3, 4, 6, 8, 11, 13, 16, 18]
        s = 0
        while !isempty(X)
            s += pop!(X)
        end


        #Another type of loop is the for loop. It uses the for keyword. The following
        #example will also sum over the values in the array x but will not modify x .

        X = [1, 2, 3, 4, 6, 8, 11, 13, 16, 18]
        s = 0
        for i = 1:length(X)
            s += X[i]
        end


        #The = can be substituted with in or ∈ . The following code block is equivalent.

        X = [1, 2, 3, 4, 6, 8, 11, 13, 16, 18]
        s = 0
        for y in X
            s += y
        end
    end

    @testset "test Iterators" begin

        #We can iterate over collections in contexts such as for loops and array comprehensions. To demonstrate various iterators, we will use the collect function, which
        #returns an array of all items generated by an iterator:

        X = ["feed", "sing", "ignore"]

        @test(collect(enumerate(X)) == [(1, "feed"), (2, "sing"), (3, "ignore")]) # return the count and the element
        @test(collect(eachindex(X)) == [1, 2, 3]) # equivalent to 1:length(X)

        Y = [-5, -0.5, 0.0]
        @test(collect(zip(X, Y)) == [("feed", -5.0), ("sing", -0.5), ("ignore", 0.0)]) # iterate over multiple iterators simultaneously


        @test(
            collect(subsets(X)) == [
                [],
                ["feed"],
                ["sing"],
                ["feed", "sing"],
                ["ignore"],
                ["feed", "ignore"],
                ["sing", "ignore"],
                ["feed", "sing", "ignore"],
            ]
        )# iterate over all subsets

        @test(collect(eachindex(X)) == [1, 2, 3]) # iterate over indices into a collection

        Z = [1 2; 3 4; 5 6]
        
        @test(
            collect(product(X, Y)) == [
                ("feed", -5.0) ("feed", -0.5) ("feed", 0.0)
                ("sing", -5.0) ("sing", -0.5) ("sing", 0.0)
                ("ignore", -5.0) ("ignore", -0.5) ("ignore", 0.0)
            ]
        )

        # iterate over Cartesian product of multiple iterators
    end


end
