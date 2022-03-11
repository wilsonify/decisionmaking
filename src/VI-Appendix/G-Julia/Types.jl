"""
Types
Julia has a variety of basic types that can represent data given as truth values,
numbers, strings, arrays, tuples, and dictionaries. Users can also define their own
types. This section explains how to use some of the basic types and how to define
new types.
"""

"""
Booleans
The Boolean type in Julia, written Bool , includes the values true and false . We
can assign these values to variables. Variable names can be any string of characters,
including Unicode, with a few restrictions.
"""
α = true
done = false
x = true
y = false; # semicolon suppresses the console output

"""
The variable name appears on the left-hand side of the equal sign; the value that
variable is to be assigned is on the right-hand side.
"""

"""
We can make assignments in the Julia console. The console, or REPL (for read,
eval, print, loop), will return a response to the expression being evaluated. The #
symbol indicates that the rest of the line is a comment.
"""
@assert(x == true)
@assert(typeof(x) == Bool)
@assert(x != y) # test for equality


# The standard Boolean operators are supported.
@assert(!x == false) # not
@assert(x && y == false) # and
@assert(x || y == true) # or

# Numbers
"""
Julia supports integer and floating point numbers as shown here:
"""
@assert(typeof(42) == Int64)
@assert(typeof(42.0) == Float64)
"""
Here, Int64 denotes a 64-bit integer, and Float64 denotes a 64-bit floating point
value. 3 We can perform the standard mathematical operations:
On 32-bit machines, an integer literal like 42 is interpreted as an Int32 .
"""

x = 4
y = 2
@assert(x == 4)
@assert(y == 2)
@assert(x + y == 6)
@assert(x - y == 2)
@assert(x * y == 8)
@assert(x / y == 2.0)
@assert(x^y == 16) # exponentiation
@assert(x % y == 0) # remainder from division
@assert(div(x, y) == 2) # truncated division returns an integer

"""
Note that the result of x / y is a Float64 , even when x and y are integers. We
can also perform these operations at the same time as an assignment. For example,
x += 1 is shorthand for x = x + 1 .
We can also make comparisons:
"""






@assert(3 > 4 == false)
@assert(3 >= 4 == false)
@assert(3 ≥ 4 == false)# unicode also works, use \ge[tab] in console
@assert(3 < 4 == true)
@assert(3 <= 4 == true)
@assert(3 ≤ 4 == true)# unicode also works, use \le[tab] in console
@assert(3 == 4 == false)
@assert(3 < 4 < 5 == true)

# Strings
"""
A string is an array of characters. Strings are not used very much in this textbook
except for reporting certain errors. An object of type String can be constructed
using " characters. For example:
"""
x = "optimal"
@assert(x == "optimal")
@assert(typeof(x) == String)

"""
Symbols
A symbol represents an identifier. It can be written using the : operator or con-
structed from strings.
"""

:A
:Battery

@assert(:A == :A)
@assert(:Battery == :Battery)
@assert(Symbol("Failure") == :Failure)

"""
Vectors
A vector is a one-dimensional array that stores a sequence of values. We can
construct a vector using square brackets, separating elements by commas.
"""

x = []; # empty vector
x = trues(3); # Boolean vector containing three trues
x = ones(3); # vector of three ones
x = zeros(3); # vector of three zeros
x = rand(3); # vector of three random numbers between 0 and 1
x = [3, 1, 4]; # vector of integers
x = [3.1415, 1.618, 2.7182]; # vector of floats

#An array comprehension can be used to create vectors.
array_comprehension = [sin(x) for x = 1:5]
@assert(
    array_comprehension == [
        0.8414709848078965,
        0.9092974268256817,
        0.1411200080598672,
        -0.7568024953079282,
        -0.9589242746631385,
    ]
)

# We can inspect the type of vectors:
@assert(typeof([3, 1, 4]) == Vector{Int64})# 1-dimensional array of Int64s
@assert(typeof([3.1415, 1.618, 2.7182]) == Vector{Float64}) # 1-dimensional array of Float64s
@assert(Vector{Float64} == Vector{Float64}) # alias for a 1-dimensional array

#We index into vectors using square brackets.
@assert(x[1]==3.1415)  # first element is indexed by 1
@assert(x[3]==2.7182)  # third element
@assert(x[end]==2.7182)  # use end to reference the end of the array
@assert(x[end-1]==1.618)  # this returns the second to last element


# We can pull out a range of elements from an array. Ranges are specified using a colon notation.
x = [1, 2, 5, 3, 1]
@assert(x==[1,2,5,3,1])
@assert(x[1:3] == [1,2,5])# pull out the first three elements
@assert(x[1:2:end] ==[1,5,1]) # pull out every other element
@assert(x[end:-1:1] == [1,3,5,2,1]) # pull out all the elements in reverse order

"""
We can perform a variety of different operations on arrays. The exclamation
mark at the end of function names is used to indicate that the function mutates
(i.e., changes) the input.
"""

@assert(length(x)==5)
@assert([x, x] == [[1, 2, 5, 3, 1],[1, 2, 5, 3, 1]]) # concatenation

push!(x, -1)
@assert(x==[1, 2, 5, 3, 1,-1])#add an element to the end
pop!(x)
@assert(x==[1, 2, 5, 3, 1])#remove an element from the end
append!(x, [2, 3])
@assert(x==[1, 2, 5, 3, 1,2,3])#append [2, 3] to the end of x
sort!(x)
@assert(x==[1,1,2,2,3,3,5])#sort the elements, altering the same vector
y=sort(x);
@assert(y==[1,1,2,2,3,3,5])#sort the elements as a new vector
x[1] = 2
@assert(x==[2,1,2,2,3,3,5])#change the first element to 2
x = [1, 2];
y = [3, 4];
@assert(x + y==[4,6])#add vectors
@assert(3x - [1, 2]==[2,4])#multiply by a scalar and subtract

using LinearAlgebra

@assert( dot(x, y) == 11)# dot product available after using LinearAlgebra
@assert( x⋅y == 11)# dot product using unicode character, use \cdot[tab] in console
@assert( prod(y) == 12) # product of all the elements in y


















