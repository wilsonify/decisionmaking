using Test

struct A
    a::Int64
    b::Float64
end

#A function maps its arguments, given as a tuple, to a result that is returned.


#One way to define a named function is to use the function keyword, followed by
#the name of the function and a tuple of names of arguments.

function f1(x, y)
    return x + y
end
@show(f1(3, 0.1415)) # == 3.1415)

#We can also define functions compactly using assignment form.

f2(x, y) = x + y
@show(f2(3, 0.1415)) # == 3.1415)


#An anonymous function is not given a name, though it can be assigned to a named
#variable. One way to define an anonymous function is to use the arrow operator.

h = x -> x^2 + 1 # assign anonymous function with input x to a variable h (generic function with 1 method)
@show(h(3)) # == 10)

g(f, a, b) = [f(a), f(b)] # applies function f to a and b and returns array
@show(g(h, 5, 10)) # == [26, 101])
@show(g(x -> sin(x) + 1, 10, 20)) # == [0.4559788891106302, 1.9129452507276277])



# We can define a type and associate functions with it, allowing objects of that type to be callable.

(x::A)() = x.a + x.b # adding a zero-argument function to the type A defined earlier
(x::A)(y) = y * x.a + x.b # adding a single-argument function
x = A(22, 8)
@show(x()) # == 30)
@show(x(2)) # == 52)


# We can assign a default value to an argument, making the specification of that argument optional.

f3(x = 10) = x^2
@show(f3()) # == 100)
@show(f3(3)) # == 9)

f4(x, y, z = 1) = x * y + z
@show(f4(1, 2, 3)) # == 5)
@show(f4(1, 2)) # == 3)


#    Functions may use keyword arguments, which are arguments that are named
# when the function is called. Keyword arguments are given after all the positional
# arguments. A semicolon is placed before any keywords, separating them from
# the other arguments.

f5(; x = 0) = x + 1
@show(f5()) # == 1)
@show(f5(x = 10)) # == 11)

f6(x, y = 10; z = 2) = (x + y) * z
@show(f6(1)) # == 22)
@show(f6(2, z = 3)) # == 36)
@show(f6(2, 3)) # == 10)
@show(f6(2, 3, z = 1)) # == 5)

#    The types of the arguments passed to a function can be specified using the double
#colon operator. If multiple methods of the same function are provided, Julia will
#execute the appropriate method. The mechanism for choosing which method to
#execute is called dispatch.

f(x::Int64) = x + 10
f(x::Float64) = x + 3.1415
@show(f(1)) # == 11)
@show(f(1.0)) # == 4.141500000000001)
@show(f(1.3)) # == 4.4415000000000004)

# The method with a type signature that best matches the types of the arguments given will be used.

f(x) = 5
f(x::Float64) = 3.1415
@show(f([3, 2, 1])) # == 5)
@show(f(0.00787499699)) # == 3.1415)

# It is often useful to splat the elements of a vector or a tuple into the arguments to a function using the ... operator.

f(x, y, z) = x + y - z
a = [3, 1, 2]
@show(f(a...)) # == 2)

b = (2, 2, 0)
@show(f(b...)) # == 4)

c = ([0, 0], [1, 1])
@show(f([2, 2], c...)) # == [1, 1])
