function tab_separated_string(arr)
    result = ""
    for i in 1:length(arr)
        result = string(result, "\t", arr[i])
    end
    return result
end

function squares(arr)
    return [i^2 for i in arr]
end


function hello()
    helloArray = ["Hello", "G'day", "Shalom"]
    helloString = tab_separated_string(helloArray)

    println("There is more than one way to say hello:")
    println("\n$helloString")

end

function hello_squares()
    squares_arr = squares(0:10)
    SquaresString = tab_separated_string(squares_arr)

    println("\nThese squares are just perfect:")
    println("\n$SquaresString")
end


