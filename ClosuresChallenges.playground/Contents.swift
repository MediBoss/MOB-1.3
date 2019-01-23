import UIKit
import Foundation


// Exercise 1


let dummyVar = {
    // everything here is a closure
    print("Learning Swift")
}


dummyVar() // Void -> Void

// Exercise 2

// Takes in two int and returns an int
let sum:(Int, Int) -> (Int) = { numOne, numTwo in
    return numOne + numTwo
}

let dummy_sum = sum(4,8)
print(dummy_sum)


// Exercise 3

var returnFortyTwo:() -> () = {
    return 42
}

returnFortyTwo()

// Exercise 4

let numbers = [22, 10, 42, 100, 8, 4]

var sorted_numbers = numbers.sorted(by: { $0 < $1})

print(sorted_numbers)


// Exercise 5

func stuff() -> ()->(){
    
    let message = "This is an important message"
    
    var dummy = {
        print(message)
    }
    
    return dummy
}

var i = stuff()
i()
