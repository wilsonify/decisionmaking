Functions
A function maps its arguments, given as a tuple, to a result that is returned.
G.2.1
Named Functions
One way to define a named function is to use the function keyword, followed by
the name of the function and a tuple of names of arguments.
function f(x, y)
return x + y
end
We can also define functions compactly using assignment form.
julia> f(x, y) = x + y;
julia> f(3, 0.1415)
3.1415
G.2.2 Anonymous Functions
An anonymous function is not given a name, though it can be assigned to a named
variable. One way to define an anonymous function is to use the arrow operator.
julia> h = x -> x^2 + 1 # assign anonymous function with input x to a variable h
#1 (generic function with 1 method)
julia> h(3)
10
julia> g(f, a, b) = [f(a), f(b)]; # applies function f to a and b and returns array
julia> g(h, 5, 10)
2-element Vector{Int64}:
26
101
julia> g(x->sin(x)+1, 10, 20)
2-element Vector{Float64}:
0.4559788891106302
1.9129452507276277

Callable Objects
We can define a type and associate functions with it, allowing objects of that type
to be callable.
julia>
julia>
julia>
julia>
30
julia>
52
(x::A)() = x.a + x.b
# adding a zero-argument function to the type A defined earlier
(x::A)(y) = y*x.a + x.b # adding a single-argument function
x = A(22, 8);
x()
x(2)
G.2.4 Optional Arguments
We can assign a default value to an argument, making the specification of that
argument optional.
julia>
julia>
100
julia>
9
julia>
julia>
5
julia>
3
f(x=10) = x^2;
f()
f(3)
f(x, y, z=1) = x*y + z;
f(1, 2, 3)
f(1, 2)
G.2.5 Keyword Arguments
Functions may use keyword arguments, which are arguments that are named
when the function is called. Keyword arguments are given after all the positional
arguments. A semicolon is placed before any keywords, separating them from
the other arguments.
julia>
julia>
1
julia>
11
julia>
julia>
f(; x = 0) = x + 1;
f()
f(x = 10)
f(x, y = 10; z = 2) = (x + y)*z;
f(1)

22
julia> f(2, z = 3)
36
julia> f(2, 3)
10
julia> f(2, 3, z = 1)
5
G.2.6 Dispatch
The types of the arguments passed to a function can be specified using the double
colon operator. If multiple methods of the same function are provided, Julia will
execute the appropriate method. The mechanism for choosing which method to
execute is called dispatch.
julia> f(x::Int64) = x + 10;
julia> f(x::Float64) = x + 3.1415;
julia> f(1)
11
julia> f(1.0)
4.141500000000001
julia> f(1.3)
4.4415000000000004
The method with a type signature that best matches the types of the arguments
given will be used.
julia>
julia>
julia>
5
julia>
3.1415
f(x) = 5;
f(x::Float64) = 3.1415;
f([3, 2, 1])
f(0.00787499699)
G.2.7 Splatting
It is often useful to splat the elements of a vector or a tuple into the arguments to
a function using the ... operator.


    julia> f(x,y,z) = x + y - z;
    julia> a = [3, 1, 2];
    julia> f(a...)
    2
    julia> b = (2, 2, 0);
    julia> f(b...)
    4
    julia> c = ([0,0],[1,1]);
    julia> f([2,2], c...)
    2-element Vector{Int64}:
    1
    1
