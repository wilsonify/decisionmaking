# Functions
"""
A function maps its arguments, given as a tuple, to a result that is returned.
"""
# Named Functions
"""
One way to define a named function is to use the function keyword, followed by
the name of the function and a tuple of names of arguments.
"""
function f(x, y)
    return x + y
end

"""
We can also define functions compactly using assignment form.
"""
f(x, y) = x + y;
@assert(f(3, 0.1415) == 3.1415)

# Anonymous Functions
"""
An anonymous function is not given a name, though it can be assigned to a named
variable. One way to define an anonymous function is to use the arrow operator.
"""
h = x -> x^2 + 1 # assign anonymous function with input x to a variable h (generic function with 1 method)
@assert(h(3) == 10)

g(f, a, b) = [f(a), f(b)]; # applies function f to a and b and returns array
@assert(g(h, 5, 10) == [26, 101])
@assert(g(x -> sin(x) + 1, 10, 20) == [0.4559788891106302, 1.9129452507276277])

# Callable Objects
"""
We can define a type and associate functions with it, allowing objects of that type
to be callable.
"""
(x::A)() = x.a + x.b # adding a zero-argument function to the type A defined earlier
(x::A)(y) = y * x.a + x.b # adding a single-argument function
x = A(22, 8);
@assert(x() == 30)
@assert(x(2) == 52)

# Optional Arguments
"""
We can assign a default value to an argument, making the specification of that
argument optional.
"""

f(x = 10) = x^2;
@assert(f() == 100)
@assert(f(3) == 9)

f(x, y, z = 1) = x * y + z;
@assert(f(1, 2, 3) == 6)
@assert(f(1, 2) == 3)

# Keyword Arguments
"""
Functions may use keyword arguments, which are arguments that are named
when the function is called. Keyword arguments are given after all the positional
arguments. A semicolon is placed before any keywords, separating them from
the other arguments.
"""

f(; x = 0) = x + 1;
@assert(f() == 1)
@assert(f(x = 10) == 11)

f(x, y = 10; z = 2) = (x + y) * z;
@assert(f(1) == 22)
@assert(f(2, z) == 36)
@assert(f(2, 3) == 10)
@assert(f(2, 3, z = 1) == 5)

# Dispatch
"""
The types of the arguments passed to a function can be specified using the double
colon operator. If multiple methods of the same function are provided, Julia will
execute the appropriate method. The mechanism for choosing which method to
execute is called dispatch.
"""
f(x::Int64) = x + 10;
f(x::Float64) = x + 3.1415;
@assert(f(1) == 11)
@assert(f(1.0) == 4.141500000000001)
@assert(f(1.3) == 4.4415000000000004)

"""
The method with a type signature that best matches the types of the arguments
given will be used.
"""

f(x) = 5;
f(x::Float64) = 3.1415;
@assert(f([3, 2, 1]) == 5)
@assert(f(0.00787499699) == 3.1415)

# Splatting
"""
It is often useful to splat the elements of a vector or a tuple into the arguments to
a function using the ... operator.
"""
f(x, y, z) = x + y - z;
a = [3, 1, 2];
@assert(f(a...) == 2)

b = (2, 2, 0);
@assert(f(b...) == 4)

c = ([0, 0], [1, 1]);
@assert(f([2, 2], c...) == [1, 1])
