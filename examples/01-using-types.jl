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
@show α

done = false
@show done

x = true
@show x

y = false; # semicolon suppresses the console output
@show y

"""
The variable name appears on the left-hand side of the equal sign; the value that
variable is to be assigned is on the right-hand side. We can make assignments in the Julia console. The console, or REPL (for read,
eval, print, loop, will return a response to the expression being evaluated. The #
symbol indicates that the rest of the line is a comment.
"""

@show typeof(x)
@show x != y # test for equality


# The standard Boolean operators are supported.
@show !x #  #  false # not
@show x && y #  #  false # and
@show x || y #  #  true # or


# Numbers
"""
Julia supports integer and floating point numbers as shown here:

Here, Int64 denotes a 64-bit integer, and Float64 denotes a 64-bit floating point
value. 3 We can perform the standard mathematical operations:
On 32-bit machines, an integer literal like 42 is interpreted as an Int32 .
"""

@show 1+2

@show x^2 x/2;

@show typeof(42) # Int64

@show typeof(42.0) # Float64


x = 4
y = 2
@show x  #  4
@show y  #  2
@show x + y  #  6
@show x - y  #  2
@show x * y  #  8
@show x / y  #  2.0
@show x^y  #  16 # exponentiation
@show x % y  #  0 # remainder from division
@show div(x, y)  #  2 # truncated division returns an integer

"""
Note that the result of x / y is a Float64 , even when x and y are integers. We
can also perform these operations at the same time as an assignment. For example,
x += 1 is shorthand for x = x + 1 .
We can also make comparisons:
"""






@show 3 > 4  #  false
@show 3 >= 4  #  false
@show 3 ≥ 4  #  false# unicode also works, use \ge[tab] in console
@show 3 < 4  #  true
@show 3 <= 4  #  true
@show 3 ≤ 4  #  true# unicode also works, use \le[tab] in console
@show 3 == 4  #  false
@show 3 < 4 < 5  #  true

# Strings
"""
A string is an array of characters. Strings are not used very much in this textbook
except for reporting certain errors. An object of type String can be constructed
using " characters. For example:
"""
x = "optimal"
@show x  #  "optimal"
@show typeof(x)  #  String

"""
Symbols
A symbol represents an identifier. It can be written using the : operator or constructed from strings.
"""

:A
:Battery

@show :A  #  :A
@show :Battery  #  :Battery
@show Symbol("Failure")  #  :Failure

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
@show 
    array_comprehension #
    # [
    #    0.8414709848078965,
    #    0.9092974268256817,
    #    0.1411200080598672,
    #    -0.7568024953079282,
    #    -0.9589242746631385,
    #]


# We can inspect the type of vectors:
@show typeof([3, 1, 4])  #  Vector{Int64}# 1-dimensional array of Int64s
@show typeof([3.1415, 1.618, 2.7182])  #  Vector{Float64} # 1-dimensional array of Float64s
@show Vector{Float64}  #  Vector{Float64} # alias for a 1-dimensional array

#We index into vectors using square brackets.
@show x[1]  #  3.1415  # first element is indexed by 1
@show x[3]  #  2.7182  # third element
@show x[end]  #  2.7182  # use end to reference the end of the array
@show x[end-1]  #  1.618  # this returns the second to last element


# We can pull out a range of elements from an array. Ranges are specified using a colon notation.
x = [1, 2, 5, 3, 1]
@show x  #  [1, 2, 5, 3, 1]
@show x[1:3]  #  [1, 2, 5]# pull out the first three elements
@show x[1:2:end]  #  [1, 5, 1] # pull out every other element
@show x[end:-1:1]  #  [1, 3, 5, 2, 1] # pull out all the elements in reverse order

"""
We can perform a variety of different operations on arrays. The exclamation
mark at the end of function names is used to indicate that the function mutates
(i.e., changes) the input.
"""

@show length(x)  #  5
@show [x, x]  #  [[1, 2, 5, 3, 1], [1, 2, 5, 3, 1]] # concatenation

push!(x, -1)
@show x  #  [1, 2, 5, 3, 1, -1]#add an element to the end
pop!(x)
@show x  #  [1, 2, 5, 3, 1]#remove an element from the end
append!(x, [2, 3])
@show x  #  [1, 2, 5, 3, 1, 2, 3]#append [2, 3] to the end of x
sort!(x)
@show x  #  [1, 1, 2, 2, 3, 3, 5]#sort the elements, altering the same vector
y = sort(x);
@show y  #  [1, 1, 2, 2, 3, 3, 5]#sort the elements as a new vector
x[1] = 2
@show x  #  [2, 1, 2, 2, 3, 3, 5]#change the first element to 2
x = [1, 2];
y = [3, 4];
@show x + y  #  [4, 6] #add vectors
@show 3x - [1, 2]  #  [2, 4] #multiply by a scalar and subtract

using LinearAlgebra

@show dot(x, y)  #  11#dot product available after using LinearAlgebra
@show x ⋅ y  #  11#dot product using unicode character, use \cdot[tab] in console
@show prod(y)  #  12 # product of all the elements in y

"""
It is often useful to apply various functions elementwise to vectors. This is a
form of broadcasting. With infix operators (e.g., + , * , and ^ ), a dot is prefixed to
indicate elementwise broadcasting. With functions like sqrt and sin , the dot is
postfixed.
"""

@show x .* y  #  [3, 8] # elementwise multiplication
@show x .^ 2  #  [1, 4] # elementwise squaring 
@show sin.(x)  #  [0.8414709848078965, 0.9092974268256817]#elementwise application of sin
@show sqrt.(x)  #  [1.0, 1.4142135623730951] # elementwise application of sqrt

"""
Matrices
A matrix is a two-dimensional array. Like a vector, it is constructed using square
brackets. We use spaces to delimit elements in the same row and semicolons to
delimit rows. We can also index into the matrix and output submatrices using
ranges
"""
X = [1 2 3; 4 5 6; 7 8 9; 10 11 12];

@show typeof(X)  #  Matrix{Int64}  # a 2-dimensional array of Int64s
@show X[2]  #  4 # second element using column-major ordering
@show X[3, 2]  #  8 # element in third row and second column
@show X[1, :]  #  [1, 2, 3] # extract the first row
@show X[:, 2]  #  [2, 5, 8, 11] # extract the second column
@show X[:, 1:2]  #  [[1, 2], [4, 5], [7, 8], [10, 11]] # extract the first two columns
@show X[1:2, 1:2]  #  [[1, 2], [4, 5]] # extract a 2x2 submatrix from the top left of x

# We can also construct a variety of special matrices and use array comprehensions:

@show Matrix(1.0I, 3, 3) #  #  [[1.0, 0.0, 0.0], [0.0, 1.0, 0.0], [0.0, 0.0, 1.0]] # 3x3 identity matrix
@show Matrix(Diagonal([3, 2, 1]))  #  [[3, 0, 0], [0, 2, 0], [0, 0, 1]] # 3x3 diagonal matrix with 3, 2, 1 on diagonal
@show zeros(3, 2)  #  [[0.0, 0.0], [0.0, 0.0], [0.0, 0.0]] # 3x2 matrix of zeros
@show rand(3, 2)  #  [[0.166378, 0.463069], [0.153106, 0.411195], [0.632025, 0.111383]] # 3x2 random matrix
@show  [sin(x + y) for x = 1:3, y = 1:2]  
# [[0.909297, 0.14112], [0.14112, -0.756802]][-0.756802, -0.958924]
# array comprehension

"""
Matrix operations include the following:
"""

@show X'  #  [[1, 4, 7, 10], [2, 5, 8, 11], [3, 6, 9, 12]] # complex conjugate transpose
@show 3X .+ 2  #  [[5, 8, 11], [14, 17, 20], [23, 26, 29], [32, 35, 38]] # multiplying by scalar and adding scalar
X = [1 3; 3 1]; # create an invertible matrix
@show inv(X)  #  [[-0.125, 0.375], [0.375, -0.125]] # inversion
@show det(X)  #  -8.0 # determinant (requires LinearAlgebra)
@show [X X]  #  [[1, 3, 1, 3], [3, 1, 3, 1]] # horizontal concatenation, same as hcat(X, X)
@show [X; X]  #  [[1, 3], [3, 1], [1, 3], [3, 1]] # vertical concatenation, same as vcat(X, X)
@show sin.(X)  #  [0.841471, 0.14112], [0.14112, 0.841471] # elementwise application of sin
@show map(sin, X)  #  [[0.841471 0.14112], [0.14112, 0.841471]] # elementwise application of sin
@show vec(X)  #  [1, 3, 3, 1] # reshape an array as a vector
